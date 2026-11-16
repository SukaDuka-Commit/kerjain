import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kerjain_tubes/provider/jasa_provider.dart';

void main() {
  test('INTEGRASI: Flutter membaca data dari API Laragon', () async {
    debugDefaultTargetPlatformOverride = TargetPlatform.windows;
    final provider = JasaProvider();
    await provider.fetch();

    expect(provider.error, isNull, reason: 'Harus bisa konek ke API');
    expect(provider.list, isNotEmpty, reason: 'Tabel jasa harus punya data');
    expect(provider.list.first.nama, isNotEmpty);
    expect(provider.list.first.harga, greaterThan(0));

    // ignore: avoid_print
    print('DATA DARI API: ${provider.list.map((e) => e.nama).toList()}');
  });
}
