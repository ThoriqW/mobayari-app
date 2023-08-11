class Masyarakat {
  String? id;
  late String nama;
  late String noKK;
  late String pekerjaan;
  late String alamat;
  late String rt;
  late String rw;
  late String idPelanggan;
  late String kelurahan;
  late String noHP;
  String? keterangan;

  Masyarakat({
    this.id,
    required this.nama,
    required this.noKK,
    required this.pekerjaan,
    required this.alamat,
    required this.rt,
    required this.rw,
    required this.idPelanggan,
    required this.kelurahan,
    required this.noHP,
    this.keterangan
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'noKK': noKK,
      'pekerjaan': pekerjaan,
      'alamat': alamat,
      'rt': rt,
      'rw': rw,
      'idPelanggan': idPelanggan,
      'kelurahan': kelurahan,
      'noHP': noHP,
      'keterangan': keterangan
    };
  }
}
