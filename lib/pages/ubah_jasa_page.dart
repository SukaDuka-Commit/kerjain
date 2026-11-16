import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/jasa.dart';
import '../provider/jasa_provider.dart';
import '../theme.dart';

/// UPDATE. Memakai context.read (modul 13).
class UbahJasaPage extends StatefulWidget {
  const UbahJasaPage({super.key, required this.jasa});

  final Jasa jasa;

  @override
  State<UbahJasaPage> createState() => _UbahJasaPageState();
}

class _UbahJasaPageState extends State<UbahJasaPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nama;
  late final TextEditingController _kategori;
  late final TextEditingController _harga;
  late final TextEditingController _deskripsi;

  @override
  void initState() {
    super.initState();
    _nama = TextEditingController(text: widget.jasa.nama);
    _kategori = TextEditingController(text: widget.jasa.kategori);
    _harga = TextEditingController(text: widget.jasa.harga.toString());
    _deskripsi = TextEditingController(text: widget.jasa.deskripsi);
  }

  @override
  void dispose() {
    _nama.dispose();
    _kategori.dispose();
    _harga.dispose();
    _deskripsi.dispose();
    super.dispose();
  }

  Future<void> _simpan() async {
    if (!_formKey.currentState!.validate()) return;

    final ok = await context.read<JasaProvider>().update(
          id: widget.jasa.id,
          nama: _nama.text.trim(),
          kategori: _kategori.text.trim(),
          harga: int.parse(_harga.text.replaceAll(RegExp(r'[^0-9]'), '')),
          deskripsi: _deskripsi.text.trim(),
        );

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(ok ? 'Jasa diperbarui' : 'Gagal memperbarui')),
    );
    if (ok) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final loading = context.watch<JasaProvider>().loading;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ubah Jasa'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            _field(label: 'Nama jasa', controller: _nama),
            const SizedBox(height: 16),
            _field(label: 'Kategori', controller: _kategori),
            const SizedBox(height: 16),
            _field(
              label: 'Harga',
              controller: _harga,
              keyboard: TextInputType.number,
            ),
            const SizedBox(height: 16),
            _field(label: 'Deskripsi', controller: _deskripsi),
            const SizedBox(height: 24),
            SizedBox(
              height: 52,
              child: ElevatedButton(
                onPressed: loading ? null : _simpan,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                ),
                child: loading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Simpan Perubahan'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _field({
    required String label,
    required TextEditingController controller,
    TextInputType keyboard = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboard,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator: (v) => (v == null || v.trim().isEmpty) ? '$label wajib diisi' : null,
    );
  }
}
