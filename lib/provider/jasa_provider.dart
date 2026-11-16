import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../config/api_config.dart';
import '../model/jasa.dart';

/// Global state (modul 13): ChangeNotifier + notifyListeners().
/// Semua proses CRUD Jasa (modul 12) lewat sini.
class JasaProvider extends ChangeNotifier {
  JasaProvider({http.Client? client})
      : _client = client ?? http.Client();

  final http.Client _client;

  List<Jasa> _list = [];
  bool _loading = false;
  String? _error;

  List<Jasa> get list => List.unmodifiable(_list);
  bool get loading => _loading;
  String? get error => _error;

  Jasa? byId(int id) {
    for (final jasa in _list) {
      if (jasa.id == id) return jasa;
    }
    return null;
  }

  Future<void> fetch() async {
    _setLoading(true);
    try {
      final response = await _client.get(Uri.parse(ApiConfig.list));
      final body = json.decode(response.body) as Map<String, dynamic>;
      if (body['success'] == true) {
        final data = body['data'] as List<dynamic>;
        _list = data.map((e) => Jasa.fromJson(e as Map<String, dynamic>)).toList();
        _error = null;
      } else {
        _error = body['message']?.toString() ?? 'Gagal memuat data';
      }
    } catch (e) {
      _error = 'Tidak terhubung ke server: $e';
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> create({
    required String nama,
    required String kategori,
    required int harga,
    required String deskripsi,
  }) async {
    _setLoading(true);
    try {
      final response = await _client.post(
        Uri.parse(ApiConfig.create),
        body: {
          'nama': nama,
          'kategori': kategori,
          'harga': harga.toString(),
          'deskripsi': deskripsi,
        },
      );
      final body = json.decode(response.body) as Map<String, dynamic>;
      final ok = body['success'] == true;
      if (ok) await fetch();
      return ok;
    } catch (_) {
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> update({
    required int id,
    required String nama,
    required String kategori,
    required int harga,
    required String deskripsi,
  }) async {
    _setLoading(true);
    try {
      final response = await _client.post(
        Uri.parse(ApiConfig.update),
        body: {
          'id': id.toString(),
          'nama': nama,
          'kategori': kategori,
          'harga': harga.toString(),
          'deskripsi': deskripsi,
        },
      );
      final body = json.decode(response.body) as Map<String, dynamic>;
      final ok = body['success'] == true;
      if (ok) await fetch();
      return ok;
    } catch (_) {
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> delete(int id) async {
    _setLoading(true);
    try {
      final response = await _client.post(
        Uri.parse(ApiConfig.delete),
        body: {'id': id.toString()},
      );
      final body = json.decode(response.body) as Map<String, dynamic>;
      final ok = body['success'] == true;
      if (ok) await fetch();
      return ok;
    } catch (_) {
      return false;
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }
}
