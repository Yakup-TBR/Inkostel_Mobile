import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inkostel/utils/global.color.dart';
import 'package:inkostel/views/login.view.dart';

class SplashView extends StatelessWidget {
  const SplashView ({Key? key}) : super (key: key);

  @override 
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 1), () {
      Get.to(LoginView());
    });
    return Scaffold(
      backgroundColor: GlobalColors.mainColor,
      body: const Center(
        child: Text(
          'Logo',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}