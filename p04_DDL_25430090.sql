-- =========================================================
-- Skema Fisik Basis Data Perpustakaan (Modul 4)
-- Proyek   : perpus_090
-- Nama     : Rico Ardiansyah
-- NIM      : 25430090
-- =========================================================

-- 1. Membuat Database
CREATE DATABASE IF NOT EXISTS perpus_090;
USE perpus_090;

-- 2. Membuat Tabel Anggota
CREATE TABLE anggota (
    id_anggota INT AUTO_INCREMENT PRIMARY KEY,
    no_anggota CHAR(8) NOT NULL UNIQUE,
    nim_anggota VARCHAR(15) NOT NULL UNIQUE,
    nama_anggota VARCHAR(100) NOT NULL,
    alamat_anggota VARCHAR(150),
    no_hp_anggota VARCHAR(15),
    status_anggota ENUM('Aktif', 'Nonaktif') DEFAULT 'Aktif',
    tgl_gabung DATE NOT NULL
);

-- 3. Membuat Tabel Buku
CREATE TABLE buku (
    id_buku INT AUTO_INCREMENT PRIMARY KEY,
    kode_buku CHAR(10) NOT NULL UNIQUE,
    judul_buku VARCHAR(150) NOT NULL,
    penulis VARCHAR(100) NOT NULL,
    penerbit VARCHAR(100),
    tahun_terbit YEAR,
    stok_buku INT NOT NULL CHECK (stok_buku >= 0)
);

-- 4. Membuat Tabel Petugas
CREATE TABLE petugas (
    id_petugas SMALLINT AUTO_INCREMENT PRIMARY KEY,
    kode_petugas CHAR(6) NOT NULL UNIQUE,
    nama_petugas VARCHAR(100) NOT NULL,
    jabatan VARCHAR(50) NOT NULL
);

-- 5. Membuat Tabel Peminjaman (Header)
CREATE TABLE peminjaman (
    id_peminjaman INT AUTO_INCREMENT PRIMARY KEY,
    no_transaksi CHAR(15) NOT NULL UNIQUE,
    id_anggota INT NOT NULL,
    id_petugas SMALLINT NOT NULL,
    tgl_pinjam DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    tgl_jatuh_tempo DATE NOT NULL,
    status_pinjam ENUM('Dipinjam', 'Kembali', 'Terlambat') DEFAULT 'Dipinjam',
    FOREIGN KEY (id_anggota) REFERENCES anggota(id_anggota) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (id_petugas) REFERENCES petugas(id_petugas) ON UPDATE CASCADE ON DELETE RESTRICT
);

-- 6. Membuat Tabel Detail Peminjaman (Tabel Perantara / Item)
CREATE TABLE detail_peminjaman (
    id_peminjaman INT NOT NULL,
    id_buku INT NOT NULL,
    qty_pinjam SMALLINT NOT NULL DEFAULT 1,
    PRIMARY KEY (id_peminjaman, id_buku),
    FOREIGN KEY (id_peminjaman) REFERENCES peminjaman(id_peminjaman) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (id_buku) REFERENCES buku(id_buku) ON UPDATE CASCADE ON DELETE RESTRICT
);

-- 7. Membuat Tabel Pengembalian
CREATE TABLE pengembalian (
    id_pengembalian INT AUTO_INCREMENT PRIMARY KEY,
    id_peminjaman INT NOT NULL UNIQUE,
    id_petugas SMALLINT NOT NULL,
    tgl_dikembalikan DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    denda_keterlambatan DECIMAL(10,2) DEFAULT 0.00,
    FOREIGN KEY (id_peminjaman) REFERENCES peminjaman(id_peminjaman) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (id_petugas) REFERENCES petugas(id_petugas) ON UPDATE CASCADE ON DELETE RESTRICT
);