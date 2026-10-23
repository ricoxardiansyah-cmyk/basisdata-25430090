-- =========================================================
-- Kueri Lanjut dan JOIN (Modul 6)
-- Proyek   : perpus_090
-- Nama     : Rico Ardiansyah
-- NIM      : 25430090
-- =========================================================

USE perpus_090;

-- 1. Menampilkan detail peminjaman lengkap (INNER JOIN 3 Tabel)
-- Menggabungkan tabel peminjaman, anggota, dan petugas untuk melihat siapa meminjam dan dilayani siapa.
SELECT 
    p.no_transaksi, 
    a.nama_anggota, 
    pt.nama_petugas, 
    p.tgl_pinjam, 
    p.status_pinjam
FROM peminjaman p
INNER JOIN anggota a ON p.id_anggota = a.id_anggota
INNER JOIN petugas pt ON p.id_petugas = pt.id_petugas;

-- 2. Menampilkan riwayat buku yang dipinjam beserta judulnya (INNER JOIN detail_peminjaman)
SELECT 
    p.no_transaksi, 
    b.judul_buku, 
    dp.qty_pinjam
FROM detail_peminjaman dp
INNER JOIN peminjaman p ON dp.id_peminjaman = p.id_peminjaman
INNER JOIN buku b ON dp.id_buku = b.id_buku;

-- 3. (KI-02) Daftar buku yang paling sering dipinjam (GROUP BY & ORDER BY)
SELECT 
    b.kode_buku, 
    b.judul_buku, 
    SUM(dp.qty_pinjam) AS total_dipinjam
FROM buku b
LEFT JOIN detail_peminjaman dp ON b.id_buku = dp.id_buku
GROUP BY b.id_buku
ORDER BY total_dipinjam DESC;

-- 4. (KI-03) Daftar anggota yang terlambat (Filter tanggal dan status)
SELECT 
    a.nama_anggota, 
    p.no_transaksi, 
    p.tgl_jatuh_tempo, 
    DATEDIFF(CURRENT_DATE, p.tgl_jatuh_tempo) AS hari_terlambat
FROM peminjaman p
INNER JOIN anggota a ON p.id_anggota = a.id_anggota
WHERE p.status_pinjam = 'Dipinjam' AND p.tgl_jatuh_tempo < CURRENT_DATE;

-- 5. (KI-04) Total pendapatan denda perpustakaan (Agregasi SUM)
SELECT 
    SUM(denda_keterlambatan) AS total_pendapatan_denda
FROM pengembalian;

-- 6. Menampilkan semua buku, termasuk yang belum pernah dipinjam (LEFT JOIN)
SELECT 
    b.kode_buku, 
    b.judul_buku, 
    dp.id_peminjaman
FROM buku b
LEFT JOIN detail_peminjaman dp ON b.id_buku = dp.id_buku;