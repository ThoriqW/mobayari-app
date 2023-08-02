import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobayari_app_dev/views/payment.receipt.view.dart';
import '../model/payment.dart';
import '../utils/global.colors.dart';

class PaymentView extends StatefulWidget {
  const PaymentView({super.key, required this.data});
  final String data;
  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  List<String> lishHarga = ['Rp 45.000', 'Rp 60.000'];
  int initialBulan = 1;
  final TextEditingController _bulanController = TextEditingController();
  var formatCurrency =
      NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0);

  DateTime newDate = DateTime.now();
  String harga = "";
  String currentTime = "";
  String total = "";

  @override
  void initState() {
    super.initState();
    DateTime date = DateTime.now();
    newDate = DateTime(date.year, date.month - 1, date.day);
    currentTime = DateFormat('hh:mm:ss').format(date);
    harga = lishHarga[0];
    _bulanController.text = initialBulan.toString();
    totalHarga(harga, initialBulan);
  }

  void _tambahBulan() {
    setState(() {
      initialBulan++;
      _bulanController.text = initialBulan.toString();
    });
    totalHarga(harga, initialBulan);
  }

  void _kurangBulan() {
    if (initialBulan > 1) {
      setState(() {
        initialBulan--;
        _bulanController.text = initialBulan.toString();
      });
    }
    totalHarga(harga, initialBulan);
  }

  void totalHarga(harga, bulan) {
    double numericValue = double.parse(harga.replaceAll(RegExp(r'[^0-9]'), ''));
    double multipliedValue = numericValue * bulan;
    setState(() {
      total = formatCurrency.format(multipliedValue);
    });
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
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Pembayaran",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity, // Set width to full screen width
              height: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: GlobalColors.mainColor),
              child: Center(
                child: Text(
                  total,
                  style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: GlobalColors.whiteColor),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          "Harga",
                          style: TextStyle(
                              color: GlobalColors.textColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Form(
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: GlobalColors.stroke, width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: GlobalColors.stroke, width: 2),
                            ),
                          ),
                          isDense: true,
                          value: harga,
                          onChanged: (String? newValue) {
                            setState(() {
                              harga = newValue!;
                              initialBulan = 1;
                              totalHarga(harga, initialBulan);
                            });
                          },
                          items: lishHarga.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            "Bulan",
                            style: TextStyle(
                                color: GlobalColors.textColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        TextFormField(
                          controller: _bulanController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: GlobalColors.stroke, width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: GlobalColors.stroke, width: 2),
                            ),
                            suffixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: _kurangBulan,
                                  icon: const Icon(Icons.remove),
                                ),
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      initialBulan.toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: _tambahBulan,
                                  icon: const Icon(Icons.add),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                "Pembayaran Sampah",
                style: TextStyle(color: GlobalColors.textColor, fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                DateFormat('yyyy-MM-dd').format(newDate),
                style: TextStyle(color: GlobalColors.textColor, fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                currentTime,
                style: TextStyle(color: GlobalColors.textColor, fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                widget.data,
                style: TextStyle(color: GlobalColors.textColor, fontSize: 16),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: GlobalColors.mainColor,
                  elevation: 0,
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentReceiptView(
                        data: Payment(
                          name: widget.data,
                          tanggalTransakasi:
                              "${DateFormat('yyyy-MM-dd').format(newDate)}\n$currentTime WITA",
                          harga: harga,
                          bulan: initialBulan.toString(),
                          total: total,
                        ),
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 12.0),
                  child: Text(
                    "Bayar",
                    style:
                        TextStyle(color: GlobalColors.whiteColor, fontSize: 16),
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
    );
  }
}
