-- =========================================================
-- View dan Subquery (Modul 7)
-- Proyek   : perpus_090
-- Nama     : Rico Ardiansyah
-- NIM      : 25430090
-- =========================================================

USE perpus_090;

-- =========================================================
-- A. IMPLEMENTASI VIEW
-- =========================================================
-- 1. Membuat VIEW untuk laporan peminjaman lengkap (menyederhanakan JOIN 4 tabel)
CREATE VIEW vw_laporan_peminjaman AS
SELECT 
    p.no_transaksi, 
    a.nama_anggota, 
    b.judul_buku, 
    dp.qty_pinjam,
    p.tgl_pinjam, 
    p.status_pinjam
FROM peminjaman p
INNER JOIN anggota a ON p.id_anggota = a.id_anggota
INNER JOIN detail_peminjaman dp ON p.id_peminjaman = dp.id_peminjaman
INNER JOIN buku b ON dp.id_buku = b.id_buku;

-- 2. Memanggil data dari View yang sudah dibuat (Panggil kueri ini di phpMyAdmin untuk screenshot)
SELECT * FROM vw_laporan_peminjaman;


-- =========================================================
-- B. IMPLEMENTASI SUBQUERY
-- =========================================================
-- 3. SUBQUERY (NOT IN): Mencari buku yang belum pernah dipinjam sama sekali
SELECT kode_buku, judul_buku, stok_buku 
FROM buku 
WHERE id_buku NOT IN (SELECT id_buku FROM detail_peminjaman);

-- 4. SUBQUERY (Skalar): Mencari anggota dengan transaksi peminjaman terbanyak
SELECT no_anggota, nama_anggota 
FROM anggota 
WHERE id_anggota = (
    SELECT id_anggota 
    FROM peminjaman 
    GROUP BY id_anggota 
    ORDER BY COUNT(id_peminjaman) DESC 
    LIMIT 1
);