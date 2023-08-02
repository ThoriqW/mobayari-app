import 'package:flutter/material.dart';
import 'package:mobayari_app_dev/model/User.dart';
import 'package:mobayari_app_dev/views/payment.view.dart';
import '../utils/global.colors.dart';

class UserProfileView extends StatefulWidget {
  const UserProfileView({super.key, required this.data});

  final User data;

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: GlobalColors.textColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Profile Masyarakat",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 50,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Nama",
                  style: TextStyle(color: GlobalColors.subText, fontSize: 12),
                ),
                Text(
                  widget.data.name,
                  style: TextStyle(
                    color: GlobalColors.textColor,
                    fontSize: 16,
                  ),
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
                  ),
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
                  "Kecamatan",
                  style: TextStyle(color: GlobalColors.subText, fontSize: 12),
                ),
                Text(
                  widget.data.kecamatan,
                  style: TextStyle(
                    color: GlobalColors.textColor,
                    fontSize: 16,
                  ),
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
                  widget.data.nomorHp,
                  style: TextStyle(
                    color: GlobalColors.textColor,
                    fontSize: 16,
                  ),
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
              height: 50,
            ),
            Text(
              "Histori Pembayaran",
              style: TextStyle(
                color: GlobalColors.textColor,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: GlobalColors.mainColor,
                elevation: 0,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PaymentView(data: widget.data.name)));
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 12.0),
                child: Text(
                  "Lakukan Pembayaran",
                  style:
                      TextStyle(color: GlobalColors.whiteColor, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
