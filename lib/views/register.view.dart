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
  final formKey = GlobalKey<FormState>();

  String? errorText;

  Future<User?> registerWithEmailPassword(
      {required String email, required String password}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        setState(() {
          errorText = "Kata sandi harus minimal 6 karakter";
        });
      } else if (e.code == 'email-already-in-use') {
        setState(() {
          errorText = "Email sudah digunakan oleh akun lain";
        });
      }
    }
    return user;
  }

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
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormGlobal(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email tidak boleh kosong';
                              } else if (!RegExp(
                                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                  .hasMatch(value)) {
                                return 'Masukkan alamat email yang valid';
                              }
                              return null; // Return null for successful validation
                            },
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
                          validator: (value) {
                            if (value != _passwordController.text) {
                              return 'Konfirmasi password tidak cocok';
                            }
                            return null;
                          },
                          controller: _confirmationPassword,
                          text: "Konfirmasi Password",
                          textInputType: TextInputType.text,
                          obscure: true,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (errorText != null)
                    Text(
                      errorText!,
                      style: const TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  ButtonGlobal(
                    text: "Daftar",
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        User? user = await registerWithEmailPassword(
                            email: _emailController.text,
                            password: _passwordController.text);
                        if (!mounted) return;
                        if (user != null) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MainView()));
                        }
                      }
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
