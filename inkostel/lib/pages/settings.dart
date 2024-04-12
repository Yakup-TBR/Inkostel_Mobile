import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inkostel/pages/home.dart';
import 'package:inkostel/pages/profile.dart';
import 'package:inkostel/pages/simpan.dart';
import 'package:inkostel/pages/jualkos.dart';
import 'package:inkostel/pages/settings.dart';


class Pengaturan extends StatefulWidget {
  const Pengaturan({super.key});

  @override
  State<Pengaturan> createState() => _PengaturanState();
}

class _PengaturanState extends State<Pengaturan> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: const Color.fromRGBO(253, 252, 248, 1),
          body: Stack(
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Padding(
                  padding: const EdgeInsets.only(top: 35, left: 30),
                  child: Text(
                    'Pengaturan',
                    style: GoogleFonts.getFont(
                      'Poppins',
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      shadows: <Shadow>[
                        Shadow(
                          color:
                              const Color.fromARGB(0, 0, 0, 0).withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 10,
                    right: 10,
                  ),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(100, 204, 197, 1),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 0, 0, 0)
                              .withOpacity(0.5),
                          spreadRadius: 0,
                          blurRadius: 4,
                          offset: const Offset(0, 1), // Atur posisi shadow
                        )
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 40, left: 40, right: 24, bottom: 40),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(254, 251, 246, 1),
                                borderRadius: BorderRadius.circular(18),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color.fromARGB(255, 0, 0, 0)
                                        .withOpacity(0.5),
                                    spreadRadius: 0,
                                    blurRadius: 4,
                                    offset: const Offset(
                                        0, 1), // Atur posisi shadow
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.all(10),
                              child: GestureDetector(
                                onTap: () {
                                  // Tambahkan kode navigasi ke halaman profil di sini
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const Profile()),
                                  );
                                },
                                child: Image.asset(
                                  'lib/icons/orang.png',
                                  color: const Color.fromRGBO(100, 204, 197, 1),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            'Supri Basuki',
                            style: GoogleFonts.getFont('Poppins',
                                fontSize: 23, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 25, left: 10, right: 10, bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Text(
                              'Umum',
                              style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                                shadows: <Shadow>[
                                  Shadow(
                                    color: const Color.fromARGB(0, 0, 0, 0)
                                        .withOpacity(0.3),
                                    blurRadius: 10,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Aksi yang akan dijalankan ketika widget ditekan
                            },
                            child: Container(
                              // ---- Dark Mode
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                color: Color.fromRGBO(235, 233, 233, 1),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(15),
                                  topLeft: Radius.circular(15),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, left: 30, right: 24, bottom: 10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 20),
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: const Color.fromRGBO(
                                              100, 204, 197, 1),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        padding: const EdgeInsets.all(3),
                                        child: Image.asset(
                                          'lib/icons/bulan.png',
                                          color: const Color.fromRGBO(0, 0, 0, 1),
                                        ),
                                      ),
                                    ),
                                    const Text(
                                      'Dark Mode',
                                      style: TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Aksi yang akan dijalankan ketika widget ditekan
                            },
                            child: Container(
                              // ---- Tentang Inkostel
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                color: Color.fromRGBO(235, 233, 233, 1),
                                border: Border.symmetric(
                                  horizontal: BorderSide(
                                    color: Colors.grey,
                                    width: 1,
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, left: 30, right: 24, bottom: 10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 20),
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: const Color.fromRGBO(
                                              100, 204, 197, 1),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        padding: const EdgeInsets.all(3),
                                        child: Image.asset(
                                          'lib/icons/about.png',
                                          color: const Color.fromRGBO(0, 0, 0, 1),
                                        ),
                                      ),
                                    ),
                                    const Text(
                                      'Tentang Inkostel',
                                      style: TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Aksi yang akan dijalankan ketika widget ditekan
                            },
                            child: Container(
                              // ---- Kirim Tanggapan
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                color: Color.fromRGBO(235, 233, 233, 1),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, left: 30, right: 24, bottom: 10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 20),
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: const Color.fromRGBO(
                                              100, 204, 197, 1),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        padding: const EdgeInsets.all(4),
                                        child: Image.asset(
                                          'lib/icons/tanggapan.png',
                                          color: const Color.fromRGBO(0, 0, 0, 1),
                                        ),
                                      ),
                                    ),
                                    const Text(
                                      'Kirim Tanggapan',
                                      style: TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20, left: 30),
                            child: Text(
                              'Akun',
                              style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                                shadows: <Shadow>[
                                  Shadow(
                                    color: const Color.fromARGB(0, 0, 0, 0)
                                        .withOpacity(0.3),
                                    blurRadius: 10,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Lakukan Sign Out
                            },
                            child: Container(
                              // ---- Sign Out
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                color: Color.fromRGBO(235, 233, 233, 1),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(15),
                                  topLeft: Radius.circular(15),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, left: 30, right: 24, bottom: 10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 20),
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: const Color.fromRGBO(
                                              100, 204, 197, 1),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        padding: const EdgeInsets.all(3),
                                        child: Image.asset(
                                          'lib/icons/signout.png',
                                          color: const Color.fromRGBO(0, 0, 0, 1),
                                        ),
                                      ),
                                    ),
                                    const Text(
                                      'Sign Out',
                                      style: TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Lakukan Ganti Email
                            },
                            child: Container(
                              // ---- Ganti Email
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                color: Color.fromRGBO(235, 233, 233, 1),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, left: 30, right: 24, bottom: 10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 20),
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: const Color.fromRGBO(
                                              100, 204, 197, 1),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        padding: const EdgeInsets.all(4),
                                        child: Image.asset(
                                          'lib/icons/emailChange.png',
                                          color: const Color.fromRGBO(0, 0, 0, 1),
                                        ),
                                      ),
                                    ),
                                    const Text(
                                      'Ganti Email',
                                      style: TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ])
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
                    MaterialPageRoute(builder: (context) => const Home()),
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
                  // Navigasi ke halaman Settings
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
          )),
    );
  }
}
