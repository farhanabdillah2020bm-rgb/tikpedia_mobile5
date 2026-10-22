# TIKpedia Mobile

## Deskripsi Aplikasi

TIKpedia Mobile merupakan aplikasi media pembelajaran berbasis mobile yang dikembangkan untuk membantu pelajar memahami materi Teknologi Informasi dan Komunikasi (TIK) secara interaktif. Aplikasi ini dirancang agar pengguna dapat mempelajari materi, mengerjakan kuis, dan mengikuti permainan edukasi melalui perangkat Android.

TIKpedia Mobile menggabungkan materi pembelajaran dan aktivitas evaluasi dalam satu aplikasi sehingga proses belajar menjadi lebih menarik dan mudah diakses.

## Fitur Aplikasi

Fitur utama yang tersedia dalam struktur proyek TIKpedia Mobile meliputi:

1. **Login dan Registrasi** — menyediakan halaman untuk masuk dan membuat akun pengguna.
2. **Materi Pembelajaran** — menampilkan daftar materi dan detail pembelajaran TIK.
3. **Kuis** — menyediakan soal latihan dan halaman hasil kuis.
4. **Game Edukasi** — menyediakan permainan edukatif untuk mendukung proses belajar.
5. **Progress Belajar** — menampilkan perkembangan aktivitas pembelajaran pengguna.
6. **Profil Pengguna** — menampilkan informasi pengguna.
7. **Sistem Reward** — mendukung elemen gamifikasi seperti skor dan XP sesuai implementasi aplikasi.

## Teknologi yang Digunakan

- **Flutter** — pengembangan antarmuka dan aplikasi mobile.
- **Dart** — bahasa pemrograman untuk aplikasi Flutter.
- **FastAPI** — pengembangan layanan backend dan API.
- **PostgreSQL** — penyimpanan data aplikasi.
- **Docker Compose** — mendukung pengelolaan layanan backend dan database sesuai konfigurasi proyek.

## Struktur Proyek

Struktur utama repository TIKpedia Mobile adalah sebagai berikut:

```text
tikpedia_mobile1/
├── backend/
│   ├── main.py
│   ├── schema.sql
│   ├── requirements.txt
│   ├── docker-compose.yml
│   ├── .env.example
│   └── README.md
├── lib/
│   ├── core/
│   ├── data/
│   ├── models/
│   ├── screens/
│   ├── services/
│   ├── widgets/
│   ├── app.dart
│   └── main.dart
├── pubspec.yaml
├── README.md
└── SETUP_TIKPEDIA.md
```

Keterangan folder utama:

- `backend/` berisi kode backend, konfigurasi database, dan dependensi Python.
- `lib/core/` berisi konfigurasi inti aplikasi, termasuk tema.
- `lib/data/` berisi data pendukung aplikasi.
- `lib/models/` berisi model data yang digunakan aplikasi.
- `lib/screens/` berisi halaman antarmuka aplikasi.
- `lib/services/` berisi layanan aplikasi, termasuk komunikasi dengan API.
- `lib/widgets/` berisi komponen antarmuka yang digunakan kembali.
- `lib/main.dart` merupakan titik awal aplikasi Flutter.
- `pubspec.yaml` berisi konfigurasi proyek dan dependensi Flutter.

## Persyaratan Sistem

Sebelum menjalankan proyek, pastikan perangkat pengembangan sudah memiliki:

1. Flutter SDK dan Dart.
2. Android Studio atau Visual Studio Code.
3. Android Emulator atau perangkat Android.
4. Python untuk menjalankan backend.
5. PostgreSQL atau Docker jika menggunakan konfigurasi database berbasis Docker Compose.

Pastikan instalasi Flutter dapat diperiksa melalui terminal menggunakan perintah:

```bash
flutter doctor
```

## Langkah Menjalankan Aplikasi Flutter

1. Buka terminal pada direktori utama repository TIKpedia Mobile.
2. Unduh dependensi Flutter menggunakan perintah berikut:

```bash
flutter pub get
```

3. Periksa perangkat atau emulator yang tersedia:

```bash
flutter devices
```

4. Jalankan aplikasi:

```bash
flutter run
```

Pastikan emulator atau perangkat Android sudah aktif sebelum menjalankan aplikasi.

## Langkah Menjalankan Backend

