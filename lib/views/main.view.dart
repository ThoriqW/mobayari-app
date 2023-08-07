import 'package:flutter/material.dart';
import 'package:mobayari_app_dev/utils/global.colors.dart';
import 'package:mobayari_app_dev/views/create.masyarakat.view.dart';
import 'package:mobayari_app_dev/views/home.view.dart';
import 'package:mobayari_app_dev/views/profile.petugas.view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List pages = [const HomeView(), const MyProfileView()];

  int currentIndex = 0;

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CreateUserView(),
              ),
            );
          },
          backgroundColor: GlobalColors.mainColor,
          elevation: 0,
          child: const Icon(Icons.add)),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTap,
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile')
        ],
        selectedItemColor: GlobalColors.mainColor,
        elevation: 0,
      ),
    );
  }
}
