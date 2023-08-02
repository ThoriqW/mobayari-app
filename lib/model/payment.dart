class Payment {
  late String name;
  late String tanggalTransakasi;
  late String bulan;
  late String harga;
  late String total;

  Payment({
    required this.name,
    required this.tanggalTransakasi,
    required this.bulan,
    required this.harga,
    required this.total,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'tanggalTransakasi': tanggalTransakasi,
      'bulan': bulan,
      'harga': harga,
      'total': total,
    };
  }
}
