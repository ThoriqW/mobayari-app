import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import '../utils/global.colors.dart';

class PrintReceiptView extends StatefulWidget {
  const PrintReceiptView({super.key});

  @override
  State<PrintReceiptView> createState() => _PrintReceiptViewState();
}

class _PrintReceiptViewState extends State<PrintReceiptView> {
  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;

  bool _connected = false;
  BluetoothDevice? _device;
  String tips = 'Tidak ada printer yang terhubung';
  bool _clicked = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> initBluetooth() async {
    bluetoothPrint.startScan(timeout: const Duration(seconds: 4));
    bool isConnected = await bluetoothPrint.isConnected ?? false;

    bluetoothPrint.state.listen((state) {
      switch (state) {
        case BluetoothPrint.CONNECTED:
          setState(() {
            _connected = true;
            tips = 'Terhubung';
          });
          break;
        case BluetoothPrint.DISCONNECTED:
          setState(() {
            _connected = false;
            tips = 'Tidak Terhubung';
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

    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        _clicked = false; // Selesai inisialisasi
      });
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
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: GlobalColors.stroke,
                width: 1,
              ),
            ),
          ),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: GlobalColors.mainColor,
                elevation: 0,
              ),
              onPressed: _clicked
                  ? null
                  : _connected
                      ? null
                      : () {
                          setState(() => _clicked = true);
                          initBluetooth(); // set it to true now
                        },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 12.0),
                child: Text(
                  _connected ? "Cetak" : "Cari Printer",
                  style: TextStyle(
                      color: GlobalColors.whiteColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                Row(
                  children: [
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
                                    tips = 'Menghubungkan';
                                  });
                                  await bluetoothPrint.connect(_device!);
                                } else {
                                  setState(() {
                                    tips = 'Tidak ada printer yang dipilih';
                                  });
                                }
                              },
                        child: const Text('Hubungkan'),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
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
                                  tips = 'Memutuskan Printer';
                                });
                                await bluetoothPrint.disconnect();
                              }
                            : null,
                        child: const Text('Ganti Printer'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        onRefresh: () =>
            bluetoothPrint.startScan(timeout: Duration(seconds: 4)),
      ),
    );
  }
}
