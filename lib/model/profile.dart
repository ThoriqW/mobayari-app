class Profile {
  late String nama;
  late String email;
  late String alamat;
  late String nomorHp;
  late String image;

  Profile(
      {required this.nama,
      required this.email,
      required this.alamat,
      required this.nomorHp,
      required this.image});

  Map<String, dynamic> toJson() {
    return {
      'nama': nama,
      'email': email,
      'alamat': alamat,
      'nomorHp': nomorHp,
      'image': image
    };
  }
}
