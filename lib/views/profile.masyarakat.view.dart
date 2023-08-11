import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
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
              Text(
                "Profile Masyarakat",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: GlobalColors.mainColor),
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
              TextButton(
                style: TextButton.styleFrom(
                  side: BorderSide(
                    color:
                        GlobalColors.mainColor, // Set the color of the border
                    width: 2.0, // Set the width of the border
                  ),
                  // You can also set other properties like padding, minimumSize, etc.
                ),
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
