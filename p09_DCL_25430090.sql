-- =========================================================
-- Data Control Language & Keamanan (Modul 9)
-- Proyek   : perpus_090
-- Nama     : Rico Ardiansyah
-- NIM      : 25430090
-- =========================================================

-- =========================================================
-- A. PEMBUATAN USER BARU
-- =========================================================
-- Membuat akun pengguna baru untuk staf perpustakaan dengan kata sandi 'rahasia123'
CREATE USER 'staf_perpus'@'localhost' IDENTIFIED BY 'rahasia123';

-- =========================================================
-- B. GRANT (MEMBERIKAN HAK AKSES)
-- =========================================================
-- Memberikan hak akses hanya untuk membaca (SELECT), menambah (INSERT), dan mengubah (UPDATE)
-- Staf tidak diberikan hak untuk DELETE (menghapus data) atau DROP (menghapus tabel)
GRANT SELECT, INSERT, UPDATE ON perpus_090.* TO 'staf_perpus'@'localhost';

-- Menyegarkan hak akses agar segera berlaku di server MySQL
FLUSH PRIVILEGES;

-- =========================================================
-- C. REVOKE (MENCABUT HAK AKSES)
-- =========================================================
-- Skenario: Ternyata staf tidak diizinkan mengubah data (UPDATE) buku secara langsung.
-- Maka hak akses UPDATE dicabut kembali.
REVOKE UPDATE ON perpus_090.* FROM 'staf_perpus'@'localhost';
FLUSH PRIVILEGES;

-- =========================================================
-- D. VERIFIKASI (Melihat Hak Akses User)
-- =========================================================
-- Menampilkan daftar hak akses apa saja yang saat ini dimiliki oleh user staf_perpus
SHOW GRANTS FOR 'staf_perpus'@'localhost';