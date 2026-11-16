import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../model/jasa.dart';
import '../provider/jasa_provider.dart';
import '../theme.dart';
import 'ubah_jasa_page.dart';

/// READ per-id. Memakai Selector (modul 13) — hanya rebuild saat jasa ini berubah.
class DetailJasaPage extends StatelessWidget {
  const DetailJasaPage({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Jasa'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Selector<JasaProvider, Jasa?>(
        selector: (_, provider) => provider.byId(id),
        builder: (context, jasa, _) {
          if (jasa == null) {
            return const Center(child: Text('Data tidak ditemukan'));
          }
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      jasa.nama,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Chip(
                      label: Text(jasa.kategori),
                      backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                    ),
                    const Divider(height: 32),
                    _row('Harga', formatRupiah(jasa.harga)),
                    const SizedBox(height: 16),
                    const Text('Deskripsi',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    Text(jasa.deskripsi, style: const TextStyle(color: AppColors.secondary)),
                    const SizedBox(height: 28),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton.icon(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => UbahJasaPage(jasa: jasa),
                          ),
                        ),
                        icon: const Icon(Icons.edit),
                        label: const Text('Ubah Jasa'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _row(String label, String value) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: AppColors.secondary)),
          Text(value,
              style: const TextStyle(
                  fontWeight: FontWeight.w600, color: AppColors.primary)),
        ],
      );
}
