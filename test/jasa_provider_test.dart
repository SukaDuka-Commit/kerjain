import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:provider/provider.dart';

import 'package:kerjain_tubes/model/jasa.dart';
import 'package:kerjain_tubes/pages/profil_page.dart';
import 'load_test_fonts.dart';
import 'package:kerjain_tubes/provider/jasa_provider.dart';

void main() {
  setUpAll(loadTestFonts);

  /// Fake API — tidak butuh XAMPP/server.
  http.Client buildClient() => MockClient((request) async {
        switch (request.url.path) {
          case '/kerjain_api/read_jasa.php':
            return http.Response(
              json.encode({
                'success': true,
                'data': [
                  {
                    'id': '1',
                    'nama': 'Desain Poster',
                    'kategori': 'Desain',
                    'harga': '75000',
                    'deskripsi': 'Poster kampus'
                  },
                ]
              }),
              200,
            );
          case '/kerjain_api/create_jasa.php':
          case '/kerjain_api/update_jasa.php':
          case '/kerjain_api/delete_jasa.php':
            return http.Response(json.encode({'success': true}), 200);
          default:
            return http.Response(json.encode({'success': false}), 404);
        }
      });

  test('Jasa.fromJson parses API response', () {
    final jasa = Jasa.fromJson({
      'id': '3',
      'nama': 'Web',
      'kategori': 'Web',
      'harga': '300000',
      'deskripsi': 'Landing page'
    });
    expect(jasa.id, 3);
    expect(jasa.harga, 300000);
  });

  test('Provider CRUD: fetch → create → update → delete', () async {
    final provider = JasaProvider(client: buildClient());

    await provider.fetch();
    expect(provider.list.length, 1);
    expect(provider.list.first.nama, 'Desain Poster');

    expect(
      await provider.create(
        nama: 'Baru',
        kategori: 'Video',
        harga: 50000,
        deskripsi: 'x',
      ),
      isTrue,
    );
    expect(provider.list.length, 1); // fake fetch selalu balas 1 data

    expect(
      await provider.update(
        id: 1,
        nama: 'Ubah',
        kategori: 'Web',
        harga: 90000,
        deskripsi: 'y',
      ),
      isTrue,
    );
    expect(await provider.delete(1), isTrue);
    // Setelah setiap operasi sukses provider fetch ulang; fake selalu balas 1 data.
    expect(provider.list.length, 1);
  });

  testWidgets('ProfilPage menampilkan data jasa dari Provider', (tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider<JasaProvider>(
        create: (_) => JasaProvider(client: buildClient())..fetch(),
        child: const MaterialApp(home: ProfilPage()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Profil Penyedia'), findsOneWidget);
    expect(find.text('Daftar Jasa'), findsOneWidget);
    expect(find.text('Jasa dari Nadia'), findsOneWidget);
    expect(find.text('Desain Poster'), findsWidgets);
    expect(find.textContaining('75.000'), findsWidgets);
  });
}
