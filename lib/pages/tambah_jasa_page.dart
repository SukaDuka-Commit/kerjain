import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/jasa_provider.dart';
import '../theme.dart';

/// CREATE — UI sesuai Figma node 18:32224.
/// Tetap memakai context.read (modul 13) untuk global state.
class TambahJasaPage extends StatefulWidget {
  const TambahJasaPage({super.key});

  @override
  State<TambahJasaPage> createState() => _TambahJasaPageState();
}

class _TambahJasaPageState extends State<TambahJasaPage> {
  final _formKey = GlobalKey<FormState>();
  final _nama = TextEditingController();
  final _kategori = TextEditingController();
  final _deskripsi = TextEditingController();
  final _harga = TextEditingController();
  final _satuan = TextEditingController();
  final _durasi = TextEditingController();
  final _revisi = TextEditingController();

  static const _kategoriList = [
    'Desain',
    'Video',
    'Foto',
    'Web',
    'Servis',
    'Tutor',
    'Cetak',
    'Lainnya',
  ];

  @override
  void initState() {
    super.initState();
    _kategori.text = _kategoriList.first;
  }

  @override
  void dispose() {
    _nama.dispose();
    _kategori.dispose();
    _deskripsi.dispose();
    _harga.dispose();
    _satuan.dispose();
    _durasi.dispose();
    _revisi.dispose();
    super.dispose();
  }

  Future<void> _simpan() async {
    if (!_formKey.currentState!.validate()) return;

    final provider = context.read<JasaProvider>();
    final harga = int.parse(_harga.text.replaceAll(RegExp(r'[^0-9]'), ''));
    final durasi = _durasi.text.trim();
    final revisi = _revisi.text.trim();
    final deskripsi = _deskripsi.text.trim();

    final ok = await provider.create(
      nama: _nama.text.trim(),
      kategori: _kategori.text.trim(),
      harga: harga,
      deskripsi: 'Deskripsi: $deskripsi\nEstimasi: $durasi hari\nRevisi: $revisi kali',
    );

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(ok ? 'Jasa berhasil diterbitkan!' : 'Gagal menerbitkan jasa')),
    );
    if (ok) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final loading = context.watch<JasaProvider>().loading;

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: Text('Tambah Jasa', style: AppText.heading(16)),
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.text,
        elevation: 0,
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1, thickness: 1, color: AppColors.border),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Pengantar ────────────────────────────────────
                    Text('Tawarkan skill kamu', style: AppText.heading(28, height: 1.4)),
                    const SizedBox(height: 6),
                    Text(
                      'Bantu mahasiswa lain dan mulai bangun portofoliomu.',
                      style: AppText.body(14, color: AppColors.secondary),
                    ),
                    const SizedBox(height: 24),

                    // ── Detail jasa ─────────────────────────────────
                    _FormField(
                      label: 'Judul jasa',
                      hint: 'Contoh: Desain poster acara kampus',
                      controller: _nama,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Buat judul yang jelas dan mudah dicari.',
                      style: AppText.body(12, color: AppColors.secondary),
                    ),
                    const SizedBox(height: 18),

                    _FormField(
                      label: 'Kategori',
                      child: DropdownButtonFormField<String>(
                        isExpanded: true,
                        initialValue: _kategoriList.first,
                        decoration: _inputDecoration('Pilih kategori jasa', prefix: const Icon(Icons.keyboard_arrow_down_rounded, size: 18, color: AppColors.secondary)),
                        items: _kategoriList
                            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                            .toList(),
                        onChanged: (v) => _kategori.text = v ?? _kategoriList.first,
                      ),
                    ),
                    const SizedBox(height: 18),

                    _FormField(
                      label: 'Deskripsi jasa',
                      hint: 'Jelaskan layanan, hasil yang didapat, dan kebutuhan dari pelanggan...',
                      controller: _deskripsi,
                      maxLines: 5,
                      minHeight: 112,
                    ),
                    const SizedBox(height: 18),

                    _FormField(
                      label: 'Harga jasa',
                      hint: 'Rp  Masukkan harga',
                      controller: _harga,
                      keyboard: TextInputType.number,
                    ),
                    const SizedBox(height: 18),

                    _FormField(
                      label: 'Satuan harga',
                      hint: 'Contoh: per desain',
                      controller: _satuan,
                    ),
                    const SizedBox(height: 18),

                    // ── Durasi & revisi (2 kolom) ───────────────────
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _FormField(
                            label: 'Estimasi selesai',
                            hint: 'Jumlah hari',
                            controller: _durasi,
                            keyboard: TextInputType.number,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _FormField(
                            label: 'Batas revisi',
                            hint: 'Jumlah revisi',
                            controller: _revisi,
                            keyboard: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // ── Foto & portofolio ───────────────────────────
                    Text('Foto & Portofolio', style: AppText.heading(16)),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.border),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          const Icon(Icons.cloud_upload_outlined,
                              size: 20, color: AppColors.primary),
                          const SizedBox(height: 8),
                          Text('Unggah Karya',
                              style: AppText.label(14, color: AppColors.primary)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('JPG atau PNG · Maks. 10 MB per gambar',
                        style: AppText.body(12, color: AppColors.secondary)),
                    const SizedBox(height: 24),

                    // ── Pesan bantuan ───────────────────────────────
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.primarySoft,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.info_outlined,
                              size: 16, color: AppColors.primary),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Tampilkan karya milikmu sendiri. Jangan cantumkan data pribadi pelanggan pada portofolio.',
                              style: AppText.body(12, color: AppColors.primary),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ── Area tindakan bawah ───────────────────────────────────
          Container(
            padding: EdgeInsets.fromLTRB(
              24,
              16,
              24,
              16 + MediaQuery.paddingOf(context).bottom,
            ),
            decoration: const BoxDecoration(
              color: AppColors.surface,
              border: Border(top: BorderSide(color: AppColors.border)),
            ),
            child: Column(
              children: [
                Text(
                  'Pastikan detail jasa sudah benar sebelum diterbitkan.',
                  textAlign: TextAlign.center,
                  style: AppText.body(12, color: AppColors.secondary),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: loading ? null : _simpan,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: loading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text('Terbitkan Jasa',
                            style: AppText.label(14, color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(String hint, {Widget? prefix}) =>
      InputDecoration(
        hintText: hint,
        hintStyle: AppText.body(14, color: AppColors.secondary),
        filled: true,
        fillColor: AppColors.background,
        prefixIcon: prefix,
        contentPadding: const EdgeInsets.all(16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
      );
}

class _FormField extends StatelessWidget {
  const _FormField({
    required this.label,
    this.hint,
    this.controller,
    this.child,
    this.maxLines = 1,
    this.minHeight = 52,
    this.keyboard = TextInputType.text,
  });

  final String label;
  final String? hint;
  final TextEditingController? controller;
  final Widget? child;
  final int maxLines;
  final double minHeight;
  final TextInputType keyboard;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppText.label(14)),
        const SizedBox(height: 8),
        child ??
            TextFormField(
              controller: controller,
              maxLines: maxLines,
              keyboardType: keyboard,
              decoration: _decoration(),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? '$label wajib diisi' : null,
            ),
      ],
    );
  }

  InputDecoration _decoration() => InputDecoration(
        hintText: hint ?? '',
        hintStyle: AppText.body(14, color: AppColors.secondary),
        filled: true,
        fillColor: AppColors.background,
        contentPadding: const EdgeInsets.all(16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
      );
}
