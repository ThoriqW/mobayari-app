class Payment {
  String? id;
  late String jenisKegiatan;
  late String harga;
  late String bulan;
  late List<String> namaBulan;
  late String idMasyarakat;
  late String nama;
  late String alamat;
  late String kelurahan;
  late String rt;
  late String rw;
  late String tanggalTransakasi;
  late String total;

  Payment({
    this.id,
    required this.jenisKegiatan,
    required this.harga,
    required this.bulan,
    required this.namaBulan,
    required this.idMasyarakat,
    required this.nama,
    required this.alamat,
    required this.kelurahan,
    required this.rt,
    required this.rw,
    required this.tanggalTransakasi,
    required this.total,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'jenisKegiatan': jenisKegiatan,
      'harga': harga,
      'bulan': bulan,
      'namaBulan': namaBulan,
      'idMasyarakat': idMasyarakat,
      'nama': nama,
      'alamat': alamat,
      'kelurahan': kelurahan,
      'rt': rt,
      'rw': rw,
      'tanggalTransakasi': tanggalTransakasi,
      'total': total,
    };
  }
}
