 Dokumen Kebutuhan Data Sistem Perpustakaan
**Mata Kuliah:** Praktikum Basis Data  
**Topik:** Sistem Informasi Perpustakaan (`perpus_090`)  
**NIM:** 25430090  

---

## 1. Latar Belakang dan Aktivitas Organisasi
Perpustakaan Namoy Budayo melayani civitas akademika dalam peminjaman buku dan pengelolaan koleksi literatur. Selama ini pencatatan manual sering menimbulkan kendala seperti keterlambatan pengembalian tanpa perhitungan denda yang transparan serta kesulitan penelusuran riwayat peminjaman buku oleh anggota. Sistem basis data ini dirancang untuk mengotomatisasi pendaftaran anggota, pengelolaan katalog, transaksi peminjaman, pengembalian, dan pencatatan denda secara akurat.

## 2. Aktor dan Proses Bisnis (Minimal 4 Proses)
| Kode | Proses Bisnis | Aktor | Pemicu |
| :--- | :--- | :--- | :--- |
| **PB-01** | Mendaftarkan Anggota Baru | Petugas Perpustakaan | Mahasiswa mendaftar sebagai anggota perpustakaan |
| **PB-02** | Pencatatan Peminjaman Buku | Petugas Perpustakaan | Anggota mengajukan peminjaman buku |
| **PB-03** | Pengembalian Buku & Hitung Denda | Petugas Perpustakaan | Anggota mengembalikan buku perpustakaan |
| **PB-04** | Pengadaan/Pembelian Buku Baru | Pengelola/Pustakawan | Penambahan stok katalog buku dari pemasok |
| **PB-05** | Penyusunan Laporan Bulanan | Kepala Perpustakaan | Memasuki awal bulan berikutnya |

## 3. Dokumen Sumber Fiktif dan Pembedahannya
### A. Bentuk Dokumen Sumber (Slip Peminjaman Buku)
> **KOPMANDIRI - PERPUSTAKAAN NAMOY BUDAYO**  
> No. Transaksi: TR-2610-001  
> Tanggal Pinjam: 2026-03-01 | Jatuh Tempo: 2026-03-08  
> Data Anggota: P-0142 / 25430090 / Rian Utama (Prodi: Ilmu Komputer)  
> Petugas Layanan: Siska (ID: PTG-01)  
> Daftar Buku Dipinjam:  
> 1. BK-01 | Basis Data | Qty: 1  
> 2. BK-03 | Pemrograman Web | Qty: 1  

### B. Pembedahan Dokumen Sumber:
* **Nomor Transaksi (`no_transaksi`)**: Menjadi identifikasi unik transaksi peminjaman.
* **Data Anggota (`no_anggota`, `nim_anggota`, `nama_anggota`)**: Menghubungkan transaksi ke entitas Anggota.
* **Data Petugas (`nama_petugas`)**: Mengetahui petugas yang melayani transaksi.
* **Detail Buku (`kode_buku`, `judul_buku`, `qty_pinjam`)**: Menunjukkan buku apa saja yang dipinjam dalam satu transaksi (dipecah ke tabel detail).

## 4. Entitas Kandidat (Minimal 6 Entitas)
1. **Anggota**: Menyimpan data diri mahasiswa yang terdaftar.
2. **Buku**: Menyimpan informasi katalog buku dan stok.
3. **Petugas**: Menyimpan data pegawai/pustakawan yang bertugas.
4. **Peminjaman**: Menyimpan kepala data transaksi peminjaman.
5. **Detail Peminjaman**: Menyimpan rincian buku yang dipinjam pada suatu transaksi.
6. **Pengembalian**: Menyimpan catatan pengembalian dan denda keterlambatan.

## 5. Aturan Bisnis (Minimal 8 Aturan)
* **AB-01**: Setiap transaksi peminjaman wajib memiliki nomor transaksi unik dan mencatat ID petugas serta ID anggota.
* **AB-02**: Anggota yang meminjam buku harus berstatus aktif dan maksimal meminjam 3 buku per transaksi.
* **AB-03**: Stok buku di perpustakaan tidak boleh bernilai negatif; transaksi ditolak jika stok kurang dari jumlah pinjam.
* **AB-04**: Keterlambatan pengembalian buku dikenakan denda harian sebesar Rp1.000 per hari keterlambatan.
* **AB-05**: Nomor Induk Mahasiswa (`nim_anggota`) dan nomor anggota bersifat unik dan tidak boleh ganda.
* **AB-06**: Buku yang dikembalikan harus dicek kondisinya oleh petugas sebelum status transaksi diperbarui menjadi selesai.
* **AB-07**: Satu transaksi peminjaman hanya menghasilkan satu catatan pengembalian utama.
* **AB-08**: Peminjaman baru tidak dapat dilakukan jika anggota masih memiliki tanggungan denda aktif atau buku yang belum dikembalikan melewati batas waktu.

