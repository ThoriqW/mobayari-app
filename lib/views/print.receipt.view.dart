import 'dart:convert';

import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import '../model/payment.dart';
import '../utils/global.colors.dart';

class PrintReceiptView extends StatefulWidget {
  const PrintReceiptView({super.key, required this.data});

  final Payment data;

  @override
  State<PrintReceiptView> createState() => _PrintReceiptViewState();
}

class _PrintReceiptViewState extends State<PrintReceiptView> {
  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;

  bool _connected = false;
  BluetoothDevice? _device;
  String tips = 'Tidak ada printer yang terhubung';

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => initBluetooth());
  }

  Future<void> initBluetooth() async {
    bluetoothPrint.startScan(timeout: const Duration(seconds: 4));

    bool isConnected = await bluetoothPrint.isConnected ?? false;

    bluetoothPrint.state.listen((state) {
      switch (state) {
        case BluetoothPrint.CONNECTED:
          setState(() {
            _connected = true;
            tips = 'Berhasil terhubung';
          });
          break;
        case BluetoothPrint.DISCONNECTED:
          setState(() {
            _connected = false;
            tips = 'Berhasil diputuskan';
          });
          break;
        default:
          break;
      }
    });

    if (!mounted) return;

    if (isConnected) {
      setState(() {
        _connected = true;
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
      body: RefreshIndicator(
        onRefresh: () =>
            bluetoothPrint.startScan(timeout: Duration(seconds: 4)),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Daftar Printer",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: GlobalColors.mainColor),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  tips,
                  style: TextStyle(color: GlobalColors.subText),
                ),
                const Divider(),
                StreamBuilder<List<BluetoothDevice>>(
                  stream: bluetoothPrint.scanResults,
                  initialData: [],
                  builder: (c, snapshot) => Column(
                    children: snapshot.data!
                        .map((d) => ListTile(
                              title: Text(d.name ?? ''),
                              subtitle: Text(d.address ?? ''),
                              onTap: () async {
                                setState(() {
                                  _device = d;
                                });
                              },
                              trailing: _device != null &&
                                      _device!.address == d.address
                                  ? const Icon(
                                      Icons.check,
                                      color: Colors.green,
                                    )
                                  : null,
                            ))
                        .toList(),
                  ),
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: GlobalColors.mainColor,
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: _connected
                            ? null
                            : () async {
                                if (_device != null &&
                                    _device!.address != null) {
                                  setState(() {
                                    tips = 'Menghubungkan...';
                                  });
                                  await bluetoothPrint.connect(_device!);
                                } else {
                                  setState(() {
                                    tips = 'Pilih Printer';
                                  });
                                  print('Pilih Printer');
                                }
                              },
                        child: const Text('Hubungkan'),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: GlobalColors.mainColor,
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: _connected
                            ? () async {
                                setState(() {
                                  tips = 'Memutuskan...';
                                });
                                await bluetoothPrint.disconnect();
                              }
                            : null,
                        child: const Text('Ganti Printer'),
                      ),
                    ),
                  ],
                ),
                const Divider(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: GlobalColors.mainColor,
                      elevation: 0,
                    ),
                    onPressed: _connected
                        ? () async {
                            Map<String, dynamic> config = Map();

                            List<LineText> list = [];

                            ByteData data = await rootBundle
                                .load("assets/images/logo-receipt-bg.jpg");
                            List<int> imageBytes = data.buffer.asUint8List(
                                data.offsetInBytes, data.lengthInBytes);
                            String base64Image = base64Encode(imageBytes);
                            list.add(LineText(
                                type: LineText.TYPE_IMAGE,
                                x: 10,
                                y: 20,
                                width: 350,
                                content: base64Image,
                                align: LineText.ALIGN_CENTER,
                                linefeed: 1));
                            list.add(LineText(linefeed: 1));
                            list.add(LineText(
                                type: LineText.TYPE_TEXT,
                                content: 'Bukti Transaksi',
                                weight: 1,
                                align: LineText.ALIGN_CENTER,
                                linefeed: 1));
                            list.add(LineText(
                                type: LineText.TYPE_TEXT,
                                content: widget.data.name,
                                weight: 1,
                                align: LineText.ALIGN_CENTER,
                                fontZoom: 2,
                                linefeed: 1));
                            list.add(LineText(linefeed: 1));
                            list.add(LineText(
                                type: LineText.TYPE_TEXT,
                                content: '- - - - - - - - - - - - - - - -',
                                weight: 1,
                                align: LineText.ALIGN_CENTER,
                                linefeed: 1));
                            list.add(LineText(
                                type: LineText.TYPE_TEXT,
                                content: 'TGL TRANSAKSI:',
                                weight: 1,
                                align: LineText.ALIGN_LEFT,
                                linefeed: 1));
                            list.add(LineText(
                                type: LineText.TYPE_TEXT,
                                content: widget.data.tanggalTransakasi,
                                weight: 1,
                                align: LineText.ALIGN_LEFT,
                                linefeed: 1));
                            list.add(LineText(
                                type: LineText.TYPE_TEXT,
                                content: '- - - - - - - - - - - - - - - -',
                                weight: 1,
                                align: LineText.ALIGN_CENTER,
                                linefeed: 1));
                            list.add(LineText(
                                type: LineText.TYPE_TEXT,
                                content: 'HARGA',
                                align: LineText.ALIGN_LEFT,
                                x: 0,
                                relativeX: 0,
                                linefeed: 0));
                            list.add(LineText(
                                type: LineText.TYPE_TEXT,
                                content: widget.data.harga,
                                align: LineText.ALIGN_LEFT,
                                x: 260,
                                relativeX: 0,
                                linefeed: 0));
                            list.add(LineText(linefeed: 1));
                            list.add(LineText(
                                type: LineText.TYPE_TEXT,
                                content: 'BULAN',
                                align: LineText.ALIGN_LEFT,
                                x: 0,
                                relativeX: 0,
                                linefeed: 0));
                            list.add(LineText(
                                type: LineText.TYPE_TEXT,
                                content: widget.data.bulan,
                                align: LineText.ALIGN_LEFT,
                                x: 260,
                                relativeX: 0,
                                linefeed: 0));
                            list.add(LineText(linefeed: 1));
                            list.add(LineText(
                                type: LineText.TYPE_TEXT,
                                content: '- - - - - - - - - - - - - - - -',
                                weight: 1,
                                align: LineText.ALIGN_CENTER,
                                linefeed: 1));
                            list.add(LineText(
                                type: LineText.TYPE_TEXT,
                                content: 'TOTAL',
                                align: LineText.ALIGN_LEFT,
                                x: 0,
                                relativeX: 0,
                                linefeed: 0));
                            list.add(LineText(
                                type: LineText.TYPE_TEXT,
                                content: widget.data.total,
                                align: LineText.ALIGN_LEFT,
                                x: 250,
                                relativeX: 0,
                                linefeed: 0));
                            list.add(LineText(linefeed: 1));
                            list.add(LineText(linefeed: 1));
                            list.add(LineText(linefeed: 1));

                            await bluetoothPrint.printReceipt(config, list);
                          }
                        : null,
                    child: Padding(
                      padding:
                          const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 12.0),
                      child: Text(
                        _connected ? "Cetak" : "Cari Printer",
                        style: TextStyle(
                            color: GlobalColors.whiteColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
