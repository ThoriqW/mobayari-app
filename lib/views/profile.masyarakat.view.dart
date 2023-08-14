import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mobayari_app_dev/views/edit.masyarakat.view.dart';
import 'package:mobayari_app_dev/views/history.payment.view.dart';
import 'package:mobayari_app_dev/views/payment.view.dart';
import '../model/masyarakat.dart';
import '../utils/global.colors.dart';

class UserProfileView extends StatefulWidget {
  const UserProfileView({super.key, required this.data});

  final Masyarakat data;

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  DatabaseReference dbRef = FirebaseDatabase.instance.ref().child("Pembayaran");
  final Map<String, int> mappingBulan = {
    "Jan": 1,
    "Feb": 2,
    "Mar": 3,
    "Apr": 4,
    "Mei": 5,
    "Jun": 6,
    "Jul": 7,
    "Ags": 8,
    "Sep": 9,
    "Okt": 10,
    "Nov": 11,
    "Des": 12,
  };
  List<String> namaBulan = [];
  List<String> tempNamaBulan = [];

  @override
  void initState() {
    super.initState();
    readBulanDibayar();
  }

  void readBulanDibayar() async {
    String? idMasyarakat = widget.data.idPelanggan;
    Query query = dbRef.orderByChild("idMasyarakat").equalTo(idMasyarakat);
    DatabaseEvent event = await query.once();
    DataSnapshot snapshot = event.snapshot;
    if (snapshot.value != null) {
      Map<dynamic, dynamic> bulanDibayar =
          snapshot.value as Map<dynamic, dynamic>;
      bulanDibayar.forEach((key, value) {
        tempNamaBulan
            .addAll((value['namaBulan'] as List<dynamic>).cast<String>());
      });
      // Sort the month names using the mappingBulan map
      tempNamaBulan.sort((a, b) {
        int orderA = mappingBulan[a] ?? 0;
        int orderB = mappingBulan[b] ?? 0;
        return orderA - orderB;
      });
      print(tempNamaBulan);
      setState(() {
        namaBulan = tempNamaBulan; // Update the state with sorted month names
      });
      print(namaBulan);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: GlobalColors.textColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Profile Masyarakat",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: GlobalColors.mainColor),
                  ),
                  PopupMenuButton<String>(
                    icon: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: GlobalColors.mainColor,
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10)
                        ],
                      ),
                      child: Icon(
                        Icons.filter_list,
                        color: GlobalColors.whiteColor,
                      ),
                    ),
                    onSelected: (String result) {
                      switch (result) {
                        case 'Edit':
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditMasyarakatView(
                                      masyarakat: widget.data)));
                          break;
                        default:
                      }
                    },
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<String>>[
                      const PopupMenuItem<String>(
                        value: 'Edit',
                        child: Text('Edit'),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Nama",
                    style: TextStyle(
                      color: GlobalColors.subText,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    widget.data.nama,
                    style: TextStyle(
                        color: GlobalColors.textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Divider(
                    height: 1,
                    color: GlobalColors.stroke,
                    thickness: 2,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "No KK",
                    style: TextStyle(
                      color: GlobalColors.subText,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    widget.data.noKK,
                    style: TextStyle(
                        color: GlobalColors.textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Divider(
                    height: 1,
                    color: GlobalColors.stroke,
                    thickness: 2,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Alamat",
                    style: TextStyle(color: GlobalColors.subText, fontSize: 12),
                  ),
                  Text(
                    widget.data.alamat,
                    style: TextStyle(
                        color: GlobalColors.textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Divider(
                    height: 1,
                    color: GlobalColors.stroke, // Warna garis bawah
                    thickness: 2, // Ketebalan garis bawah
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Pekerjaan",
                    style: TextStyle(
                      color: GlobalColors.subText,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    widget.data.pekerjaan,
                    style: TextStyle(
                        color: GlobalColors.textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Divider(
                    height: 1,
                    color: GlobalColors.stroke,
                    thickness: 2,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "RT",
                    style: TextStyle(
                      color: GlobalColors.subText,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    widget.data.rt,
                    style: TextStyle(
                        color: GlobalColors.textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Divider(
                    height: 1,
                    color: GlobalColors.stroke,
                    thickness: 2,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "RW",
                    style: TextStyle(
                      color: GlobalColors.subText,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    widget.data.rw,
                    style: TextStyle(
                        color: GlobalColors.textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Divider(
                    height: 1,
                    color: GlobalColors.stroke,
                    thickness: 2,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "ID Pelanggan",
                    style: TextStyle(
                      color: GlobalColors.subText,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    widget.data.idPelanggan,
                    style: TextStyle(
                        color: GlobalColors.textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Divider(
                    height: 1,
                    color: GlobalColors.stroke,
                    thickness: 2,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Kelurahan",
                    style: TextStyle(color: GlobalColors.subText, fontSize: 12),
                  ),
                  Text(
                    widget.data.kelurahan,
                    style: TextStyle(
                        color: GlobalColors.textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Divider(
                    height: 1,
                    color: GlobalColors.stroke, // Warna garis bawah
                    thickness: 2, // Ketebalan garis bawah
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Nomor HP",
                    style: TextStyle(color: GlobalColors.subText, fontSize: 12),
                  ),
                  Text(
                    widget.data.noHP,
                    style: TextStyle(
                        color: GlobalColors.textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Divider(
                    height: 1,
                    color: GlobalColors.stroke, // Warna garis bawah
                    thickness: 2, // Ketebalan garis bawah
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Bulan Dibayar",
                    style: TextStyle(color: GlobalColors.subText, fontSize: 12),
                  ),
                  Text(
                    namaBulan.join(" "),
                    style: TextStyle(
                        color: GlobalColors.textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Divider(
                    height: 1,
                    color: GlobalColors.stroke, // Warna garis bawah
                    thickness: 2, // Ketebalan garis bawah
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              TextButton(
                style: TextButton.styleFrom(
                  side: BorderSide(
                    color: GlobalColors.mainColor,
                    width: 2.0,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: Icon(
                          Icons.history,
                          color: GlobalColors.mainColor,
                        ),
                      ),
                      Text(
                        "Histori Pembayaran",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: GlobalColors.textColor,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HistoryPayment(
                        data: widget.data,
                      ),
                    ),
                  )
                },
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: GlobalColors.mainColor,
                    elevation: 0,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                PaymentView(data: widget.data)));
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 12.0),
                    child: Text(
                      "Lakukan Pembayaran",
                      style: TextStyle(
                          color: GlobalColors.whiteColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
