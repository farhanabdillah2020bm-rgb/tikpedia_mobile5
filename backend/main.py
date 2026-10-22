import hashlib
import os
from datetime import datetime
from typing import Any

import psycopg
from dotenv import load_dotenv
from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel


load_dotenv()

DATABASE_URL = os.getenv(
    'DATABASE_URL',
    'postgresql://tikpedia:tikpedia@localhost:5432/tikpedia',
)

app = FastAPI(
    title='TIKpedia API',
    version='1.0.0',
)

# =========================================================
# CORS
# Supaya Flutter Web / Chrome bisa mengakses FastAPI
# =========================================================
app.add_middleware(
    CORSMiddleware,
    allow_origins=['*'],
    allow_credentials=False,
    allow_methods=['*'],
    allow_headers=['*'],
)


# =========================================================
# DATABASE
# =========================================================

def db():
    return psycopg.connect(DATABASE_URL)


# =========================================================
# PASSWORD
# =========================================================

def password_hash(value: str) -> str:
    return hashlib.sha256(value.encode()).hexdigest()


# =========================================================
# REQUEST MODELS
# =========================================================

class AuthBody(BaseModel):
    name: str | None = None
    email: str
    password: str


class MaterialDone(BaseModel):
    user_id: int


class QuizResult(BaseModel):
    user_id: int
    score: int
    correct_answers: int
    total_questions: int


class GameResult(BaseModel):
    user_id: int
    game_type: str
    score: int


# =========================================================
# HEALTH CHECK
# =========================================================

@app.get('/health')
def health() -> dict[str, str]:
    with db() as conn:
        conn.execute('SELECT 1')

    return {
        'status': 'ok',
    }


# =========================================================
# REGISTER
# =========================================================

@app.post('/auth/register')
def register(body: AuthBody) -> dict[str, Any]:

    if (
        not body.name
        or len(body.name.strip()) < 2
        or '@' not in body.email
        or len(body.password) < 4
    ):
        raise HTTPException(
            status_code=400,
            detail='Data registrasi tidak valid',
        )

    try:
        with db() as conn:
            row = conn.execute(
                '''
                INSERT INTO users (
                    name,
                    email,
                    password_hash
                )
                VALUES (%s, %s, %s)
                RETURNING
                    id,
                    name,
                    email,
                    xp,
                    level
                ''',
                (
                    body.name.strip(),
                    body.email.strip().lower(),
                    password_hash(body.password),
                ),
            ).fetchone()

            conn.commit()

    except psycopg.errors.UniqueViolation:
        raise HTTPException(
            status_code=409,
            detail='Email sudah terdaftar',
        )

    return {
        'user': dict(
            zip(
                [
                    'id',
                    'name',
                    'email',
                    'xp',
                    'level',
                ],
                row,
            )
        )
    }


# =========================================================
# LOGIN
# =========================================================

@app.post('/auth/login')
def login(body: AuthBody) -> dict[str, Any]:

    with db() as conn:
        row = conn.execute(
            '''
            SELECT
                id,
                name,
                email,
                xp,
                level,
                quiz_score,
                game_score
            FROM users
            WHERE email = %s
              AND password_hash = %s
            ''',
            (
                body.email.strip().lower(),
                password_hash(body.password),
            ),
        ).fetchone()

    if not row:
        raise HTTPException(
            status_code=401,
            detail='Email atau password salah',
        )

    keys = [
        'id',
        'name',
        'email',
        'xp',
        'level',
        'quiz_score',
        'game_score',
    ]

    return {
        'user': dict(zip(keys, row)),
    }


# =========================================================
# MATERIALS
# =========================================================

@app.get('/materials')
def get_materials():

    with db() as conn:
        rows = conn.execute(
            '''
            SELECT
                id,
                title,
                description,
                content,
                sort_order
            FROM materials
            ORDER BY sort_order
            '''
        ).fetchall()

    keys = [
        'id',
        'title',
        'description',
        'content',
        'sort_order',
    ]

    return [
        dict(zip(keys, row))
        for row in rows
    ]


# =========================================================
# QUIZ QUESTIONS
# =========================================================

@app.get('/quiz/questions')
def get_questions():

    with db() as conn:
        rows = conn.execute(
            '''
            SELECT
                id,
                question,
                option_a,
                option_b,
                option_c,
                option_d,
                correct_answer
            FROM quiz_questions
            ORDER BY id
            '''
        ).fetchall()

    keys = [
        'id',
        'question',
        'option_a',
        'option_b',
        'option_c',
        'option_d',
        'correct_answer',
    ]

    return [
        dict(zip(keys, row))
        for row in rows
    ]


# =========================================================
# COMPLETE MATERIAL
# =========================================================

