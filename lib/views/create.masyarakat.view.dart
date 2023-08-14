import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mobayari_app_dev/model/masyarakat.dart';
import 'package:mobayari_app_dev/views/main.view.dart';
import 'package:mobayari_app_dev/views/widgets/text.form.global.dart';
import '../utils/global.colors.dart';

class CreateUserView extends StatefulWidget {
  const CreateUserView({super.key});

  @override
  State<CreateUserView> createState() => _CreateUserViewState();
}

class _CreateUserViewState extends State<CreateUserView> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _noKKController = TextEditingController();
  final TextEditingController _pekerjaanController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _rtController = TextEditingController();
  final TextEditingController _rwController = TextEditingController();
  final TextEditingController _idPelangganController = TextEditingController();
  final TextEditingController _kelurahanController = TextEditingController();
  final TextEditingController _noHPController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  late DatabaseReference dbRef;

  List<String> kelurahanItems = [
    'Besusu Timur',
  ];

  List<String> rtItems = [
    'RT 01',
    'RT 02',
    'RT 03',
    'RT 04',
    'RT 05',
  ];

  List<String> rwItems = [
    'RW 01',
    'RW 02',
    'RW 03',
    'RW 04',
  ];

  String? selectedKelurahan;
  String? selectedRT;
  String? selectedRW;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child("Masyarakat");
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
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "Tambah Data Masyarakat",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: GlobalColors.mainColor),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                width: double.infinity,
                decoration: BoxDecoration(color: GlobalColors.bgGray),
                child: Text("Kontak",
                    style: TextStyle(
                        color: GlobalColors.subText,
                        fontWeight: FontWeight.bold)),
              ),
              TextFormGlobal(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama tidak boleh kosong';
                  }
                  return null; // Return null for successful validation
                },
                controller: _namaController,
                text: "Nama Lengkap",
                textInputType: TextInputType.name,
                obscure: false,
              ),
              TextFormGlobal(
                controller: _noHPController,
                text: "Nomor Telepon",
                textInputType: TextInputType.phone,
                obscure: false,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                width: double.infinity,
                decoration: BoxDecoration(color: GlobalColors.bgGray),
                child: Text("Alamat",
                    style: TextStyle(
                        color: GlobalColors.subText,
                        fontWeight: FontWeight.bold)),
              ),
              TextFormGlobal(
                controller: _alamatController,
                text: "Nama Jalan",
                textInputType: TextInputType.streetAddress,
                obscure: false,
              ),
              Form(
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: GlobalColors.stroke, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: GlobalColors.mainColor, width: 2),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 15.0),
                  ),
                  isDense: true,
                  value: selectedKelurahan,
                  onChanged: (String? newValue) {
                    setState(() {
                      _kelurahanController.text = newValue ?? '';
                    });
                  },
                  items: kelurahanItems.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    );
                  }).toList(),
                  hint: const Text("Kelurahan",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
              Form(
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: GlobalColors.stroke, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: GlobalColors.mainColor, width: 2),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 15.0),
                  ),
                  isDense: true,
                  value: selectedRT,
                  onChanged: (String? newValue) {
                    setState(() {
                      _rtController.text = newValue ?? '';
                    });
                  },
                  items: rtItems.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    );
                  }).toList(),
                  hint: const Text("RT",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
              Form(
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: GlobalColors.stroke, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: GlobalColors.mainColor, width: 2),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 15.0),
                  ),
                  isDense: true,
                  value: selectedRW,
                  onChanged: (String? newValue) {
                    setState(() {
                      _rwController.text = newValue ?? '';
                    });
                  },
                  items: rwItems.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    );
                  }).toList(),
                  hint: const Text("RW",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                width: double.infinity,
                decoration: BoxDecoration(color: GlobalColors.bgGray),
                child: Text("Informasi Pribadi",
                    style: TextStyle(
                        color: GlobalColors.subText,
                        fontWeight: FontWeight.bold)),
              ),
              TextFormGlobal(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'ID Pelanggan tidak boleh kosong';
                  } else if (value.length != 12 ||
                      int.tryParse(value) == null) {
                    return 'ID Pelanggan harus terdiri dari 12 angka';
                  }
                  return null; // Return null for successful validation
                },
                controller: _idPelangganController,
                text: "ID Pelanggan",
                textInputType: TextInputType.number,
                obscure: false,
              ),
              TextFormGlobal(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'No KK tidak boleh kosong';
                  } else if (value.length != 16 ||
                      int.tryParse(value) == null) {
                    return 'No KK harus terdiri dari 16 angka';
                  }
                  return null; // Return null for successful validation
                },
                controller: _noKKController,
                text: "Nomor Kartu Keluarga",
                textInputType: TextInputType.number,
                obscure: false,
              ),
              TextFormGlobal(
                controller: _pekerjaanController,
                text: "Pekerjaan",
                textInputType: TextInputType.text,
                obscure: false,
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: GlobalColors.mainColor,
                    elevation: 0,
                  ),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      Masyarakat masyarakat = Masyarakat(
                        nama: _namaController.text,
                        noKK: _noKKController.text,
                        pekerjaan: _pekerjaanController.text,
                        alamat: _alamatController.text,
                        rt: _rtController.text,
                        rw: _rwController.text,
                        idPelanggan: _idPelangganController.text,
                        kelurahan: _kelurahanController.text,
                        noHP: _noHPController.text,
                      );
                      insertData(masyarakat);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                    child: Text(
                      "Simpan",
                      style: TextStyle(
                          color: GlobalColors.whiteColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void insertData(Masyarakat masyarakat) {
    if (_namaController.text.isNotEmpty &&
        _noKKController.text.isNotEmpty &&
        _pekerjaanController.text.isNotEmpty &&
        _alamatController.text.isNotEmpty &&
        _rtController.text.isNotEmpty &&
        _rwController.text.isNotEmpty &&
        _idPelangganController.text.isNotEmpty &&
        _kelurahanController.text.isNotEmpty) {
      dbRef.push().set(
            masyarakat.toJson(),
          );
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const MainView()));
    } else {
      print("Field must be not empty");
    }
  }
}
