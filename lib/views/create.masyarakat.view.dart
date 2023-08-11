import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mobayari_app_dev/model/masyarakat.dart';
import 'package:mobayari_app_dev/views/main.view.dart';
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

  late DatabaseReference dbRef;

  List<String> kecamatanItems = [
    'Mantikulore',
    'Palu Barat',
    'Palu Selatan',
    'Palu Timur',
    'Palu Utara',
    'Tatanga',
    'Tawaeli',
    'Ulujadi',
  ];
  String? selectedKecamatan;

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
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Tambah Data Masyarakat",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: GlobalColors.mainColor),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Text("Nama",
                    style: TextStyle(color: GlobalColors.textColor)),
              ),
              TextFormField(
                controller: _namaController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: GlobalColors.stroke, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: GlobalColors.mainColor, width: 2),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Text("No KK",
                    style: TextStyle(color: GlobalColors.textColor)),
              ),
              TextFormField(
                controller: _noKKController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: GlobalColors.stroke, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: GlobalColors.mainColor, width: 2),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(
                  "Pekerjaan",
                  style: TextStyle(color: GlobalColors.textColor),
                ),
              ),
              TextFormField(
                controller: _pekerjaanController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: GlobalColors.stroke, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: GlobalColors.mainColor, width: 2),
                  ),
                ),
              ),
              // const SizedBox(
              //   height: 15,
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(bottom: 5),
              //   child: Text(
              //     "Kecamatan",
              //     style: TextStyle(
              //       color: GlobalColors.textColor,
              //     ),
              //   ),
              // ),
              // Form(
              //   child: DropdownButtonFormField<String>(
              //     decoration: InputDecoration(
              //       enabledBorder: OutlineInputBorder(
              //         borderSide:
              //             BorderSide(color: GlobalColors.stroke, width: 1),
              //       ),
              //       focusedBorder: OutlineInputBorder(
              //         borderSide:
              //             BorderSide(color: GlobalColors.mainColor, width: 2),
              //       ),
              //     ),
              //     isDense: true,
              //     value: selectedKecamatan,
              //     onChanged: (String? newValue) {
              //       setState(() {
              //         _kecamatanUserController.text = newValue ?? '';
              //       });
              //     },
              //     items: kecamatanItems.map((String value) {
              //       return DropdownMenuItem<String>(
              //         value: value,
              //         child: Text(value),
              //       );
              //     }).toList(),
              //   ),
              // ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Text("Alamat",
                    style: TextStyle(color: GlobalColors.textColor)),
              ),
              TextFormField(
                controller: _alamatController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: GlobalColors.stroke, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: GlobalColors.mainColor, width: 2),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child:
                    Text("RT", style: TextStyle(color: GlobalColors.textColor)),
              ),
              TextFormField(
                controller: _rtController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: GlobalColors.stroke, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: GlobalColors.mainColor, width: 2),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child:
                    Text("RW", style: TextStyle(color: GlobalColors.textColor)),
              ),
              TextFormField(
                controller: _rwController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: GlobalColors.stroke, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: GlobalColors.mainColor, width: 2),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Text("ID Pelanggan",
                    style: TextStyle(color: GlobalColors.textColor)),
              ),
              TextFormField(
                controller: _idPelangganController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: GlobalColors.stroke, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: GlobalColors.mainColor, width: 2),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Text("Kelurahan",
                    style: TextStyle(color: GlobalColors.textColor)),
              ),
              TextFormField(
                controller: _kelurahanController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: GlobalColors.stroke, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: GlobalColors.mainColor, width: 2),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Text("No HP",
                    style: TextStyle(color: GlobalColors.textColor)),
              ),
              TextFormField(
                controller: _noHPController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: GlobalColors.stroke, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: GlobalColors.mainColor, width: 2),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: GlobalColors.mainColor,
                  elevation: 0,
                ),
                onPressed: () {
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
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 12.0),
                  child: Text(
                    "Simpan",
                    style: TextStyle(
                        color: GlobalColors.whiteColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
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
        _kelurahanController.text.isNotEmpty &&
        _noHPController.text.isNotEmpty) {
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
