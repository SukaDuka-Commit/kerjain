import 'package:flutter/material.dart';

import '../theme.dart';

/// JELAJAH — sesuai Figma node 12:195. Pakai dummy data.
class JelajahPage extends StatefulWidget {
  const JelajahPage({super.key});

  @override
  State<JelajahPage> createState() => _JelajahPageState();
}

class _JelajahPageState extends State<JelajahPage> {
  static const _chips = ['Semua', 'Desain', 'Video', 'Foto', 'Web'];

  static const _data = <_JasaDummy>[
    _JasaDummy(
      'Editing video reels dan\ndokumentasi kegiatan',
      'Nawaf A.',
      '4.9',
      '(32)',
      'Rp 75.000',
      'Video',
      Icons.videocam_rounded,
      [Color(0xFF3B82F6), Color(0xFF2563EB)],
    ),
    _JasaDummy(
      'Desain poster dan feed\nInstagram',
      'Rani S.',
      '4.8',
      '(58)',
      'Rp 50.000',
      'Desain',
      Icons.brush_rounded,
      [Color(0xFFA855F7), Color(0xFF9333EA)],
    ),
    _JasaDummy(
      'Fotografi event dan\nwisuda kampus',
      'Dimas P.',
      '4.7',
      '(21)',
      'Rp 150.000',
      'Foto',
      Icons.photo_camera_rounded,
      [Color(0xFF38BDF8), Color(0xFF0EA5E9)],
    ),
    _JasaDummy(
      'Pembuatan website\nportofolio dan landing page',
      'Fairil M.',
      '4.9',
      '(14)',
      'Rp 300.000',
      'Web',
      Icons.code_rounded,
      [Color(0xFF34D399), Color(0xFF10B981)],
    ),
    _JasaDummy(
      'Desain Poster Kreatif\nuntuk Acara Kampus',
      'Nadia Putri',
      '4.9',
      '(28)',
      'Rp 75.000',
      'Desain',
      Icons.palette_rounded,
      [Color(0xFF2563EB), Color(0xFF1E3A8A)],
    ),
    _JasaDummy(
      'Desain Feed Instagram\nuntuk UKM',
      'Nadia Putri',
      '4.9',
      '(28)',
      'Rp 120.000',
      'Desain',
      Icons.grid_view_rounded,
      [Color(0xFF10B981), Color(0xFF047857)],
    ),
  ];

  String _kategori = 'Semua';
  final _query = TextEditingController();

  @override
  void dispose() {
    _query.dispose();
    super.dispose();
  }

  List<_JasaDummy> get _filtered {
    final q = _query.text.trim().toLowerCase();
    return _data.where((s) {
      final cocokKategori = _kategori == 'Semua' || s.kategori == _kategori;
      final cocokQuery = q.isEmpty ||
          s.judul.toLowerCase().contains(q) ||
          s.penyedia.toLowerCase().contains(q);
      return cocokKategori && cocokQuery;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final hasil = _filtered;

    return SafeArea(
      bottom: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Judul ──────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
            child: Text('Jelajah', style: AppText.heading(20, height: 1.5)),
          ),
          const Divider(height: 1, thickness: 1, color: AppColors.border),

          // ── Search ─────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.border),
              ),
              child: TextField(
                controller: _query,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  hintText: 'Cari jasa atau penyedia',
                  hintStyle: AppText.body(14, color: AppColors.secondary),
                  prefixIcon: const Icon(Icons.search_rounded,
                      size: 18, color: AppColors.secondary),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // ── Chip kategori ──────────────────────────────────────────
          SizedBox(
            height: 36,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                for (final chip in _chips) ...[
                  _Chip(
                    label: chip,
                    aktif: chip == _kategori,
                    onTap: () => setState(() => _kategori = chip),
                  ),
                  const SizedBox(width: 8),
                ],
              ],
            ),
          ),
          const SizedBox(height: 12),

          // ── Info jumlah + urutan ───────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text('${hasil.length} jasa ditemukan',
                    style: AppText.body(12, color: AppColors.secondary)),
                const Spacer(),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Rating tertinggi',
                      style: AppText.body(14,
                          color: AppColors.primary, weight: FontWeight.w600),
                    ),
                    const Icon(Icons.keyboard_arrow_down_rounded,
                        size: 16, color: AppColors.primary),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // ── Daftar jasa ────────────────────────────────────────────
          Expanded(
            child: hasil.isEmpty
                ? Center(
                    child: Text('Jasa tidak ditemukan',
                        style: AppText.body(14, color: AppColors.secondary)),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                    itemCount: hasil.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 12),
                    itemBuilder: (context, index) =>
                        _KartuJasa(jasa: hasil[index]),
                  ),
          ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.aktif,
    required this.onTap,
  });

  final String label;
  final bool aktif;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: aktif ? AppColors.primary : AppColors.surface,
      borderRadius: BorderRadius.circular(100),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(100),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: aktif ? null : Border.all(color: AppColors.border),
          ),
          child: Text(
            label,
            style: AppText.label(14,
                color: aktif ? Colors.white : AppColors.text),
          ),
        ),
      ),
    );
  }
}

class _JasaDummy {
  const _JasaDummy(
    this.judul,
    this.penyedia,
    this.rating,
    this.jumlah,
    this.harga,
    this.kategori,
    this.icon,
    this.warna,
  );

  final String judul;
  final String penyedia;
  final String rating;
  final String jumlah;
  final String harga;
  final String kategori;
  final IconData icon;
  final List<Color> warna;
}

class _KartuJasa extends StatelessWidget {
  const _KartuJasa({required this.jasa});

  final _JasaDummy jasa;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 84,
            height: 84,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: jasa.warna,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(jasa.icon, color: Colors.white, size: 36),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  jasa.judul,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppText.body(14, weight: FontWeight.w700, height: 1.25),
                ),
                const SizedBox(height: 2),
                Text(jasa.penyedia,
                    style: AppText.body(12, color: AppColors.secondary)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.star_rounded,
                        size: 13, color: AppColors.accent),
                    const SizedBox(width: 4),
                    Text(jasa.rating,
                        style: AppText.body(13, weight: FontWeight.w700)),
                    const SizedBox(width: 4),
                    Text(jasa.jumlah,
                        style: AppText.body(12, color: AppColors.secondary)),
                    const Spacer(),
                    Text(
                      jasa.harga,
                      style: AppText.body(13,
                          color: AppColors.primary, weight: FontWeight.w700),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
