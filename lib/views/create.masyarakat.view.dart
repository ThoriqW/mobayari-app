import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mobayari_app_dev/views/main.view.dart';

import '../model/createMasyarakat.dart';
import '../utils/global.colors.dart';

class CreateUserView extends StatefulWidget {
  const CreateUserView({super.key});

  @override
  State<CreateUserView> createState() => _CreateUserViewState();
}

class _CreateUserViewState extends State<CreateUserView> {
  final TextEditingController _nameUserController = TextEditingController();
  final TextEditingController _alamatUserController = TextEditingController();
  final TextEditingController _nomorHpUserController = TextEditingController();
  final TextEditingController _kecamatanUserController =
      TextEditingController();

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
                controller: _nameUserController,
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
                  "Alamat",
                  style: TextStyle(color: GlobalColors.textColor),
                ),
              ),
              TextFormField(
                controller: _alamatUserController,
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
                  "Kecamatan",
                  style: TextStyle(
                    color: GlobalColors.textColor,
                  ),
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
                  ),
                  isDense: true,
                  value: selectedKecamatan,
                  onChanged: (String? newValue) {
                    setState(() {
                      _kecamatanUserController.text = newValue ?? '';
                    });
                  },
                  items: kecamatanItems.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Text("Nomor HP",
                    style: TextStyle(color: GlobalColors.textColor)),
              ),
              TextFormField(
                controller: _nomorHpUserController,
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
                  User user = User(
                    name: _nameUserController.text,
                    alamat: _alamatUserController.text,
                    kecamatan: _kecamatanUserController.text,
                    nomorHp: _nomorHpUserController.text,
                  );
                  insertData(user);
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

  void insertData(User user) {
    if (_nameUserController.text.isNotEmpty &&
        _alamatUserController.text.isNotEmpty &&
        _kecamatanUserController.text.isNotEmpty &&
        _nomorHpUserController.text.isNotEmpty) {
      dbRef.push().set(
            user.toJson(),
          );
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const MainView()));
    } else {
      print("Field must be not empty");
    }
  }
}
