class Masyarakat {
  String? id;
  late String nama;
  late String nomorKartuKeluarga;
  late String pekerjaan;
  late String alamat;
  late String rt;
  late String rw;
  late String idPelanggan;
  late String kelurahan;
  late String nomorTelepon;
  String? keterangan;

  Masyarakat({
    this.id,
    required this.nama,
    required this.nomorKartuKeluarga,
    required this.pekerjaan,
    required this.alamat,
    required this.rt,
    required this.rw,
    required this.idPelanggan,
    required this.kelurahan,
    required this.nomorTelepon,
    this.keterangan
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'nomorKartuKeluarga': nomorKartuKeluarga,
      'pekerjaan': pekerjaan,
      'alamat': alamat,
      'rt': rt,
      'rw': rw,
      'idPelanggan': idPelanggan,
      'kelurahan': kelurahan,
      'nomorTelepon': nomorTelepon,
      'keterangan': keterangan
    };
  }
}
