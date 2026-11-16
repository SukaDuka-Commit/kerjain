/// Model entitas Jasa — satu-satunya tabel yang di-CRUD.
class Jasa {
  final int id;
  final String nama;
  final String kategori;
  final int harga;
  final String deskripsi;

  const Jasa({
    required this.id,
    required this.nama,
    required this.kategori,
    required this.harga,
    required this.deskripsi,
  });

  factory Jasa.fromJson(Map<String, dynamic> json) {
    return Jasa(
      id: int.parse(json['id'].toString()),
      nama: json['nama'].toString(),
      kategori: json['kategori'].toString(),
      harga: int.parse(json['harga'].toString()),
      deskripsi: json['deskripsi'].toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        'nama': nama,
        'kategori': kategori,
        'harga': harga,
        'deskripsi': deskripsi,
      };
}
