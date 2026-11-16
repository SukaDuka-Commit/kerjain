import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../model/jasa.dart';
import '../provider/jasa_provider.dart';
import '../theme.dart';
import 'detail_jasa_page.dart';
import 'tambah_jasa_page.dart';
import 'ubah_jasa_page.dart';

/// PROFIL — sesuai Figma node 14:647.
/// Tab "Daftar Jasa" berisi CRUD (edit/delete lewat titik-3 di tiap card).
class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  static const _tabs = ['Daftar Jasa', 'Portofolio', 'Ulasan'];
  int _tab = 0;

  void _hapus(BuildContext context, Jasa jasa) {
    final provider = context.read<JasaProvider>();
    showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hapus jasa?'),
        content: Text('Jasa "${jasa.nama}" akan dihapus.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Hapus', style: TextStyle(color: AppColors.danger)),
          ),
        ],
      ),
    ).then((setuju) async {
      if (setuju != true) return;
      final ok = await provider.delete(jasa.id);
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(ok ? 'Jasa dihapus' : 'Gagal menghapus')),
      );
    });
  }

  void _edit(BuildContext context, Jasa jasa) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => UbahJasaPage(jasa: jasa)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: Text('Profil Penyedia', style: AppText.heading(16)),
        centerTitle: true,
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.text,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1, thickness: 1, color: AppColors.border),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined, size: 22),
            tooltip: 'Bagikan profil',
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Tautan profil disalin')),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header profil ────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
              child: Row(
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset(
                          'assets/images/nadia.png',
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) => Container(
                            width: 80,
                            height: 80,
                            decoration: const BoxDecoration(
                              color: AppColors.primarySoft,
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Text('N', style: AppText.heading(28)),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 2,
                        bottom: 2,
                        child: Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: AppColors.success,
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: AppColors.surface, width: 2),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Nadia Putri', style: AppText.heading(20)),
                        const SizedBox(height: 2),
                        Text('POLINDRA',
                            style: AppText.body(12, color: AppColors.secondary)),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            const Icon(Icons.star_rounded,
                                size: 15, color: AppColors.accent),
                            const SizedBox(width: 4),
                            Text('4,9', style: AppText.label(14)),
                            const SizedBox(width: 4),
                            Text('(28 ulasan)',
                                style: AppText.body(12,
                                    color: AppColors.secondary)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Bantu ide kamu jadi visual yang berkesan. Dari acara kampus sampai identitas komunitas.',
                style: AppText.body(14, color: AppColors.secondary),
              ),
            ),
            const SizedBox(height: 14),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                            color: AppColors.success, shape: BoxShape.circle),
                      ),
                      const SizedBox(width: 6),
                      Text('Terbuka untuk pesanan',
                          style: AppText.body(12,
                              color: AppColors.secondary)),
                    ],
                  ),
                  Material(
                    color: AppColors.primarySoft,
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Chat dengan Nadia')),
                      ),
                      borderRadius: BorderRadius.circular(10),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 7),
                        child: Row(
                          children: [
                            const Icon(Icons.chat_bubble_outline,
                                size: 14, color: AppColors.primary),
                            const SizedBox(width: 6),
                            Text('Chat Nadia',
                                style: AppText.label(12,
                                    color: AppColors.primary)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // ── Tab ──────────────────────────────────────────────────
            Row(
              children: List.generate(_tabs.length, (i) {
                final aktif = i == _tab;
                return Expanded(
                  child: InkWell(
                    onTap: () => setState(() => _tab = i),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 44,
                          child: Center(
                            child: Text(
                              _tabs[i],
                              style: AppText.label(14,
                                  color: aktif
                                      ? AppColors.primary
                                      : AppColors.secondary),
                            ),
                          ),
                        ),
                        Container(
                          height: 3,
                          decoration: BoxDecoration(
                            color: aktif ? AppColors.primary : Colors.transparent,
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
            const Divider(height: 1, thickness: 1, color: AppColors.border),

            // ── Isi tab ──────────────────────────────────────────────
            if (_tab == 0)
              _DaftarJasaTab(
                onHapus: _hapus,
                onEdit: _edit,
              )
            else if (_tab == 1)
              const _PortofolioTab()
            else
              const _UlasanTab(),
          ],
        ),
      ),
    );
  }
}

// ─── Tab 1: Daftar Jasa (CRUD) ──────────────────────────────────────────────

class _DaftarJasaTab extends StatelessWidget {
  const _DaftarJasaTab({required this.onHapus, required this.onEdit});

  final void Function(BuildContext, Jasa) onHapus;
  final void Function(BuildContext, Jasa) onEdit;

  static const _warna = <List<Color>>[
    [Color(0xFF2563EB), Color(0xFF1E3A8A)],
    [Color(0xFF10B981), Color(0xFF047857)],
    [Color(0xFF8B5CF6), Color(0xFF7C3AED)],
    [Color(0xFFFB923C), Color(0xFFF97316)],
  ];

  @override
  Widget build(BuildContext context) {
    final list = context.watch<JasaProvider>().list;

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Jasa dari Nadia', style: AppText.label(14)),
              Row(
                children: [
                  Text('${list.length} jasa tersedia',
                      style: AppText.body(12, color: AppColors.secondary)),
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline,
                        color: AppColors.primary),
                    tooltip: 'Tambah jasa',
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const TambahJasaPage(),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (list.isEmpty)
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Center(
                child: Text('Belum ada jasa. Tap + untuk menambah.',
                    style: AppText.body(13, color: AppColors.secondary)),
              ),
            )
          else
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: list.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.82,
              ),
              itemBuilder: (context, index) {
                final jasa = list[index];
                return _JasaCard(
                  jasa: jasa,
                  warna: _warna[index % _warna.length],
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => DetailJasaPage(id: jasa.id),
                    ),
                  ),
                  onEdit: () => onEdit(context, jasa),
                  onHapus: () => onHapus(context, jasa),
                );
              },
            ),
        ],
      ),
    );
  }
}

