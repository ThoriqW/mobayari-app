import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../model/petugas.dart';

import '../utils/global.colors.dart';
import 'main.view.dart';

class MyProfileView extends StatefulWidget {
  const MyProfileView({super.key});

  @override
  State<MyProfileView> createState() => _MyProfileViewState();
}

class _MyProfileViewState extends State<MyProfileView> {
  final TextEditingController _namaPetugasController = TextEditingController();
  final TextEditingController _alamatPetugasController =
      TextEditingController();
  final TextEditingController _kelurahanPetugasController =
      TextEditingController();
  final TextEditingController _emailPetugasController = TextEditingController();
  final TextEditingController _noHPPetugasController = TextEditingController();

  late DatabaseReference dbRef;

  bool isLoading = false;

  String? email;
  String? name;
  String? uid;

  String imageUrl = "";

  late Map<dynamic, dynamic>? dataPetugas = {};

  User? getCurrentUser() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      email = user.email;
      uid = user.uid;
      _emailPetugasController.text = email ?? '';
      return user;
    } else {
      return null;
    }
  }

  void readData() async {
    final snapshot =
        await FirebaseDatabase.instance.ref().child("Petugas/$uid").get();
    if (snapshot.exists) {
      dataPetugas = snapshot.value as Map<dynamic, dynamic>?;
      if (dataPetugas != null) {
        _namaPetugasController.text = dataPetugas?['nama'];
        _alamatPetugasController.text = dataPetugas?['alamat'];
        _kelurahanPetugasController.text = dataPetugas?['kelurahan'];
        _noHPPetugasController.text = dataPetugas?['noHP'];
        setState(() {
          name = dataPetugas?['nama'];
          imageUrl = dataPetugas?['image'];
        });
      }
    }
  }

  Future selectFile() async {
    ImagePicker imagePicker = ImagePicker();
    final file = await imagePicker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      File? croppedFile = await cropImage(File(file.path));

      if (croppedFile != null) {
        setState(() {
          isLoading = true; // Show loading indicator while uploading
        });
        // Store image to Firebase Storage
        String uniqueFileName =
            DateTime.now().millisecondsSinceEpoch.toString();

        Reference referenceRoot = FirebaseStorage.instance.ref();
        Reference referenceDirImages = referenceRoot.child("profile_pictures");
        Reference referenceImageToUpload =
            referenceDirImages.child(uniqueFileName);

        try {
          await referenceImageToUpload.putFile(croppedFile);
          String imageUrl = await referenceImageToUpload.getDownloadURL();
          setState(() {
            this.imageUrl = imageUrl;
            isLoading = false;
          });
        } catch (error) {
          print("Error uploading image: $error");
        }
      }
    }
  }

  Future<File?> cropImage(File imageFile) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
    );
    if (croppedFile == null) return null;
    return File(croppedFile.path);
  }

  void openProfileImage(String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Image.network(imageUrl),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child("Petugas");
    getCurrentUser();
    readData(); // Set the initial value
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Text(
                      "Profile Petugas",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: GlobalColors.mainColor),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: GlobalColors.subText, // Border color
                            width: 2.0, // Border width
                          ),
                        ),
                        child: Stack(
                          children: [
                            imageUrl.isNotEmpty
                                ? GestureDetector(
                                    onTap: () {
                                      openProfileImage(imageUrl);
                                    },
                                    child: CircleAvatar(
                                      radius: 42,
                                      backgroundColor: Colors.transparent,
                                      backgroundImage: NetworkImage(imageUrl),
                                      // provide any child widget you want to display as the avatar
                                    ),
                                  )
                                : CircleAvatar(
                                    radius: 42,
                                    backgroundColor: Colors.transparent,
                                    child: Icon(Icons.person,
                                        size: 42, color: GlobalColors.subText),
                                    // provide any child widget you want to display as the avatar
                                  ),
                            Positioned(
                              bottom: -10,
                              left: 50,
                              child: IconButton(
                                onPressed: () {
                                  selectFile();
                                },
                                icon: const Icon(Icons.add_a_photo),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (name != null)
                              Text(
                                '$name',
                                style: TextStyle(
                                  color: GlobalColors.textColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              '$email',
                              style: TextStyle(
                                color: GlobalColors.subText,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Text("Nama",
                        style: TextStyle(
                          color: GlobalColors.textColor,
                        )),
                  ),
                  TextFormField(
                    controller: _namaPetugasController,
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
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0, left: 2.0),
                    child: Text("Alamat",
                        style: TextStyle(
                          color: GlobalColors.textColor,
                        )),
                  ),
                  TextFormField(
                    controller: _alamatPetugasController,
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
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0, left: 2.0),
                    child: Text("Kelurahan",
                        style: TextStyle(
                          color: GlobalColors.textColor,
                        )),
                  ),
                  TextFormField(
                    controller: _kelurahanPetugasController,
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
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0, left: 2.0),
                    child: Text("Email",
                        style: TextStyle(
                          color: GlobalColors.textColor,
                        )),
                  ),
                  TextFormField(
                    controller: _emailPetugasController,
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
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0, left: 2.0),
                    child: Text("No HP",
                        style: TextStyle(
                          color: GlobalColors.textColor,
                        )),
                  ),
                  TextFormField(
                    controller: _noHPPetugasController,
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
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: GlobalColors.mainColor,
                      elevation: 0,
                    ),
                    onPressed: () {
                      Petugas profile = Petugas(
                          nama: _namaPetugasController.text,
                          alamat: _alamatPetugasController.text,
                          kelurahan: _kelurahanPetugasController.text,
                          email: _emailPetugasController.text,
                          noHP: _noHPPetugasController.text,
                          image: imageUrl);
                      if (dataPetugas != null) {
                        updateData(profile, "$uid");
                      } else {
                        insertData(profile, "$uid");
                      }
                    },
                    child: Padding(
                      padding:
                          const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 12.0),
                      child: Text(
                        "Simpan",
                        style: TextStyle(
                            color: GlobalColors.whiteColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          if (isLoading)
            Container(
              color: Colors.black26,
              child: Center(
                child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(GlobalColors.mainColor),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void insertData(Petugas petugas, String uid) {
    dbRef.child(uid).set(
          petugas.toJson(),
        );
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const MainView()));
  }

  void updateData(Petugas petugas, String uid) {
    dbRef.child(uid).update(
          petugas.toJson(),
        );
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const MainView()));
  }

  // void updateEmail(String newEmail) async {
  //   try {
  //     // Get the current user
  //     User? user = FirebaseAuth.instance.currentUser;

  //     if (user != null) {
  //       // Update the email
  //       await user.updateEmail(newEmail);

  //       print('Email updated successfully: ${user.email}');
  //     }
  //   } catch (e) {
  //     print('Error updating email: $e');
  //   }
  // }
}
