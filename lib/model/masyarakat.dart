class Masyarakat {
  late String idUser;
  late String name;
  late String alamat;
  late String kecamatan;
  late String nomorHp;

  Masyarakat({
    required this.idUser,
    required this.name,
    required this.alamat,
    required this.kecamatan,
    required this.nomorHp,
  });

  Map<String, dynamic> toJson() {
    return {
      'idUser': idUser,
      'name': name,
      'alamat': alamat,
      'kecamatan': kecamatan,
      'nomorHp': nomorHp,
    };
  }
}
