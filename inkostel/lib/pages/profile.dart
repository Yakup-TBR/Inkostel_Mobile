import 'package:flutter/material.dart';
import 'package:inkostel/pages/carikos.dart';
import 'package:inkostel/pages/jualkos.dart';
import 'package:inkostel/pages/simpan.dart';
import 'package:inkostel/pages/tes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});
  final double coverHeight = 170;
  final double profileSize = 110;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              buildTop(context),
              buildBottom(),
              SizedBox(height: 100), // Membuat ruang kosong di bagian bawah untuk memberi tempat pada tombol back
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        // Bottom NavBar
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color.fromRGBO(100, 204, 197, 1),
        selectedItemColor: const Color.fromARGB(255, 232, 255, 240),
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedFontSize: 14,
        unselectedFontSize: 14,
        onTap: (int index) {
          // Handle bottom navigation bar item tap here
          switch (index) {
            case 0:
              // Navigasi ke halaman Home
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CariKos()),
              );
              break;
            case 1:
              // Navigasi ke halaman Search
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Simpan()),
              );
              break;
            case 2:
              // Navigasi ke halaman Save
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const JualKos()),
              );
              break;
            case 3:
              // Navigasi ke halaman Add
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Tes()),
              );
              break;
            default:
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'lib/icons/home.png',
              height: 30,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'lib/icons/simpan.png',
              height: 30,
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'lib/icons/plus.png',
              height: 30,
            ),
            label: 'Save',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'lib/icons/gear_active.png',
              height: 30,
            ),
            label: 'Settings',
          ),
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
          top: 40,
          child: Container(
            width: 40,
            height: 40,
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
        Positioned(
          right: 10,
          top: 40,
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Center(
                child: SvgPicture.asset(
                  "lib/icons/pen.svg",
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
          child: Image.asset(
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
          Text(
            'Supri Basuki',
            style: GoogleFonts.getFont(
              'Poppins',
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF436850),
            ),
          ),
          Text(
            '@supribasuki',
            style: GoogleFonts.getFont(
              'Poppins',
              fontSize: 18,
              color: Colors.grey,
            ),
          ),
          Text(
            '+62 - 8123 - 5643 - 8923',
            style: GoogleFonts.getFont(
              'Poppins',
              fontSize: 18,
              color: Colors.grey,
            ),
          ),
          Text(
            'supribasuki@gmail.com',
            style: GoogleFonts.getFont(
              'Poppins',
              fontSize: 18,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 30), 
          Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
            style: GoogleFonts.getFont(
              'Poppins',
              fontSize: 18,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ],
        
      ),
    );
  }

}
