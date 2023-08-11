import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mobayari_app_dev/views/payment.receipt.view.dart';

import '../model/masyarakat.dart';
import '../model/payment.dart';
import '../utils/global.colors.dart';

class HistoryPayment extends StatefulWidget {
  const HistoryPayment({super.key, required this.data});
  final Masyarakat data;

  @override
  State<HistoryPayment> createState() => _HistoryPaymentState();
}

class _HistoryPaymentState extends State<HistoryPayment> {
  DatabaseReference dbRef = FirebaseDatabase.instance.ref().child("Pembayaran");
  List<Payment> historyPayment = [];
  List<Payment> historyPaymentDisplay = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    readHistoryPayment();
  }

  void readHistoryPayment() async {
    setState(() {
      isLoading = true;
    });
    String? idMasyarakat = widget.data.idPelanggan;
    Query query = dbRef.orderByChild("idMasyarakat").equalTo(idMasyarakat);
    DatabaseEvent event = await query.once();
    DataSnapshot snapshot = event.snapshot;
    if (snapshot.value != null) {
      Map<dynamic, dynamic> historyPembayaran =
          snapshot.value as Map<dynamic, dynamic>;
      historyPembayaran.forEach((key, value) {
        List<String> namaBulan =
            (value['namaBulan'] as List<dynamic>).cast<String>();
        Payment payment = Payment(
            jenisKegiatan: value['jenisKegiatan'],
            harga: value['harga'],
            bulan: value['bulan'],
            namaBulan: namaBulan,
            idMasyarakat: value['idMasyarakat'],
            nama: value['nama'],
            alamat: value['alamat'],
            kelurahan: value['kelurahan'],
            rt: value['rt'],
            rw: value['rw'],
            tanggalTransakasi: value['tanggalTransakasi'],
            total: value['total']);
        historyPayment.add(payment);
      });
      historyPayment
          .sort(((a, b) => b.tanggalTransakasi.compareTo(a.tanggalTransakasi)));
      setState(() {
        historyPaymentDisplay = historyPayment;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
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
              Text(
                "Histori Pembayaran",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: GlobalColors.mainColor),
              ),
              const SizedBox(
                height: 20,
              ),
              isLoading
                  ? Center(
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              GlobalColors.mainColor),
                        ),
                      ),
                    )
                  : historyPaymentDisplay.isEmpty
                      ? Center(
                          child: Text(
                            "Data tidak ada",
                            style: TextStyle(
                              color: GlobalColors.textColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: historyPaymentDisplay.length,
                          itemBuilder: (context, index) {
                            Payment payment = historyPaymentDisplay[index];
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PaymentReceiptView(
                                      data: payment,
                                    ),
                                  ),
                                );
                              },
                              child: Column(
                                children: [
                                  ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          payment.tanggalTransakasi,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          payment.total,
                                          style: TextStyle(
                                              color: GlobalColors.mainColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, bottom: 8.0),
                                    child: Divider(
                                      height: 1,
                                      color: GlobalColors.stroke,
                                      thickness: 2,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
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
