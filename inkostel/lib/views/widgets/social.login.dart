import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inkostel/utils/global.color.dart';

class SocialLogin extends StatelessWidget {
  const SocialLogin ({Key? key}) : super (key: key);

  @override 
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          child: Text(
            '- Or Log In with -',
            style: TextStyle(
              color: GlobalColors.textColor,
              fontWeight: FontWeight.w600
            ),
          ),
        ),
        const SizedBox(height: 15),
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  height: 55,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: SvgPicture.asset(
                    'assets/images/google.svg', 
                    height: 20),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  height: 55,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: SvgPicture.asset(
                    'assets/images/twitter.svg', 
                    height: 20),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  height: 55,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: SvgPicture.asset(
                    'assets/images/office.svg', 
                    height: 20),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}