import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobayari_app_dev/model/masyarakat.dart';
import 'package:mobayari_app_dev/views/payment.receipt.view.dart';
import 'package:mobayari_app_dev/views/widgets/checkbox.bulan.global.dart';
import '../model/payment.dart';
import '../utils/global.colors.dart';

class PaymentView extends StatefulWidget {
  const PaymentView({super.key, required this.data});
  final Masyarakat data;
  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  Map<String, int> listJenisKegiatan = {
    'Pilih Kegiatan': 0,
    'Rumah Tinggal TR4 Kelas IV Darurat': 10000,
    'Rumah Tinggala TR1 Kelas I Permanen Bertingkat': 35000,
    'Perguruan Tinggi': 100000,
  };
  String selectedKegiatan = 'Pilih Kegiatan';

  List<bool?> checkedStates = [];

  List<String> bulan = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'Mei',
    'Jun',
    'Jul',
    'Ags',
    'Sep',
    'Okt',
    'Nov',
    'Des'
  ];
  List<String> selectedBulan = [];

  void updateSelectedBulan(String bulanItem, bool isChecked) {
    if (isChecked) {
      selectedBulan.add(bulanItem);
    } else {
      selectedBulan.remove(bulanItem);
    }
  }

  var formatCurrency =
      NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0);

  DateTime newDate = DateTime.now();
  String harga = "";
  String currentTime = "";
  String total = "";
  String? errorText;

  DatabaseReference dbRef = FirebaseDatabase.instance.ref().child("Pembayaran");

  @override
  void initState() {
    super.initState();
    DateTime date = DateTime.now();
    newDate = DateTime(date.year, date.month - 1, date.day);
    currentTime = DateFormat('hh:mm:ss').format(date);
    harga = "${listJenisKegiatan[selectedKegiatan]}";
    selectedBulan.add(bulan[date.month - 1]);
    totalHarga(harga, selectedBulan.length);
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    "Jenis Kegiatan",
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
                        borderSide:
                            BorderSide(color: GlobalColors.stroke, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: GlobalColors.stroke, width: 2),
                      ),
                    ),
                    isDense: true,
                    value: selectedKegiatan,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedKegiatan = newValue!;
                        harga = "${listJenisKegiatan[selectedKegiatan]}";
                        totalHarga(harga, selectedBulan.length);
                      });
                    },
                    items: listJenisKegiatan.keys.map((kegiatan) {
                      return DropdownMenuItem<String>(
                        value: kegiatan,
                        child: Text(
                          kegiatan,
                          style: TextStyle(
                            color: listJenisKegiatan.keys.first == kegiatan
                                ? GlobalColors
                                    .subText
                                : null,
                            fontSize: 12,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    "Pilih Bulan",
                    style: TextStyle(
                        color: GlobalColors.textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                GridView.count(
                  crossAxisCount: 6, // Jumlah kolom
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: bulan.sublist(0, 6).map((bulanItem) {
                    DateTime now = DateTime.now();
                    int currentMonthIndex = now.month - 1;
                    bool isChecked = false;
                    if (bulan.indexOf(bulanItem) == currentMonthIndex) {
                      isChecked = true;
                    }
                    return CheckboxBulanGlobal(
                      isChecked: isChecked,
                      bulanItem: bulanItem,
                      onChanged: (isChecked) {
                        setState(() {
                          updateSelectedBulan(bulanItem, isChecked);
                          totalHarga(harga, selectedBulan.length);
                        });
                      },
                    );
                  }).toList(),
                ),
                GridView.count(
                  crossAxisCount: 6, // Jumlah kolom
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: bulan.sublist(6, 12).map((bulanItem) {
                    DateTime now = DateTime.now();
                    int currentMonthIndex = now.month - 1;
                    bool isChecked = false;
                    if (bulan.indexOf(bulanItem) == currentMonthIndex) {
                      isChecked = true;
                    }
                    return CheckboxBulanGlobal(
                      isChecked: isChecked,
                      bulanItem: bulanItem,
                      onChanged: (isChecked) {
                        setState(() {
                          updateSelectedBulan(bulanItem, isChecked);
                          totalHarga(harga, selectedBulan.length);
                        });
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Text(
              harga != ''
                  ? formatCurrency.format(listJenisKegiatan[selectedKegiatan])
                  : '0',
              style: TextStyle(color: GlobalColors.textColor, fontSize: 16),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                selectedKegiatan,
                style: TextStyle(color: GlobalColors.textColor, fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                DateFormat('dd-MM-yyyy').format(newDate),
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
                widget.data.nama,
                style: TextStyle(color: GlobalColors.textColor, fontSize: 16),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            if (errorText != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Text(
                  errorText!,
                  style: const TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
            const SizedBox(
              height: 25,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: GlobalColors.mainColor,
                  elevation: 0,
                ),
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              GlobalColors.mainColor),
                        ), // Show CircularProgressIndicator during delay.
                      );
                    },
                  );
                  Payment payment = Payment(
                    jenisKegiatan: selectedKegiatan,
                    harga: formatCurrency.format(int.parse(harga)),
                    bulan: selectedBulan.length.toString(),
                    namaBulan: selectedBulan,
                    idMasyarakat: widget.data.idPelanggan,
                    nama: widget.data.nama,
                    alamat: widget.data.alamat,
                    kelurahan: widget.data.kelurahan,
                    rt: widget.data.rt,
                    rw: widget.data.rw,
                    tanggalTransakasi:
                        "${DateFormat('dd-MM-yyyy').format(newDate)}\n$currentTime WITA",
                    total: total,
                  );
                  if (harga != "0" &&
                      selectedBulan.length.toString().isNotEmpty) {
                    Future.delayed(const Duration(seconds: 2), () {
                      return makePayment(
                          payment); // This returns a Future, no need to await it here.
                    }).then((_) {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(
                            context); // Close the CircularProgressIndicator dialog.
                      }
                      if (!mounted) return;
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentReceiptView(
                            data: payment,
                          ),
                        ),
                      );
                    });
                  } else {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(
                          context); // Close the CircularProgressIndicator dialog.
                    }
                    setState(() {
                      errorText = "Format pembayaran salah";
                    });
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 12.0),
                  child: Text(
                    "Bayar",
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
    );
  }

  void makePayment(Payment payment) {
    dbRef.push().set(payment.toJson());
  }
}
