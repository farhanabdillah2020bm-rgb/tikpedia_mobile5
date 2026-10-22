import '../models/material_model.dart';
import '../models/quiz_model.dart';

const materials = <MaterialModel>[
  MaterialModel(
    id: 1,
    title: 'Pengertian TIK',
    description:
        'Mengenal konsep dasar Teknologi Informasi dan Komunikasi.',
    icon: '💻',
    order: 1,
    content:
        'Teknologi Informasi dan Komunikasi (TIK) adalah teknologi yang digunakan untuk mengumpulkan, mengolah, menyimpan, menyampaikan, dan bertukar informasi. TIK menggabungkan teknologi komputer, jaringan, dan komunikasi agar informasi dapat digunakan secara cepat dan efektif.',
  ),

  MaterialModel(
    id: 2,
    title: 'Komponen TIK',
    description:
        'Kenali perangkat dan unsur yang membentuk sistem TIK.',
    icon: '🧩',
    order: 2,
    content:
        'Komponen TIK meliputi perangkat keras (hardware), perangkat lunak (software), brainware atau pengguna, serta jaringan dan data. Semua komponen bekerja bersama untuk menghasilkan layanan informasi yang bermanfaat.',
  ),

  MaterialModel(
    id: 3,
    title: 'Fungsi & Manfaat TIK',
    description:
        'Pelajari bagaimana TIK membantu kegiatan sehari-hari.',
    icon: '📡',
    order: 3,
    content:
        'TIK membantu komunikasi, pendidikan, bisnis, layanan publik, pengolahan data, dan kolaborasi. Manfaat utamanya antara lain mempercepat pekerjaan, memperluas akses informasi, dan membuat komunikasi menjadi lebih mudah.',
  ),

  MaterialModel(
    id: 4,
    title: 'Perkembangan TIK',
    description:
        'Ikuti perjalanan perkembangan teknologi dari masa ke masa.',
    icon: '🚀',
    order: 4,
    content:
        'Perkembangan TIK bergerak dari komputer berukuran besar menuju perangkat mobile, internet berkecepatan tinggi, cloud computing, kecerdasan buatan, dan perangkat pintar. Perubahan ini membuat informasi semakin mudah diakses.',
  ),
];

const quizQuestions = <QuizQuestion>[
  QuizQuestion(
    id: 1,
    question: 'Apa kepanjangan dari TIK?',
    options: [
      'Teknologi Informasi dan Komunikasi',
      'Teknik Internet dan Komputer',
      'Teknologi Industri Kreatif',
      'Transmisi Informasi Komputer',
    ],
    correctIndex: 0,
  ),

  QuizQuestion(
    id: 2,
    question: 'Manakah yang termasuk perangkat keras?',
    options: [
      'Browser',
      'Keyboard',
      'Sistem operasi',
      'Aplikasi',
    ],
    correctIndex: 1,
  ),

  QuizQuestion(
    id: 3,
    question: 'Apa fungsi utama jaringan komputer?',
    options: [
      'Menghapus data',
      'Berbagi sumber daya dan informasi',
      'Mengganti hardware',
      'Mematikan komputer',
    ],
    correctIndex: 1,
  ),

  QuizQuestion(
    id: 4,
    question: 'Contoh software adalah...',
    options: [
      'Monitor',
      'Printer',
      'Pengolah kata',
      'Keyboard',
    ],
    correctIndex: 2,
  ),

  QuizQuestion(
    id: 5,
    question: 'Teknologi cloud memungkinkan pengguna...',
    options: [
      'Mengakses layanan melalui internet',
      'Menghilangkan jaringan',
      'Mengganti listrik',
      'Membuat komputer tanpa CPU',
    ],
    correctIndex: 0,
  ),

  QuizQuestion(
    id: 6,
    question: 'Internet dapat dimanfaatkan untuk...',
    options: [
      'Belajar dan berkomunikasi',
      'Menghapus semua informasi',
      'Menghentikan jaringan',
      'Mengurangi fungsi perangkat',
    ],
    correctIndex: 0,
  ),

  QuizQuestion(
    id: 7,
    question: 'Brainware adalah...',
    options: [
      'Kabel jaringan',
      'Program komputer',
      'Manusia yang menggunakan sistem',
      'Media penyimpanan',
    ],
    correctIndex: 2,
  ),

  QuizQuestion(
    id: 8,
    question: 'Manfaat TIK dalam pendidikan adalah...',
    options: [
      'Mempersempit sumber belajar',
      'Memudahkan akses materi',
      'Menghilangkan komunikasi',
      'Membatasi kolaborasi',
    ],
    correctIndex: 1,
  ),

  QuizQuestion(
    id: 9,
    question: 'Contoh perkembangan TIK modern adalah...',
    options: [
      'Cloud computing',
      'Mesin ketik manual',
      'Surat kertas saja',
      'Papan tulis saja',
    ],
    correctIndex: 0,
  ),

  QuizQuestion(
    id: 10,
    question:
        'Salah satu manfaat TIK dalam kehidupan sehari-hari adalah...',
    options: [
      'Memperlambat komunikasi',
      'Mempercepat pertukaran informasi',
      'Mengurangi akses data',
      'Menghilangkan kolaborasi',
    ],
    correctIndex: 1,
  ),
];