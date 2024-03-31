import 'package:flutter/material.dart';
import 'package:inkostel/pages/login.dart';
import 'package:inkostel/pages/carikos.dart';
import 'package:inkostel/pages/detail.dart';
import 'package:inkostel/pages/jualkos.dart';
import 'package:inkostel/pages/profile.dart';
import 'package:inkostel/pages/simpan.dart';
import 'package:inkostel/pages/tes.dart';
import 'package:inkostel/pages/validation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Poppins',
        ),
        home: const Profile());
  }
}
