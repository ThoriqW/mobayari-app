class User {
  late String name;
  late String alamat;
  late String kecamatan;
  late String nomorHp;

  User({
    required this.name,
    required this.alamat,
    required this.kecamatan,
    required this.nomorHp,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'alamat': alamat,
      'kecamatan': kecamatan,
      'nomorHp': nomorHp,
    };
  }
}
