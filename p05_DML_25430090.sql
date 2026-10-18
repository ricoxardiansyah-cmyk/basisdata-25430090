-- =========================================================
-- Manipulasi Data Basis Data Perpustakaan (Modul 5)
-- Proyek   : perpus_090
-- Nama     : Rico Ardiansyah
-- NIM      : 25430090
-- =========================================================

USE perpus_090;

-- 1. INSERT Data Master: Anggota
INSERT INTO anggota (no_anggota, nim_anggota, nama_anggota, alamat_anggota, no_hp_anggota, status_anggota, tgl_gabung) VALUES
('KOP-0001', '25430090', 'Rico Ardiansyah', 'Jl. Ki Hajar Dewantara, Metro', '081234567890', 'Aktif', '2026-08-15'),
('KOP-0002', '25430115', 'Daniel Subing', 'Jl. Mawar No. 12, Metro', '082298765432', 'Aktif', '2026-09-01'),
('KOP-0003', '25430200', 'Budi Santoso', 'Jl. Melati No. 5, Lampung Tengah', '081355557777', 'Nonaktif', '2026-01-10');

-- 2. INSERT Data Master: Buku
INSERT INTO buku (kode_buku, judul_buku, penulis, penerbit, tahun_terbit, stok_buku) VALUES
('BK-001', 'Sistem Basis Data', 'Fathansyah', 'Informatika', 2018, 5),
('BK-002', 'Pemrograman Web dengan PHP', 'Budi Raharjo', 'Informatika', 2020, 3),
('BK-003', 'Algoritma dan Pemrograman', 'Rinaldi Munir', 'Informatika', 2016, 7),
('BK-004', 'Kecerdasan Buatan', 'Suyanto', 'Andi Offset', 2019, 2);

-- 3. INSERT Data Master: Petugas
INSERT INTO petugas (kode_petugas, nama_petugas, jabatan) VALUES
('PTG-01', 'Siska Amelia', 'Pustakawan Utama'),
('PTG-02', 'Andi Wirawan', 'Staf Administrasi');

-- 4. INSERT Data Transaksi: Peminjaman (Header)
-- Memasukkan transaksi untuk Rico (id_anggota = 1) dan Daniel (id_anggota = 2)
INSERT INTO peminjaman (no_transaksi, id_anggota, id_petugas, tgl_pinjam, tgl_jatuh_tempo, status_pinjam) VALUES
('TR-2610-001', 1, 1, '2026-10-01 09:00:00', '2026-10-08', 'Dipinjam'),
('TR-2610-002', 2, 2, '2026-10-05 14:30:00', '2026-10-12', 'Kembali');

-- 5. INSERT Data Transaksi: Detail Peminjaman (Item)
-- Transaksi 1: Rico meminjam buku BK-001 dan BK-002
INSERT INTO detail_peminjaman (id_peminjaman, id_buku, qty_pinjam) VALUES
(1, 1, 1),
(1, 2, 1);

-- Transaksi 2: Daniel meminjam buku BK-003
INSERT INTO detail_peminjaman (id_peminjaman, id_buku, qty_pinjam) VALUES
(2, 3, 1);

-- 6. INSERT Data Penyelesaian: Pengembalian
-- Transaksi 2 sudah dikembalikan tepat waktu oleh Daniel
INSERT INTO pengembalian (id_peminjaman, id_petugas, tgl_dikembalikan, denda_keterlambatan) VALUES
(2, 2, '2026-10-10 10:00:00', 0.00);

-- =========================================================
-- PERINTAH UPDATE DAN DELETE (Manipulasi Data)
-- =========================================================

-- UPDATE: Mengurangi stok buku karena dipinjam (Contoh untuk BK-001)
UPDATE buku SET stok_buku = stok_buku - 1 WHERE id_buku = 1;

-- UPDATE: Memperbarui nomor HP anggota
UPDATE anggota SET no_hp_anggota = '081299998888' WHERE nim_anggota = '25430090';

-- DELETE: Menghapus buku yang sudah tidak layak pakai atau hilang (Contoh buku BK-004 yang belum pernah dipinjam)
DELETE FROM buku WHERE kode_buku = 'BK-004';

-- =========================================================
-- PERINTAH SELECT (Verifikasi Data)
-- =========================================================
-- Melihat seluruh data anggota aktif
SELECT * FROM anggota WHERE status_anggota = 'Aktif';

-- Melihat detail buku yang sedang dipinjam beserta jumlahnya
SELECT * FROM detail_peminjaman;