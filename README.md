# Rumah Jurnal Theme — OJS 3.5

Tema portal modern berstandar internasional yang dirancang khusus untuk halaman indeks institusi (*Site Index*) pada **Open Journal Systems (OJS) 3.5**. Dibangun dengan **Tailwind CSS**, **Alpine.js**, dan arsitektur *Strict Light Mode* yang elegan, bersih, dan responsif.

---

## 🌟 Fitur Utama

1. **Pencarian Real-Time Instan (Client-Side via Alpine.js)**:
   - Pencarian super cepat tanpa muat ulang halaman (*zero page reload*).
   - Mendukung pencarian berdasarkan nama jurnal, inisial/singkatan, fokus/cakupan riset, p-ISSN, e-ISSN, dan peringkat akreditasi SINTA.
2. **Filter Kategori Keilmuan / Disiplin**:
   - Pengelompokan jurnal otomatis berdasarkan bidang keilmuan:
     - Terakreditasi SINTA
     - Keislaman & Multidisiplin
     - Syariah & Hukum
     - Pendidikan & Tarbiyah
     - Ekonomi & Bisnis Islam
     - Sains & Teknologi
     - Bahasa & Sastra
     - Sosial & Humaniora
     - Prosiding & Konferensi
3. **Pengurutan Fleksibel (*Flexible Sorting*)**:
   - Berdasarkan Nama Jurnal (A - Z dan Z - A).
   - Berdasarkan Jumlah Artikel Terpublikasi.
   - Berdasarkan Jumlah Isu/Volume Terbitan.
4. **Tampilan Ganda (*Dual View Switcher*)**:
   - **Grid View**: Tampilan kartu interaktif dengan sampul, level SINTA, chip ISSN, dan aksi cepat.
   - **List View**: Tampilan tabel direktori yang ringkas untuk penelusuran tabular.
5. **Salin ISSN 1-Klik**:
   - Menyalin nomor e-ISSN/p-ISSN ke papan klip secara instan disertai notifikasi toast mengambang.
6. **Statistik Portal Langsung (*Live Metrics Counters*)**:
   - Menghitung dan menampilkan total jurnal aktif, total artikel terbit, volume terbitan, dan jurnal terakreditasi SINTA secara akurat.
7. **Pilihan Bahasa Berbendera (*Language Switcher*)**:
   - Terletak di **Top Institutional Bar** di sebelah kanan menu **About** (serta di drawer mobile).
   - Menggunakan **ikon vektor SVG bendera negara tajam & beresolusi tinggi** (🇮🇩 Indonesia, 🇬🇧 Inggris, 🇸🇦 Arab, dsb.).
   - Dropdown interaktif lengkap dengan tanda centang aktif dan terintegrasi dengan endpoint resmi OJS `setLocale`.
8. **Showcase Lembaga Akreditasi & Pengindeks**:
   - Menampilkan 16 logo resmi lembaga pengindeks (SINTA, Scopus, DOAJ, Garuda, Crossref, Dimensions, Google Scholar, dll.) berstandar 380 × 129 px tanpa distorsi.
   - Dapat dikelola penuh melalui admin OJS (atur urutan via drag-and-drop, centang/sembunyikan, atau tambah logo kustom).
9. **Footer Multilingual & Kontak Utama Dinamis**:
   - Otomatis beradaptasi dengan bahasa yang aktif.
   - Mengambil **Email of Principal Contact** dari pengaturan OJS.
   - Tautan Cepat (*Quick Links*) dan Alamat Kantor Sekretariat dapat disunting langsung di admin panel.

---

## ⚙️ Pengaturan di Admin OJS

Pengelola situs (*Site Administrator*) dapat mengatur tema melalui:
> **Administration** > **Site Settings** > Tab **Appearance** > Gulir ke bagian opsi **Rumah Jurnal Theme**

