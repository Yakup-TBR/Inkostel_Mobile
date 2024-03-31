import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});
  final double coverHeight = 170;
  final double profileSize = 110;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          buildTop(context),
          buildBottom(),
        ],
      ),
    );
  }

  Widget buildTop(BuildContext context) {
    final bottom = profileSize / 2;
    final top = coverHeight - profileSize / 2 - 30;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: bottom),
          child: buildCoverImage(),
        ),
        
        Positioned(
          bottom: 0, 
          left: 0,
          right: 0,
          child: Container(
            height: coverHeight / 2 , 
            decoration: const BoxDecoration(
              color: Colors.white, 
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18.0), 
                topRight: Radius.circular(18.0), 
              ),
            ),
          ),
        ),
        Positioned(
          top: top, 
          child: buildProfileImageWithShadow(),
        ),
        Positioned(
          left: 10,
          top: 10,
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Center(
                child: Image.asset(
                  'lib/icons/back.png',
                  color: const Color.fromRGBO(100, 204, 197, 1),
                  width: 20,
                  height: 20,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildCoverImage() => Container(
        color: Colors.grey,
        child: Image.asset(
          'images/gambar.png',
          fit: BoxFit.cover,
          width: double.infinity,
          height: coverHeight,
        ),
      );

  Widget buildProfileImageWithShadow() => Container(
        width: profileSize,
        height: profileSize,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.network(
            'images/profile.png',
            width: profileSize,
            height: profileSize,
            fit: BoxFit.cover,
          ),
        ),
      );

  Widget buildBottom() {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Supri Basuki',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Color(0xFF436850),
            ),
          ),
          const Text(
            '@supribasuki',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey,
            ),
          ),
          const Text(
            '+62 - 8123 - 5643 - 8923',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey,
            ),
          ),
          const Text(
            'supribasuki@gmail.com',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 30), 
          const Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 150), 
          ElevatedButton(
            onPressed: () {
              // Aksi ketika tombol ditekan
              // Misalnya, menuju halaman edit profil
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF436850)), // Warna latar belakang
              fixedSize: MaterialStateProperty.all<Size>(
                const Size.fromWidth(500), 
              ),
            ),
            child: const SizedBox(
              width: double.infinity, 
              height: 50, 
              child: Center(
                child: Text(
                  'Edit Profil',
                  style: TextStyle(
                    color: Colors.white, 
                    fontWeight: FontWeight.bold, 
                    fontSize: 25, 
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

}
