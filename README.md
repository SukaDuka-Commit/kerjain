# KerjaIn — CRUD Jasa + Provider Global State

Project TUBES versi sederhana: **satu entitas (Jasa)** dengan CRUD penuh melalui
**API PHP + MySQL** (modul 12) dan **Provider / ChangeNotifier** sebagai global
state management (modul 13).

## Alur aplikasi

```
MainShell (bottom nav 5 tab)
 ├─ BERANDA   → dummy data, tombol "Tawarkan jasa" → TambahJasaPage
 ├─ JELAJAH   → JelajahPage (dummy data + filter chip + search)
 ├─ PESANAN   → placeholder
 ├─ CHAT      → placeholder
 └─ PROFIL    → ProfilPage (Figma 14:647)
                 ├─ Daftar Jasa → CRUD cards dari API/MySQL
                 │   tiap card ada titik-3: Detail / Edit / Hapus
                 ├─ Portofolio  → dummy
                 └─ Ulasan      → dummy
```

Tombol **Tawarkan jasa** di banner Beranda dan tombol **+** di Profil → halaman
**Tambah Jasa** (UI sesuai Figma node 18:32224) yang menyimpan lewat API/MySQL.

## struktur

```
lib/
 ├─ main.dart                    → ChangeNotifierProvider + MaterialApp
 ├─ theme.dart                   → warna + AppText
 ├─ config/api_config.dart       → alamat API (pakaiHpFisik = true)
 ├─ model/jasa.dart              → model Jasa + fromJson
 ├─ provider/jasa_provider.dart  → ChangeNotifier CRUD
 └─ pages/
     ├─ main_shell.dart          → bottom nav 5 tab
     ├─ beranda_page.dart        → BERANDA (dummy, Figma 12:296)
     ├─ jelajah_page.dart        → JELAJAH (dummy, Figma 12:195)
     ├─ profil_page.dart         → PROFIL (Figma 14:647) + CRUD jasa (titik-3)
     ├─ tambah_jasa_page.dart    → CREATE (context.read, Figma 18:32224)
     ├─ ubah_jasa_page.dart      → UPDATE (context.read)
     └─ detail_jasa_page.dart    → READ by id (Selector)
api/                             → script PHP + SQL (taruh di htdocs)
```

## Cara menjalankan server (Laragon — SUDAH AKTIF)

Status saat ini:
- MySQL 8.4.3 + Apache jalan
- Database `kerjain_db`, tabel `jasa`, 2 data awal ✅
- API terpasang di `C:\laragon\www\kerjain_api\` ✅
- Endpoint `http://localhost/kerjain_api/read_jasa.php` → 200 JSON ✅
- CORS aktif (`Access-Control-Allow-Origin: *`) ✅

Kalau mau ulang dari awal:
1. Import `api/kerjain.sql` lewat phpMyAdmin / `mysql -u root < kerjain.sql`.
2. Salin folder `api/` ke `C:\laragon\www\kerjain_api\`.
3. Cek browser: `http://localhost/kerjain_api/read_jasa.php`.

## Cara menjalankan Flutter

1. `flutter pub get`
2. **Alamat API sudah diatur otomatis** di `lib/config/api_config.dart`:
   - Web / Windows desktop → `127.0.0.1` ✅ (tinggal `flutter run -d chrome`)
   - Emulator Android → `10.0.2.2`
   - HP fisik → ubah `pakaiHpFisik = true` (IP WiFi laptop: `192.168.100.7`)
3. `flutter run -d chrome` (atau `-d windows`)

> Test integrasi `test/integrasi_api_test.dart` sudah membuktikan Flutter
> berhasil membaca data langsung dari API Laragon (2 jasa).

## Alur CRUD

| Aksi | Halaman | Method Provider | Endpoint |
|------|---------|-----------------|----------|
| Lihat daftar | DaftarJasaPage | `fetch()` | `read_jasa.php` (GET) |
| Tambah | TambahJasaPage | `create()` | `create_jasa.php` (POST) |
| Ubah | UbahJasaPage | `update()` | `update_jasa.php` (POST) |
| Hapus | DaftarJasaPage | `delete()` | `delete_jasa.php` (POST) |
| Detail | DetailJasaPage | `byId()` (Selector) | — |

Setiap create/update/delete sukses → provider memanggil `fetch()` + `notifyListeners()`,
semua halaman yang `watch` otomatis ter-update.

## Pemetaan ke modul

- **Modul 12**: 4 halaman (daftar/tambah/ubah/detail), `http.get/post`, `success == true`,
  `pushAndRemoveUntil` diganti dengan `Navigator.pop` ( lebih sederhana),
  format rupiah pakai `intl`, loading indicator, SnackBar saat hapus.
- **Modul 13**: `ChangeNotifier` + `notifyListeners()`, `ChangeNotifierProvider`,
  `context.watch`, `context.read`, `Consumer`, `Selector`.

## Test

```
flutter test
```
Test memakai `MockClient` (package `http/testing.dart`) — tidak butuh server nyala.

## Catatan

Project versi lengkap (design Figma, 7+ halaman) dicadangkan di:
`D:\flutterprojects\kerjain_tubes_backup_20261116_234721`