Backend menggunakan FastAPI dan membutuhkan konfigurasi database jika fitur yang dijalankan mengakses PostgreSQL.

### 1. Masuk ke direktori backend

```bash
cd backend
```

### 2. Buat lingkungan virtual Python

```bash
python -m venv .venv
```

Aktifkan lingkungan virtual pada Windows PowerShell:

```powershell
.\.venv\Scripts\Activate.ps1
```

Pada macOS atau Linux:

```bash
source .venv/bin/activate
```

### 3. Pasang dependensi backend

```bash
pip install -r requirements.txt
```

### 4. Siapkan konfigurasi lingkungan

Salin file `.env.example` menjadi `.env`, kemudian sesuaikan variabel lingkungan dengan konfigurasi database dan backend yang digunakan.

Jangan mengunggah kata sandi, token, atau informasi rahasia ke repository publik.

### 5. Siapkan database

Pastikan PostgreSQL sudah berjalan dan database telah dibuat sesuai konfigurasi proyek. Terapkan skema database mengikuti petunjuk pada `backend/README.md` atau `SETUP_TIKPEDIA.md`.

### 6. Jalankan server FastAPI

Dari direktori `backend/`, jalankan:

```bash
uvicorn main:app --reload
```

Jika server berjalan dengan konfigurasi default Uvicorn, dokumentasi interaktif API dapat dibuka melalui:

`http://127.0.0.1:8000/docs`

Alamat tersebut berlaku jika server menggunakan host dan port default serta dapat diakses dari lingkungan yang digunakan.

## Konfigurasi Koneksi API

Apabila aplikasi Flutter menggunakan backend, pastikan alamat API pada konfigurasi aplikasi sesuai dengan lingkungan pengembangan.

Perlu diperhatikan bahwa alamat `localhost` pada Android Emulator tidak selalu merujuk ke komputer yang menjalankan backend. Gunakan alamat host yang sesuai dengan konfigurasi emulator atau perangkat.

Ikuti petunjuk pada `SETUP_TIKPEDIA.md` untuk konfigurasi lebih lanjut.

## Pengujian Aplikasi

Pengujian dilakukan untuk memastikan aplikasi berjalan sesuai kebutuhan. Beberapa aspek yang perlu diperiksa meliputi:

1. Aplikasi dapat dijalankan pada emulator atau perangkat Android.
2. Halaman login, registrasi, dan home dapat dibuka.
3. Materi pembelajaran dapat ditampilkan.
4. Kuis dan game edukasi dapat dijalankan sesuai implementasinya.
5. Halaman profil dan progress belajar dapat diakses.
6. Jika backend digunakan, koneksi API dan database berjalan dengan benar.
7. Data pengguna serta hasil aktivitas belajar dapat disimpan dan ditampilkan sesuai fitur yang diterapkan.

Status keberhasilan setiap pengujian perlu disesuaikan dengan hasil pengujian aktual.

## Pembagian Tanggung Jawab Tim

Pengembangan TIKpedia Mobile dilakukan secara berkelompok dengan pembagian tanggung jawab utama sebagai berikut:

- **Ferdi Candra Darmawan:** analisis, dokumentasi, dan struktur aplikasi.
- **M. Fadhill Hafizh Alqori:** pengembangan antarmuka Flutter dan halaman aplikasi.
- **Farhan Abdillah:** pengembangan backend, database, API, dan integrasi sistem.

Setiap anggota bertanggung jawab terhadap bagian pekerjaan masing-masing serta melakukan koordinasi untuk perubahan yang melibatkan beberapa bagian proyek.

## Riwayat Pengembangan

Seluruh kode program dikelola menggunakan Git dan diunggah ke repository GitHub. Perubahan dicatat melalui commit secara berkala untuk menunjukkan proses pengembangan bertahap dan kontribusi setiap anggota tim.

Commit dilakukan berdasarkan perubahan yang telah dikerjakan, dengan pesan commit yang menjelaskan tujuan perubahan secara ringkas dan jelas.

## Penutup

TIKpedia Mobile diharapkan dapat menjadi media pembelajaran TIK yang interaktif melalui kombinasi materi pembelajaran, kuis, dan game edukasi. Pengembangan selanjutnya dilakukan berdasarkan hasil pengujian dan kebutuhan pengguna.

