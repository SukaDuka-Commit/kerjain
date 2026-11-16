import 'package:flutter/foundation.dart';

/// Konfigurasi alamat API — satu tempat untuk mengatur koneksi (PBO).
class ApiConfig {
  /// Set true kalau aplikasi dijalankan di HP fisik yang satu WiFi dengan laptop.
  static const bool pakaiHpFisik = true;

  /// IP WiFi laptop (dicek: 192.168.100.7). Pakai kalau [pakaiHpFisik] = true.
  static const String ipHpFisik = '192.168.100.7';

  /// Alamat host yang dipilih otomatis sesuai platform:
  /// - Web / Windows desktop → 127.0.0.1 (Laragon di mesin yang sama)
  /// - Emulator Android     → 10.0.2.2  (alias localhost dari emulator)
  /// - HP fisik             → ipHpFisik (set [pakaiHpFisik] = true)
  static String get host {
    if (pakaiHpFisik) return ipHpFisik;
    if (kIsWeb) return '127.0.0.1';
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
      case TargetPlatform.iOS:
        return '10.0.2.2';
      default:
        return '127.0.0.1';
    }
  }

  static String get baseUrl => 'http://$host/kerjain_api';
  static String get list => '$baseUrl/read_jasa.php';
  static String get create => '$baseUrl/create_jasa.php';
  static String get update => '$baseUrl/update_jasa.php';
  static String get delete => '$baseUrl/delete_jasa.php';
}
