CREATE TABLE IF NOT EXISTS users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(150) UNIQUE NOT NULL,
  password_hash VARCHAR(64) NOT NULL,
  xp INTEGER NOT NULL DEFAULT 0,
  level INTEGER NOT NULL DEFAULT 1,
  quiz_score INTEGER NOT NULL DEFAULT 0,
  game_score INTEGER NOT NULL DEFAULT 0,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS materials (
  id SERIAL PRIMARY KEY,
  title VARCHAR(150) NOT NULL,
  description TEXT NOT NULL,
  content TEXT NOT NULL,
  sort_order INTEGER NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS material_progress (
  id SERIAL PRIMARY KEY,
  user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  material_id INTEGER NOT NULL REFERENCES materials(id) ON DELETE CASCADE,
  completed BOOLEAN NOT NULL DEFAULT FALSE,
  completed_at TIMESTAMP,
  UNIQUE(user_id, material_id)
);

CREATE TABLE IF NOT EXISTS quiz_questions (
  id SERIAL PRIMARY KEY,
  question TEXT NOT NULL,
  option_a TEXT NOT NULL,
  option_b TEXT NOT NULL,
  option_c TEXT NOT NULL,
  option_d TEXT NOT NULL,
  correct_answer INTEGER NOT NULL CHECK (correct_answer BETWEEN 0 AND 3)
);

CREATE TABLE IF NOT EXISTS quiz_results (
  id SERIAL PRIMARY KEY,
  user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  score INTEGER NOT NULL,
  correct_answers INTEGER NOT NULL,
  total_questions INTEGER NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS game_results (
  id SERIAL PRIMARY KEY,
  user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  game_type VARCHAR(50) NOT NULL,
  score INTEGER NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO materials (title, description, content, sort_order) VALUES
('Pengertian TIK','Mengenal konsep dasar Teknologi Informasi dan Komunikasi.','Teknologi Informasi dan Komunikasi adalah teknologi untuk mengumpulkan, mengolah, menyimpan, menyampaikan, dan bertukar informasi.',1),
('Komponen TIK','Kenali perangkat dan unsur pembentuk sistem TIK.','Komponen TIK meliputi hardware, software, brainware, jaringan, dan data.',2),
('Fungsi & Manfaat TIK','Pelajari bagaimana TIK membantu kegiatan sehari-hari.','TIK membantu komunikasi, pendidikan, bisnis, layanan publik, pengolahan data, dan kolaborasi.',3),
('Perkembangan TIK','Ikuti perjalanan perkembangan teknologi.','TIK berkembang dari komputer besar menuju perangkat mobile, internet cepat, cloud, AI, dan perangkat pintar.',4)
ON CONFLICT DO NOTHING;


INSERT INTO quiz_questions (question, option_a, option_b, option_c, option_d, correct_answer) VALUES
('Apa kepanjangan dari TIK?','Teknologi Informasi dan Komunikasi','Teknik Internet dan Komputer','Teknologi Industri Kreatif','Transmisi Informasi Komputer',0),
('Manakah yang termasuk perangkat keras?','Browser','Keyboard','Sistem operasi','Aplikasi',1),
('Apa fungsi utama jaringan komputer?','Menghapus data','Berbagi sumber daya dan informasi','Mengganti hardware','Mematikan komputer',1),
('Contoh software adalah...','Monitor','Printer','Pengolah kata','Keyboard',2),
('Teknologi cloud memungkinkan pengguna...','Mengakses layanan melalui internet','Menghilangkan jaringan','Mengganti listrik','Membuat komputer tanpa CPU',0),
('Internet dapat dimanfaatkan untuk...','Belajar dan berkomunikasi','Menghapus semua informasi','Menghentikan jaringan','Mengurangi fungsi perangkat',0),
('Brainware adalah...','Kabel jaringan','Program komputer','Manusia yang menggunakan sistem','Media penyimpanan',2),
('Manfaat TIK dalam pendidikan adalah...','Mempersempit sumber belajar','Memudahkan akses materi','Menghilangkan komunikasi','Membatasi kolaborasi',1),
('Contoh perkembangan TIK modern adalah...','Cloud computing','Mesin ketik manual','Surat kertas saja','Papan tulis saja',0),
('Salah satu manfaat TIK dalam kehidupan sehari-hari adalah...','Memperlambat komunikasi','Mempercepat pertukaran informasi','Mengurangi akses data','Menghilangkan kolaborasi',1)
ON CONFLICT DO NOTHING;