### Opsi yang Tersedia:
| Opsi | Tipe Field | Keterangan |
| :--- | :--- | :--- |
| **Warna Primer** (`primaryColor`) | `FieldColor` | Warna navbar, judul, tombol utama (Default: `#2C366D`). |
| **Warna Sekunder** (`secondaryColor`) | `FieldColor` | Warna aksen/sorotan hover dan badge (Default: `#D2AA2A`). |
| **Judul Utama Banner** (`heroTitle`) | `FieldText` | Headline utama pada banner beranda portal. |
| **Deskripsi Banner** (`heroDescription`) | `FieldTextarea` | Narasi pengantar di bawah judul banner. |
| **Logo Indeksasi Bawaan** (`indexingLogos`) | `FieldOptions` | Memilih dan mengurutkan 16 logo pengindeks bawaan via drag & drop. |
| **Logo Indeksasi Kustom** (`customIndexingLogos`) | `FieldTextarea` | Menambah logo baru tanpa batas (`Nama \| URL/File Gambar \| URL Tautan`). |
| **Tautan Cepat Footer** (`footerQuickLinks`) | `FieldTextarea` | Daftar tautan footer (`Judul \| URL`). Mendukung variabel `{$baseUrl}`. |
| **Alamat Sekretariat** (`secretariatAddress`) | `FieldTextarea` | Alamat fisik kantor sekretariat Rumah Jurnal (mendukung baris baru). |
| **Hak Cipta & Dukungan** (`themeCredits`) | `FieldHTML` | Informasi pengembang, lisensi hak cipta, dan tautan dukungan teknis. |

---

## 📁 Struktur Berkas

```
plugins/themes/rumahJurnal/
├── README.md                        # Dokumentasi tema
├── version.xml                      # Metadata & registrasi tema OJS
├── index.php                        # Inisialisasi plugin kelas tema
├── RumahJurnalThemePlugin.php       # Logika tema, hook Smarty, query database, options admin
├── images/                          # Logo lembaga pengindeks resmi (380x129 px)
│   ├── sinta.png, scopus.png, garuda.png, crossref.png, doaj.png, scholar.png...
├── locale/
│   ├── id/locale.po                 # Terjemahan Bahasa Indonesia & label pengaturan
│   └── en/locale.po                 # Terjemahan English & label pengaturan
├── styles/
│   └── rumah-jurnal.css             # CSS kustom, variabel tema, badge SINTA, efek interaktif
├── js/
│   ├── alpine.min.js                # Alpine.js (komponen interaktif)
│   ├── tailwind.min.js              # Tailwind CSS runtime
│   └── rumah-jurnal.js              # Fitur interaktif (salin ISSN, notifikasi toast)
└── templates/
    └── frontend/
        ├── components/
        │   ├── header.tpl           # Top bar, switcher bahasa berbendera, navigasi & drawer
        │   └── footer.tpl           # Footer multilingual, tautan dinamis & kredit hak cipta
        ├── objects/
        │   └── article_summary.tpl  # Kartu ringkasan artikel ilmiah
        └── pages/
            ├── indexSite.tpl        # Beranda utama portal & direktori jurnal
            ├── search.tpl           # Halaman pencarian ilmiah lintas jurnal
            ├── userLogin.tpl        # Halaman masuk pengguna
            ├── userLostPassword.tpl # Halaman pemulihan kata sandi
            ├── userRegister.tpl     # Halaman registrasi akun
            └── userRegisterComplete.tpl # Halaman konfirmasi registrasi
```

---

## 🚀 Panduan Instalasi & Aktivasi

1. Salin folder `rumahJurnal` ke direktori tema OJS:
   ```
   plugins/themes/rumahJurnal
   ```
2. Pastikan izin akses berkas dan kepemilikan (*file permissions*) telah sesuai pada server web Anda.
3. Masuk ke OJS sebagai **Site Administrator**.
4. Navigasikan ke **Administration** > **Site Settings** > Tab **Appearance**.
5. Pada pilihan **Theme**, pilih **Tema Rumah Jurnal**.
6. Simpan perubahan (**Save**).
7. Bersihkan cache kompilasi template jika diperlukan:
   ```bash
   rm -rf cache/t_compile/*
   ```

---

## 👨‍💻 Pengembang & Lisensi

* **Author / Developer**: **Fajri Rinaldi Chan**
* **Hak Cipta**: &copy; 2026 Fajri Rinaldi Chan. Seluruh hak cipta dilindungi.
* **Theme Support Website**: [https://nagastra.org](https://nagastra.org)
* **Lisensi**: [GNU General Public License v3.0 (GPL-3.0)](LICENSE) — Didistribusikan secara bebas dan terbuka sesuai standar ekosistem Public Knowledge Project (PKP / OJS). Lihat berkas [LICENSE](LICENSE) untuk ketentuan hukum selengkapnya.