## 6. Kebutuhan Informasi (Minimal 5 Kebutuhan)
* **KI-01**: Laporan rekapitulasi jumlah peminjaman dan pengembalian buku harian serta bulanan.
* **KI-02**: Daftar 5 buku yang paling sering dipinjam oleh anggota per bulan.
* **KI-03**: Daftar nama anggota yang sedang meminjam buku dan melewati tanggal jatuh tempo (terlambat).
* **KI-04**: Laporan total pendapatan denda keterlambatan perpustakaan per periode.
* **KI-05**: Laporan ketersediaan stok buku perpustakaan untuk memantau buku yang hampir habis.

## 7. Matriks CRUD
| Proses Bisnis | Anggota | Buku | Petugas | Peminjaman | Detail Peminjaman | Pengembalian |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: |
| **PB-01 (Daftar Anggota)** | C | - | - | - | - | - |
| **PB-02 (Pinjam Buku)** | R | U | R | C | C | - |
| **PB-03 (Kembali Buku)**| - | U | R | U | R | C |
| **PB-04 (Pengadaan Buku)**| - | C, U | - | - | - | - |
| **PB-05 (Laporan)** | R | R | R | R | R | R |

## 8. Kamus Data Awal (Minimal 20 Elemen)
| No | Nama Elemen Data | Arti / Deskripsi | Tipe Data & Panjang | Aturan / Format | Penanggung Jawab |
| :- | :--- | :--- | :--- | :--- | :--- |
| 1 | `id_anggota` | ID Internal Anggota | Integer (PK) | Auto Increment | Administrator Sistem |
| 2 | `no_anggota` | Nomor Kartu Anggota | Char(8) | Format P-XXXX | Pustakawan |
| 3 | `nim_anggota` | Nomor Induk Mahasiswa | Char(10) | Unik, 10 digit | Pustakawan |
| 4 | `nama_anggota` | Nama Lengkap Anggota | Varchar(100) | Huruf kapital/spasi | Pustakawan |
| 5 | `prodi_anggota` | Program Studi Mahasiswa | Varchar(50) | Nama prodi resmi | Pustakawan |
| 6 | `no_hp_anggota` | Nomor Kontak Seluler | Varchar(15) | Data Pribadi | Pustakawan |
| 7 | `status_anggota` | Status Keaktifan | Enum | 'Aktif', 'Nonaktif' | Pustakawan |
| 8 | `tgl_daftar_anggota`| Tanggal Pendaftaran | Date | Format YYYY-MM-DD | Pustakawan |
| 9 | `id_buku` | ID Internal Buku | Integer (PK) | Auto Increment | Administrator Sistem |
| 10 | `kode_buku` | Kode Klasifikasi Buku | Char(10) | Format BK-XXX | Pustakawan |
| 11 | `judul_buku` | Judul Lengkap Buku | Varchar(150) | Teks bebas | Pustakawan |
| 12 | `penulis_buku` | Nama Pengarang Buku | Varchar(100) | Teks bebas | Pustakawan |
| 13 | `penerbit_buku` | Nama Penerbit | Varchar(100) | Teks bebas | Pustakawan |
| 14 | `tahun_terbit` | Tahun Terbit Buku | Smallint | Format YYYY | Pustakawan |
| 15 | `stok_buku` | Jumlah Ketersediaan Stok | Integer | >= 0 | Pustakawan |
| 16 | `id_petugas` | ID Internal Petugas | Smallint (PK) | Auto Increment | Administrator Sistem |
| 17 | `kode_petugas` | Kode Unik Petugas | Char(5) | Format PTG-XX | Administrator Sistem |
| 18 | `nama_petugas` | Nama Pegawai Petugas | Varchar(100) | Teks bebas | Administrator Sistem |
| 19 | `peran_petugas` | Peran/Jabatan Petugas | Enum | 'Admin', 'Pustakawan' | Administrator Sistem |
| 20 | `id_peminjaman` | ID Transaksi Peminjaman | Integer (PK) | Auto Increment | Sistem |
| 21 | `no_transaksi` | Nomor Bukti Transaksi | Char(15) | Format TR-YYMM-XXX | Sistem |
| 22 | `tgl_peminjaman` | Tanggal Dilakukan Pinjam | Datetime | Waktu sistem | Sistem |
| 23 | `tgl_jatuh_tempo` | Batas Waktu Pengembalian| Date | Tanggal pinjam + 7 hari| Sistem |
| 24 | `status_peminjaman` | Status Transaksi | Enum | 'Dipinjam', 'Kembali' | Petugas |
| 25 | `qty_pinjam` | Jumlah Buku Dipinjam | Smallint | Nilai > 0 | Petugas |
| 26 | `id_pengembalian` | ID Catatan Pengembalian | Integer (PK) | Auto Increment | Sistem |
| 27 | `tgl_pengembalian` | Tanggal Buku Dikembalikan| Date | Tanggal aktual kembali | Petugas |
| 28 | `denda_keterlambatan`| Nominal Denda Keterlambatan| Decimal(10,2)| >= 0 (Rp1.000/hari) | Sistem |

