import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'package:kerjain_tubes/main.dart';
import 'package:kerjain_tubes/pages/beranda_page.dart';
import 'package:kerjain_tubes/pages/tambah_jasa_page.dart';
import 'package:kerjain_tubes/provider/jasa_provider.dart';
import 'load_test_fonts.dart';

void main() {
  setUpAll(loadTestFonts);

  Widget buildApp() => ChangeNotifierProvider<JasaProvider>(
        create: (_) => JasaProvider(
          client: MockClient((_) async => http.Response('{"success":true,"data":[]}', 200)),
        ),
        child: const MaterialApp(home: MyApp()),
      );

  testWidgets('Beranda menampilkan elemen sesuai desain', (tester) async {
    await tester.pumpWidget(buildApp());
    await tester.pumpAndSettle();

    expect(find.byType(BerandaPage), findsOneWidget);
    expect(find.text('Halo, Malda'), findsOneWidget);
    expect(find.text('Mau cari jasa apa hari ini?'), findsOneWidget);
    expect(find.text('Cari desain, editing, tutor...'), findsOneWidget);
    expect(find.text('Punya skill? Ubah jadi cuan.'), findsOneWidget);
    expect(find.text('Jasa populer'), findsOneWidget);
    expect(find.text('Desain'), findsOneWidget);
    expect(find.text('Lainnya'), findsOneWidget);
    expect(find.text('Tawarkan jasa'), findsOneWidget);
    expect(find.text('Lihat semua'), findsOneWidget);
  });

  testWidgets('Tombol Tawarkan jasa membuka Tambah Jasa', (tester) async {
    await tester.pumpWidget(buildApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Tawarkan jasa'));
    await tester.pumpAndSettle();

    expect(find.byType(TambahJasaPage), findsOneWidget);
    expect(find.text('Tawarkan skill kamu'), findsOneWidget);
    expect(find.text('Terbitkan Jasa'), findsOneWidget);
    expect(find.text('Judul jasa'), findsOneWidget);
    expect(find.text('Foto & Portofolio'), findsOneWidget);
  });
}
