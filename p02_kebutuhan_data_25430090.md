# Laporan Modul 2: Dokumen Kebutuhan Data
**Mata Kuliah:** Praktikum Basis Data  
**Topik:** Sistem Informasi Perpustakaan (`perpus_090`)  
**NIM:** 25430090  

---

## 1. Latar Belakang dan Aktivitas Organisasi
Perpustakaan Cendekia melayani civitas akademika dalam peminjaman buku dan pengelolaan koleksi literatur. Selama ini pencatatan manual sering menimbulkan kendala seperti keterlambatan pengembalian tanpa perhitungan denda yang transparan serta kesulitan penelusuran riwayat peminjaman buku oleh anggota. Sistem basis data ini dirancang untuk mengotomatisasi pendaftaran anggota, pengelolaan katalog, transaksi peminjaman, pengembalian, dan pencatatan denda.

## 2. Aktor dan Proses Bisnis
| Kode | Proses Bisnis | Aktor | Pemicu |
| :--- | :--- | :--- | :--- |
| **PB-01** | Mendaftarkan Anggota | Petugas Perpustakaan | Mahasiswa mendaftar sebagai anggota baru |
| **PB-02** | Pencatatan Peminjaman Buku | Petugas Perpustakaan | Anggota meminjam buku di perpustakaan |
| **PB-03** | Pengembalian Buku & Hitung Denda | Petugas Perpustakaan | Anggota mengembalikan buku |
| **PB-04** | Pengadaan/Pembelian Buku Baru | Pengelola/Pustakawan | Penambahan stok katalog buku baru |
| **PB-05** | Penyusunan Laporan Bulanan | Kepala Perpustakaan | Memasuki awal bulan berikutnya |

## 3. Dokumen Sumber
* **Formulir Pendaftaran Anggota:** Memuat data diri (NIM, Nama, Prodi, No. HP).
* **Slip/Kartu Peminjaman:** Memuat nomor transaksi, tanggal pinjam, batas kembali, NIM, dan kode buku.
* **Kuitansi Denda:** Memuat rincian keterlambatan hari dan nominal denda.

## 4. Entitas Kandidat dan Atribut
1. **Anggota:** `id_anggota`, `no_anggota`, `nim_anggota`, `nama_anggota`, `prodi_anggota`, `no_hp_anggota`, `status_anggota`, `tgl_daftar_anggota`.
2. **Buku:** `id_buku`, `kode_buku`, `judul_buku`, `penulis_buku`, `penerbit_buku`, `tahun_terbit`, `stok_buku`.
3. **Petugas:** `id_petugas`, `kode_petugas`, `nama_petugas`, `peran_petugas`.
4. **Peminjaman:** `id_peminjaman`, `no_transaksi`, `tgl_peminjaman`, `tgl_jatuh_tempo`, `id_petugas`, `id_anggota`, `status_peminjaman`.
5. **Detail Peminjaman:** `id_peminjaman`, `id_buku`, `qty_pinjam`.
6. **Pengembalian:** `id_pengembalian`, `id_peminjaman`, `tgl_pengembalian`, `denda_keterlambatan`.

## 5. Aturan Bisnis (AB)
* **AB-01:** Setiap transaksi peminjaman memiliki nomor transaksi unik dan memuat minimal satu buku.
* **AB-02:** Anggota yang meminjam harus berstatus aktif dan maksimal meminjam 3 buku per transaksi.
* **AB-03:** Stok buku tidak boleh negatif; peminjaman ditolak jika stok habis.
* **AB-04:** Keterlambatan pengembalian dikenakan denda harian sebesar Rp1.000 per hari.
* **AB-05:** NIM anggota bersifat unik.

## 6. Kebutuhan Informasi (KI)
* **KI-01:** Laporan jumlah peminjaman dan pengembalian per hari/bulan.
* **KI-02:** Daftar buku paling sering dipinjam.
* **KI-03:** Daftar anggota yang melewati tanggal jatuh tempo peminjaman.
* **KI-04:** Rekapitulasi total pendapatan denda perpustakaan.

## 7. Matriks CRUD
| Proses Bisnis | Anggota | Buku | Petugas | Peminjaman | Detail Peminjaman | Pengembalian |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: |
| **PB-01 (Daftar)** | C | - | - | - | - | - |
| **PB-02 (Pinjam)** | R | U | R | C | C | - |
| **PB-03 (Kembali)** | - | U | R | U | R | C |
| **PB-04 (Pengadaan)**| - | C, U | - | - | - | - |
| **PB-05 (Laporan)** | R | R | R | R | R | R |