@app.post('/progress/material/{material_id}')
def complete_material(
    material_id: int,
    body: MaterialDone,
):

    with db() as conn:

        existing = conn.execute(
            '''
            SELECT completed
            FROM material_progress
            WHERE user_id = %s
              AND material_id = %s
            ''',
            (
                body.user_id,
                material_id,
            ),
        ).fetchone()

        if existing and existing[0]:
            return {
                'message': 'already_completed',
            }

        conn.execute(
            '''
            INSERT INTO material_progress (
                user_id,
                material_id,
                completed,
                completed_at
            )
            VALUES (
                %s,
                %s,
                TRUE,
                %s
            )
            ON CONFLICT (
                user_id,
                material_id
            )
            DO UPDATE SET
                completed = TRUE,
                completed_at = EXCLUDED.completed_at
            ''',
            (
                body.user_id,
                material_id,
                datetime.now(),
            ),
        )

        conn.execute(
            '''
            UPDATE users
            SET
                xp = xp + 50,
                level = CASE
                    WHEN xp + 50 >= 1500 THEN 5
                    WHEN xp + 50 >= 1000 THEN 4
                    WHEN xp + 50 >= 750 THEN 3
                    WHEN xp + 50 >= 500 THEN 2
                    ELSE 1
                END
            WHERE id = %s
            ''',
            (body.user_id,),
        )

        conn.commit()

    return {
        'message': 'completed',
        'xp_added': 50,
    }


# =========================================================
# QUIZ RESULT
# =========================================================

@app.post('/results/quiz')
def save_quiz(body: QuizResult):

    with db() as conn:

        conn.execute(
            '''
            INSERT INTO quiz_results (
                user_id,
                score,
                correct_answers,
                total_questions
            )
            VALUES (
                %s,
                %s,
                %s,
                %s
            )
            ''',
            (
                body.user_id,
                body.score,
                body.correct_answers,
                body.total_questions,
            ),
        )

        conn.execute(
            '''
            UPDATE users
            SET
                quiz_score = %s,
                xp = xp + %s + 250,
                level = CASE
                    WHEN xp + %s + 250 >= 1500 THEN 5
                    WHEN xp + %s + 250 >= 1000 THEN 4
                    WHEN xp + %s + 250 >= 750 THEN 3
                    WHEN xp + %s + 250 >= 500 THEN 2
                    ELSE 1
                END
            WHERE id = %s
            ''',
            (
                body.score,
                body.correct_answers * 100,
                body.correct_answers * 100,
                body.correct_answers * 100,
                body.correct_answers * 100,
                body.correct_answers * 100,
                body.user_id,
            ),
        )

        conn.commit()

    return {
        'message': 'saved',
        'xp_added': body.correct_answers * 100 + 250,
    }


# =========================================================
# GAME RESULT
# =========================================================

@app.post('/results/game')
def save_game(body: GameResult):

    with db() as conn:

        conn.execute(
            '''
            INSERT INTO game_results (
                user_id,
                game_type,
                score
            )
            VALUES (
                %s,
                %s,
                %s
            )
            ''',
            (
                body.user_id,
                body.game_type,
                body.score,
            ),
        )

        conn.execute(
            '''
            UPDATE users
            SET
                game_score = GREATEST(game_score, %s),
                xp = xp + 200,
                level = CASE
                    WHEN xp + 200 >= 1500 THEN 5
                    WHEN xp + 200 >= 1000 THEN 4
                    WHEN xp + 200 >= 750 THEN 3
                    WHEN xp + 200 >= 500 THEN 2
                    ELSE 1
                END
            WHERE id = %s
            ''',
            (
                body.score,
                body.user_id,
            ),
        )

        conn.commit()

    return {
        'message': 'saved',
        'xp_added': 200,
    }


# =========================================================
# PROGRESS
# =========================================================

@app.get('/progress/{user_id}')
def progress(user_id: int):

    with db() as conn:

        user = conn.execute(
            '''
            SELECT
                id,
                name,
                email,
                xp,
                level,
                quiz_score,
                game_score
            FROM users
            WHERE id = %s
            ''',
            (user_id,),
        ).fetchone()

        completed = conn.execute(
            '''
            SELECT COUNT(*)
            FROM material_progress
            WHERE user_id = %s
              AND completed = TRUE
            ''',
            (user_id,),
        ).fetchone()[0]

    if not user:
        raise HTTPException(
            status_code=404,
            detail='User tidak ditemukan',
        )

    keys = [
        'id',
        'name',
        'email',
        'xp',
        'level',
        'quiz_score',
        'game_score',
    ]

    data = dict(zip(keys, user))

    data['completed_materials'] = completed
    data['total_materials'] = 4

    return data