## 9. Kebutuhan Non-Fungsional & Keamanan Data
* **Kinerja (Performance):** Waktu respons pencarian data buku melalui katalog berbasis indeks harus kurang dari 1 detik.
* **Ketersediaan (Availability):** Sistem basis data dapat diakses selama jam operasional perpustakaan berlangsung.
* **Identifikasi Data Pribadi (PII):** 
  * Atribut yang dikategorikan sebagai **data pribadi** yang dilindungi meliputi: `no_hp_anggota` dan alamat/kontak detail anggota.
  * **Pihak yang boleh mengakses:** Hanya Petugas Perpustakaan yang memiliki peran valid dan akun terautentikasi yang diizinkan melihat nomor kontak anggota. Anggota lain dilarang mengakses informasi pribadi anggota lainnya untuk menjaga privasi (*privacy protection*).
  ## 10. Analisis Wajib dan Parameter Proyek
* **Perhitungan Parameter $P$:** 
  * Dua digit terakhir NIM: `90`
  * Rumus: $P = (90 \bmod 9) + 1 = 1$
  * Penerapan parameter: Batas maksimal buku yang dapat dipinjam dalam satu transaksi adalah $P + 2 = 3$ buku, dengan besaran denda keterlambatan Rp1.000,- ($P$ dalam ribu rupiah) per hari.
* **Titik Analisis Kebutuhan:**
  1. Analisis Alur Kerja: Proses peminjaman divalidasi langsung melalui status keaktifan anggota untuk mencegah peminjaman oleh anggota nonaktif.
  2. Analisis Integritas Stok: Sistem menolak transaksi jika stok buku kurang dari jumlah yang diminta guna menghindari stok negatif.
  3. Analisis Keamanan PII: Data nomor telepon anggota diklasifikasikan sebagai data pribadi sensitif yang dibatasi aksesnya hanya untuk petugas berwenang.
* **Perbaikan Tiga Pernyataan Kebutuhan Kabur:**
  * *Pernyataan Awal (Kabur):* "Sistem harus mencatat data peminjaman dengan cepat dan aman."  
    * **Perbaikan (Spesifik):** "Sistem basis data harus merekam transaksi peminjaman baru dalam waktu respons di bawah 1 detik dan mengenkripsi data kontak pribadi anggota."
  * *Pernyataan Awal (Kabur):* "Pencarian buku di perpustakaan harus mudah dicari oleh pengguna."  
    * **Perbaikan (Spesifik):** "Sistem harus menyediakan fitur pencarian katalog berdasarkan atribut `judul_buku`, `penulis_buku`, atau `kode_buku` menggunakan indeks basis data."
  * *Pernyataan Awal (Kabur):* "Laporan stok buku harus akurat setiap saat."  
    * **Perbaikan (Spesifik):D** "Sistem harus memperbarui nilai atribut `stok_buku` secara otomatis setiap kali terjadi transaksi peminjaman (mengurangi stok) dan pengembalian (menambah stok)."