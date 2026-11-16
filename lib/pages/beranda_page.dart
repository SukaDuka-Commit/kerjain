import 'package:flutter/material.dart';

import '../pages/tambah_jasa_page.dart';
import '../theme.dart';

/// BERANDA — sesuai Figma node 12:296. Pakai dummy data (tanpa API).
class BerandaPage extends StatelessWidget {
  const BerandaPage({super.key});

  static const _kategori = [
    (Icons.palette_outlined, 'Desain'),
    (Icons.videocam_outlined, 'Video'),
    (Icons.photo_camera_outlined, 'Foto'),
    (Icons.code_rounded, 'Web'),
    (Icons.build_outlined, 'Servis'),
    (Icons.school_outlined, 'Tutor'),
    (Icons.print_outlined, 'Cetak'),
    (Icons.grid_view_rounded, 'Lainnya'),
  ];

  static const _populer = [
    _ServiceDummy(
      'Editing video reels dan\ndokumentasi kegiatan',
      'Nawaf A.',
      '4.9',
      '(32)',
      'Rp 75.000',
      Icons.videocam_rounded,
      Color(0xFF2563EB),
    ),
    _ServiceDummy(
      'Desain poster dan feed\nInstagram',
      'Rani S.',
      '4.8',
      '(58)',
      'Rp 50.000',
      Icons.brush_rounded,
      Color(0xFF9333EA),
    ),
  ];

  void _keTambahJasa(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const TambahJasaPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ──────────────────────────────────────────────
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Halo, Malda', style: AppText.heading(22)),
                      const SizedBox(height: 4),
                      Text(
                        'Mau cari jasa apa hari ini?',
                        style: AppText.body(14, color: AppColors.secondary),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.border),
                  ),
                  child: const Icon(
                    Icons.notifications_none_rounded,
                    size: 20,
                    color: AppColors.text,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // ── Search ──────────────────────────────────────────────
            Container(
              height: 52,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  const Icon(Icons.search_rounded,
                      size: 18, color: AppColors.secondary),
                  const SizedBox(width: 12),
                  Text(
                    'Cari desain, editing, tutor...',
                    style: AppText.body(14, color: AppColors.secondary),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // ── Kategori (4 × 2) ────────────────────────────────────
            for (var row = 0; row < 2; row++) ...[
              Row(
                children: [
                  for (var i = row * 4; i < row * 4 + 4; i++) ...[
                    Expanded(child: _KategoriItem(item: _kategori[i])),
                    if (i % 4 != 3) const SizedBox(width: 12),
                  ],
                ],
              ),
              if (row == 0) const SizedBox(height: 12),
            ],
            const SizedBox(height: 16),

            // ── Promo banner ────────────────────────────────────────
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  begin: Alignment(-0.75, -1),
                  end: Alignment(0.75, 1),
                  colors: [AppColors.primary, AppColors.primaryDark],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Punya skill? Ubah jadi cuan.',
                    style: AppText.heading(17, color: Colors.white),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Pasang jasa lu, bangun portofolio, dapat\npelanggan pertama dari kampus.',
                    style: AppText.body(
                      13,
                      color: const Color(0xD1FFFFFF),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Material(
                    color: AppColors.accent,
                    borderRadius: BorderRadius.circular(12),
                    child: InkWell(
                      onTap: () => _keTambahJasa(context),
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        child: Text(
                          'Tawarkan jasa',
                          style: AppText.body(13,
                              color: Colors.white, weight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // ── Jasa populer ────────────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('Jasa populer', style: AppText.heading(17)),
                Text(
                  'Lihat semua',
                  style: AppText.body(12,
                      color: AppColors.primary, weight: FontWeight.w700),
                ),
              ],
            ),
            const SizedBox(height: 12),
            for (final service in _populer) ...[
              _ServiceCard(service: service),
              const SizedBox(height: 12),
            ],
          ],
        ),
      ),
    );
  }
}

class _KategoriItem extends StatelessWidget {
  const _KategoriItem({required this.item});

  final (IconData, String) item;

  @override
  Widget build(BuildContext context) {
    final (icon, label) = item;
    return Column(
      children: [
        Container(
          height: 70,
          decoration: BoxDecoration(
            color: AppColors.primarySoft,
            borderRadius: BorderRadius.circular(16),
          ),
          alignment: Alignment.center,
          child: Icon(icon, color: AppColors.primary, size: 23),
        ),
        const SizedBox(height: 6),
        Text(label, style: AppText.body(12)),
      ],
    );
  }
}

class _ServiceDummy {
  const _ServiceDummy(
    this.title,
    this.provider,
    this.rating,
    this.jumlah,
    this.harga,
    this.icon,
    this.color,
  );

  final String title;
  final String provider;
  final String rating;
  final String jumlah;
  final String harga;
  final IconData icon;
  final Color color;
}

class _ServiceCard extends StatelessWidget {
  const _ServiceCard({required this.service});

  final _ServiceDummy service;

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
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: service.color,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(service.icon, color: Colors.white, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  service.title,
                  style: AppText.body(13, weight: FontWeight.w700, height: 1.25),
                ),
                const SizedBox(height: 2),
                Text(service.provider,
                    style: AppText.body(12, color: AppColors.secondary)),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(Icons.star_rounded,
                        size: 12, color: AppColors.accent),
                    const SizedBox(width: 4),
                    Text(service.rating,
                        style: AppText.body(12, weight: FontWeight.w700)),
                    const SizedBox(width: 4),
                    Text(service.jumlah,
                        style: AppText.body(12, color: AppColors.secondary)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            service.harga,
            style: AppText.body(13,
                color: AppColors.primary, weight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
