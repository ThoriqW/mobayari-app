import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobayari_app_dev/model/payment.dart';
import '../utils/global.colors.dart';
import 'print.receipt.view.dart';

class PaymentReceiptView extends StatefulWidget {
  const PaymentReceiptView({super.key, required this.data});

  final Payment data;

  @override
  State<PaymentReceiptView> createState() => _PaymentReceiptViewState();
}

class _PaymentReceiptViewState extends State<PaymentReceiptView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: GlobalColors.textColor,
        elevation: 0,
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: GlobalColors.stroke,
                width: 1,
              ),
            ),
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PrintReceiptView(data: widget.data,)));
            },
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.print,
                  size: 32,
                ),
                SizedBox(height: 5),
                Text(
                  'Cetak',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              child: SvgPicture.asset(
                "assets/images/logo-mobayari-1.svg",
                height: 50,
                colorFilter:
                    ColorFilter.mode(GlobalColors.mainColor, BlendMode.srcIn),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Center(
              child: Column(
                children: [
                  const Text(
                    "Bukti Transaksi",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.data.name,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "TGL TRANSAKSI",
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  widget.data.tanggalTransakasi,
                  textAlign: TextAlign.right,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Divider(
                height: 1,
                color: GlobalColors.stroke,
                thickness: 2,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "HARGA",
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  widget.data.harga,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "BULAN",
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  widget.data.bulan,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Divider(
                height: 1,
                color: GlobalColors.stroke,
                thickness: 2,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "TOTAL",
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  widget.data.total,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
