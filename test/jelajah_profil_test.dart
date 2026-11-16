import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'package:kerjain_tubes/main.dart';
import 'package:kerjain_tubes/pages/jelajah_page.dart';
import 'package:kerjain_tubes/pages/profil_page.dart';
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

  Future<void> bukaTab(WidgetTester tester, String label) async {
    await tester.pumpWidget(buildApp());
    await tester.pumpAndSettle();
    await tester.tap(find.text(label).last);
    await tester.pumpAndSettle();
  }

  testWidgets('Jelajah menampilkan dummy data & filter', (tester) async {
    await tester.binding.setSurfaceSize(const Size(412, 915));
    await bukaTab(tester, 'Jelajah');

    expect(find.byType(JelajahPage), findsOneWidget);
    expect(find.text('Jelajah'), findsWidgets);
    expect(find.text('Cari jasa atau penyedia'), findsOneWidget);
    expect(find.text('6 jasa ditemukan'), findsOneWidget);
    expect(find.text('Editing video reels dan\ndokumentasi kegiatan'), findsOneWidget);
    expect(find.text('Rp 300.000'), findsOneWidget);

    // Filter kategori Foto → 1 jasa
    await tester.tap(find.text('Foto'));
    await tester.pumpAndSettle();
    expect(find.text('1 jasa ditemukan'), findsOneWidget);
    expect(find.text('Fotografi event dan\nwisuda kampus'), findsOneWidget);

    // Kembali ke Semua
    await tester.tap(find.text('Semua'));
    await tester.pumpAndSettle();
    expect(find.text('6 jasa ditemukan'), findsOneWidget);
  });

  testWidgets('Profil punya tab Daftar Jasa, Portofolio, Ulasan', (tester) async {
    await bukaTab(tester, 'Profil');

    expect(find.byType(ProfilPage), findsOneWidget);
    expect(find.text('Nadia Putri'), findsOneWidget);
    expect(find.text('POLINDRA'), findsOneWidget);
    expect(find.text('Terbuka untuk pesanan'), findsOneWidget);
    expect(find.text('Daftar Jasa'), findsOneWidget);
    expect(find.text('Portofolio'), findsOneWidget);
    expect(find.text('Ulasan'), findsOneWidget);

    // Tab Portofolio
    await tester.tap(find.text('Portofolio'));
    await tester.pumpAndSettle();
    expect(find.text('Karya pilihan Nadia'), findsOneWidget);
    expect(find.text('Ruang Kreasi'), findsOneWidget);

    // Tab Ulasan
    await tester.tap(find.text('Ulasan'));
    await tester.pumpAndSettle();
    expect(find.text('Alya N.'), findsOneWidget);
    expect(find.text('28 ulasan'), findsOneWidget);
  });
}
