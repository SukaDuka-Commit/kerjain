import 'package:flutter/services.dart';

/// Muat font Poppins + Inter supaya test memakai metrics yang sama dengan app
/// (font default flutter_test lebih lebar dan bisa memicu overflow palsu).
Future<void> loadTestFonts() async {
  final inter = FontLoader('Inter')
    ..addFont(rootBundle.load('assets/fonts/Inter-Variable.ttf'));
  await inter.load();
  final poppins = FontLoader('Poppins')
    ..addFont(rootBundle.load('assets/fonts/Poppins-Regular.ttf'))
    ..addFont(rootBundle.load('assets/fonts/Poppins-SemiBold.ttf'));
  await poppins.load();
}
