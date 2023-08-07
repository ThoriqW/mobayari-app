import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mobayari_app_dev/model/masyarakat.dart';
import 'package:mobayari_app_dev/utils/global.colors.dart';
import 'package:mobayari_app_dev/views/profile.masyarakat.view.dart';
import 'package:mobayari_app_dev/views/widgets/filter.modal.global.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Masyarakat> dataUser = [];
  List<Masyarakat> userDisplay = [];
  List<String> selectedCategories = [];

  bool isLoading = false;

  final ref = FirebaseDatabase.instance.ref('Users');

  @override
  void initState() {
    super.initState();
    readData();
  }

  void readData() async {
    setState(() {
      isLoading = true;
    });
    final snapshot =
        await FirebaseDatabase.instance.ref().child("Masyarakat").get();
    if (snapshot.exists) {
      Map<dynamic, dynamic> dataMap = snapshot.value as Map<dynamic, dynamic>;
      dataMap.forEach((key, value) {
        Masyarakat data = Masyarakat(
            idUser: key,
            name: value['name'],
            alamat: value['alamat'],
            kecamatan: value['kecamatan'],
            nomorHp: value['nomorHp']);
        dataUser.add(data);
        print(key);
      });
      setState(() {
        userDisplay = dataUser;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  void updateList(String value) {
    setState(() {
      userDisplay = dataUser
          .where(
              (user) => user.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  void applyFilter() {
    if (selectedCategories.isEmpty) {
      resetFilter();
    } else {
      setState(() {
        userDisplay = dataUser
            .where((user) => selectedCategories.contains(user.kecamatan))
            .toList();
      });
    }
  }

  void resetFilter() {
    setState(() {
      selectedCategories.clear();
      userDisplay = dataUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<String> categories =
        dataUser.map((user) => user.kecamatan.toString()).toSet().toList();

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Masyarakat",
                    style: TextStyle(
                        color: GlobalColors.mainColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  FilterModalGlobal(
                    selectedCategories: selectedCategories,
                    categories: categories,
                    onApplyFilter: applyFilter,
                    onResetFilter: resetFilter,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              onChanged: (value) => updateList(value),
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none),
                  hintText: "Cari",
                  prefixIcon: const Icon(Icons.search),
                  prefixIconColor: GlobalColors.mainColor),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: isLoading
                  ? Center(
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              GlobalColors.mainColor),
                        ),
                      ),
                    )
                  : userDisplay.isEmpty
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
                          itemCount: userDisplay.length,
                          itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              // Handle the onTap event for the specific item
                              // You can perform any desired action here
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UserProfileView(
                                    data: userDisplay[index],
                                  ),
                                ),
                              );
                            },
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(8.0),
                              title: Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(
                                  userDisplay[index].name,
                                  style: TextStyle(
                                      color: GlobalColors.textColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              subtitle: Text(
                                userDisplay[index].kecamatan,
                                style: const TextStyle(fontSize: 12.0),
                              ),
                            ),
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
