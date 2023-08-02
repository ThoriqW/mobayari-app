import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobayari_app_dev/views/widgets/button.global.dart';
import 'package:mobayari_app_dev/views/widgets/text.form.global.dart';

import '../utils/global.colors.dart';
import 'login.view.dart';
import 'main.view.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmationPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(35.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      "assets/images/logo-mobayari-1.svg",
                      height: 50,
                      colorFilter: ColorFilter.mode(
                          GlobalColors.mainColor, BlendMode.srcIn),
                      // colorFilter: ColorFilter.mode(GlobalColors.mainColor, BlendMode.srcIn)),
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  TextFormGlobal(
                      controller: _emailController,
                      text: "Email",
                      textInputType: TextInputType.emailAddress,
                      obscure: false),
                  const SizedBox(height: 15),
                  TextFormGlobal(
                      controller: _passwordController,
                      text: "Password",
                      textInputType: TextInputType.text,
                      obscure: true),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormGlobal(
                      controller: _confirmationPassword,
                      text: "Confirmation Password",
                      textInputType: TextInputType.text,
                      obscure: true),
                  const SizedBox(
                    height: 20,
                  ),
                  ButtonGlobal(
                    text: "Daftar",
                    onTap: () {
                      FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: _emailController.text,
                              password: _passwordController.text)
                          .then(
                        (value) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MainView()),
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Sudah punya akun?",
                        style: TextStyle(
                          color: GlobalColors.textColor,
                        ),
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      InkWell(
                        child: Text(
                          "Masuk",
                          style: TextStyle(color: GlobalColors.mainColor),
                        ),
                        onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginView()),
                          )
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
