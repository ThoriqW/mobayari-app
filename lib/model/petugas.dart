class Petugas {
  late String nama;
  late String alamat;
  late String kelurahan;
  late String email;
  late String noHP;
  late String image;

  Petugas(
      {required this.nama,
      required this.alamat,
      required this.kelurahan,
      required this.email,
      required this.noHP,
      required this.image});

  Map<String, dynamic> toJson() {
    return {
      'nama': nama,
      'alamat': alamat,
      'kelurahan': kelurahan,
      'email': email,
      'noHP': noHP,
      'image': image
    };
  }
}
