class Payment {
  late String idUser;
  late String name;
  late String tanggalTransakasi;
  late String bulan;
  late String harga;
  late String total;

  Payment({
    required this.idUser,
    required this.name,
    required this.tanggalTransakasi,
    required this.bulan,
    required this.harga,
    required this.total,
  });

  Map<String, dynamic> toJson() {
    return {
      'idUser': idUser,
      'name': name,
      'tanggalTransakasi': tanggalTransakasi,
      'bulan': bulan,
      'harga': harga,
      'total': total,
    };
  }
}