class _JasaCard extends StatelessWidget {
  const _JasaCard({
    required this.jasa,
    required this.warna,
    required this.onTap,
    required this.onEdit,
    required this.onHapus,
  });

  final Jasa jasa;
  final List<Color> warna;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onHapus;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Thumbnail
          SizedBox(
            height: 88,
            width: double.infinity,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: warna,
                ),
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('KARYA NADIA',
                      style: AppText.label(6, color: Colors.white)),
                  Text(
                    jasa.nama,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppText.heading(12, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          // Info
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    jasa.nama,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppText.label(13),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          formatRupiah(jasa.harga),
                          style: AppText.label(14, color: AppColors.primary),
                        ),
                      ),
                      SizedBox(
                        height: 28,
                        child: PopupMenuButton<String>(
                          onSelected: (value) {
                            if (value == 'detail') onTap();
                            if (value == 'edit') onEdit();
                            if (value == 'hapus') onHapus();
                          },
                          itemBuilder: (context) => const [
                            PopupMenuItem(value: 'detail', child: Text('Detail')),
                            PopupMenuItem(value: 'edit', child: Text('Edit')),
                            PopupMenuItem(value: 'hapus', child: Text('Hapus')),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Tab 2: Portofolio (dummy) ──────────────────────────────────────────────

class _PortofolioTab extends StatelessWidget {
  const _PortofolioTab();

  static const _karya = [
    ('Ruang Kreasi', 'Poster festival · 2026', Color(0xFF2563EB), 'RUANG\nKREASI.'),
    ('Grow Together', 'Feed UKM · 2026', Color(0xFF22654D), 'Grow\ntogether.'),
    ('Komunitas Temu', 'Identitas visual · 2026', Color(0xFFE9E3FF), 'temu.'),
    ('Creative Proposal', 'Presentasi · 2026', Color(0xFFFFE8DB), 'Make it\nhappen.'),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Karya pilihan Nadia', style: AppText.label(14)),
              Text('4 karya', style: AppText.body(12, color: AppColors.secondary)),
            ],
          ),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: _karya.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 12,
              childAspectRatio: 0.83,
            ),
            itemBuilder: (context, index) {
              final (judul, sub, warna, teks) = _karya[index];
              final gelap = index == 0 || index == 1;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: warna,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        teks,
                        textAlign: TextAlign.center,
                        style: AppText.heading(
                          16,
                          color: gelap ? Colors.white : AppColors.text,
                          height: 1.1,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(judul, style: AppText.label(14)),
                  const SizedBox(height: 2),
                  Text(sub, style: AppText.body(12, color: AppColors.secondary)),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

// ─── Tab 3: Ulasan (dummy) ──────────────────────────────────────────────────

class _UlasanTab extends StatelessWidget {
  const _UlasanTab();

  static const _ulasan = [
    ('A', 'Alya N.', '30 Okt 2026',
        'Desainnya kreatif dan sesuai brief. Nadia juga komunikatif, hasilnya siap dipakai untuk acara kami.'),
    ('R', 'Rizky A.', '27 Okt 2026',
        'Feed UKM jadi lebih rapi dan konsisten. Prosesnya lancar, revisi juga dibantu dengan baik.'),
    ('S', 'Sinta D.', '24 Okt 2026',
        'Slidenya bersih dan mudah dibaca. Ada sedikit penyesuaian layout, tapi hasil akhirnya sudah sesuai.'),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ringkasan rating
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 90,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('4,9', style: AppText.heading(36)),
                      Row(
                        children: List.generate(
                          5,
                          (_) => const Icon(Icons.star_rounded,
                              size: 15, color: AppColors.accent),
                        ),
                      ),
                      Text('28 ulasan',
                          style: AppText.body(12, color: AppColors.secondary)),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    children: [
                      _Bar(5, 0.89, '25'),
                      _Bar(4, 0.11, '3'),
                      _Bar(3, 0, '0'),
                      _Bar(2, 0, '0'),
                      _Bar(1, 0, '0'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.primarySoft,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text('Semua (28)',
                    style: AppText.label(11, color: AppColors.primary)),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text('5 bintang (25)',
                    style: AppText.label(11, color: AppColors.secondary)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          for (final u in _ulasan) ...[
            _UlasanCard(item: u),
            const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}

class _Bar extends StatelessWidget {
  const _Bar(this.star, this.frac, this.jumlah);

  final int star;
  final double frac;
  final String jumlah;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.5),
      child: Row(
        children: [
          SizedBox(width: 8, child: Text('$star', style: AppText.body(11))),
          const SizedBox(width: 8),
          Expanded(
            child: SizedBox(
              height: 6,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Stack(
                  children: [
                    const ColoredBox(color: Color(0xFFF1F5F9)),
                    FractionallySizedBox(
                      widthFactor: frac,
                      child: const ColoredBox(color: AppColors.accent),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 18,
            child: Text(jumlah,
                textAlign: TextAlign.right, style: AppText.body(11)),
          ),
        ],
      ),
    );
  }
}

class _UlasanCard extends StatelessWidget {
  const _UlasanCard({required this.item});

  final (String, String, String, String) item;

  @override
  Widget build(BuildContext context) {
    final (initial, nama, tanggal, isi) = item;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: const BoxDecoration(
                  color: AppColors.primarySoft,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(initial,
                    style: AppText.label(14, color: AppColors.primary)),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(nama, style: AppText.label(14)),
                    Text(tanggal,
                        style: AppText.body(12, color: AppColors.secondary)),
                  ],
                ),
              ),
              Row(
                children: List.generate(
                  5,
                  (_) => const Icon(Icons.star_rounded,
                      size: 12, color: AppColors.accent),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(isi, style: AppText.body(14)),
        ],
      ),
    );
  }
}
