import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inkostel/pages/home.dart';
import 'package:inkostel/pages/signup.dart';
import 'package:inkostel/utils/color.dart';
import 'package:inkostel/utils/reusable.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              hexStringToColor("8DE9D5"),
              hexStringToColor("32C4C0")
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              20,
              MediaQuery.of(context).size.height * 0.2,
              20,
              0,
            ),
            child: Column(
              children: <Widget>[
                logoWidget("assets/images/2.png"),
                const SizedBox(height: 30),
                reusableTextField(
                  "Enter Email",
                  Icons.person_outline,
                  false,
                  _emailTextController,
                ),
                const SizedBox(height: 20),
                reusableTextField(
                  "Enter Password",
                  Icons.lock_outline,
                  true,
                  _passwordTextController,
                ),
                const SizedBox(height: 20),
                signInSignUpButton(context, true, () async {
                  try {
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: _emailTextController.text,
                      password: _passwordTextController.text,
                    );
                    Navigator.pushReplacement(
                      // ignore: use_build_context_synchronously
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  Home(),
                      ),
                    );
                  } on FirebaseAuthException catch (e) {
                    String errorMessage;
                    if (e.code == 'user-not-found' ||
                        e.code == 'wrong-password' ||
                        e.code == 'invalid-email' ||
                        e.code == 'user-disabled' ||
                        e.code == 'too-many-requests' ||
                        e.code == 'invalid-credential') {
                      errorMessage = "Email atau password salah.";
                    } else {
                      errorMessage = "Terjadi kesalahan. Silakan coba lagi.";
                    }
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(errorMessage),
                      ),
                    );
                  } catch (e) {
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Terjadi kesalahan. Silakan coba lagi."),
                      ),
                    );
                  }
                }),
                signUpOption(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have account?",
          style: TextStyle(color: Colors.white70),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SignUpScreen()),
            );
          },
          child: const Text(
            "Sign Up",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
