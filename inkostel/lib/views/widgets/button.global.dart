import 'package:flutter/material.dart';
import 'package:inkostel/pages/home.dart';
import 'package:inkostel/utils/global.color.dart';

class ButtonGlobal extends StatelessWidget {
  const ButtonGlobal ({Key? key}) : super(key: key);

  @override 
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Home()), // Gunakan kelas Home di sini
        );
      },
      child: Container(
        alignment: Alignment.center,
        height: 55,
        decoration: BoxDecoration(
          color: GlobalColors.mainColor,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
      
            )
          ]
        ),
        child: const Text(
          'Log In',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}