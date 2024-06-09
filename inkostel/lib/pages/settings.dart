import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inkostel/pages/home.dart';
import 'package:inkostel/pages/profile.dart';
import 'package:inkostel/pages/signin.dart';
import 'package:inkostel/pages/simpan.dart';
import 'package:inkostel/pages/jualkos.dart';
import 'package:flutter/services.dart';
import 'package:inkostel/service/user_model.dart';

class Pengaturan extends StatefulWidget {
  const Pengaturan({super.key});

  @override
  State<Pengaturan> createState() => _PengaturanState();
}

class _PengaturanState extends State<Pengaturan> {
  bool isDarkMode = false;
  UserProfile? userProfile;

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    try {
      UserProfile? profile = await getUserProfile();
      if (profile != null) {
        setState(() {
          userProfile = profile;
        });
      }
    } catch (e) {
      print("Error fetching user profile: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    // Ubah warna status bar berdasarkan isDarkMode
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: isDarkMode ? Colors.black : Colors.white,
      statusBarIconBrightness: isDarkMode ? Brightness.light : Brightness.dark,
    ));

    return MaterialApp(
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: isDarkMode ? Colors.black : const Color.fromRGBO(253, 252, 248, 1),
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
                    color: isDarkMode ? Colors.white : Colors.black,
                    shadows: <Shadow>[
                      Shadow(
                        color: isDarkMode
                            ? Colors.black.withOpacity(0.3)
                            : const Color.fromARGB(0, 0, 0, 0).withOpacity(0.3),
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
                        color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
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
                                  offset: const Offset(0, 1), // Atur posisi shadow
                                ),
                              ],
                              image: userProfile != null && userProfile!.photoURL.isNotEmpty
                                  ? DecorationImage(
                                      image: NetworkImage(userProfile!.photoURL),
                                      fit: BoxFit.cover,
                                      onError: (exception, stackTrace) {
                                        // Handle the error, for example by showing a default image
                                        const DecorationImage(
                                          image: AssetImage('lib/icons/orang.png'),
                                          fit: BoxFit.cover,
                                          colorFilter: ColorFilter.mode(
                                              Color.fromRGBO(100, 204, 197, 1),
                                              BlendMode.srcATop),
                                        );
                                      },
                                    )
                                  : const DecorationImage(
                                      image: AssetImage('lib/icons/orang.png'),
                                      fit: BoxFit.cover,
                                      colorFilter: ColorFilter.mode(
                                          Color.fromRGBO(100, 204, 197, 1),
                                          BlendMode.srcATop),
                                    ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: FutureBuilder<UserProfile?>(
                            future: getUserProfile(), // Panggil metode getUserProfile()
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Text(
                                  'Hai, ${snapshot.data!.username}',
                                  style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                                );
                              } else {
                                return Text(
                                  '',
                                  style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                                );
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 25, left: 10, right: 10, bottom: 10),
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
                              color: isDarkMode ? Colors.white : Colors.black,
                              shadows: <Shadow>[
                                Shadow(
                                  color: isDarkMode
                                      ? Colors.black.withOpacity(0.3)
                                      : const Color.fromARGB(0, 0, 0, 0).withOpacity(0.3),
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
                            // ---- Tentang Inkostel
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: isDarkMode
                                  ? Colors.grey[800]
                                  : const Color.fromRGBO(235, 233, 233, 1),
                              borderRadius: const BorderRadius.only(
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
                                        'lib/icons/about.png',
                                        color: isDarkMode
                                          ? Colors.white
                                          : const Color.fromRGBO(0, 0, 0, 1),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Tentang Inkostel',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Poppins',
                                      color: isDarkMode ? Colors.white : Colors.black,
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
                            decoration: BoxDecoration(
                              color: isDarkMode
                                  ? Colors.grey[800]
                                  : const Color.fromRGBO(235, 233, 233, 1),
                              borderRadius: const BorderRadius.only(
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
                                        color: isDarkMode
                                          ? Colors.white
                                          : const Color.fromRGBO(0, 0, 0, 1),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Kirim Tanggapan',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Poppins',
                                      color: isDarkMode ? Colors.white : Colors.black,
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
                              color: isDarkMode ? Colors.white : Colors.black,
                              shadows: <Shadow>[
                                Shadow(
                                  color: isDarkMode
                                      ? Colors.black.withOpacity(0.3)
                                      : const Color.fromARGB(0, 0, 0, 0).withOpacity(0.3),
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
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Konfirmasi Sign Out'),
                                  content: const Text('Apakah Anda yakin ingin keluar?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(); // Tutup dialog
                                      },
                                      child: const Text(
                                        'Tidak',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        await FirebaseAuth.instance.signOut();
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => SignInScreen()),
                                        );
                                      },
                                      child: const Text(
                                        'Ya',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Container(
                            // ---- Sign Out
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: isDarkMode
                                  ? Colors.grey[800]
                                  : const Color.fromRGBO(235, 233, 233, 1),
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(15),
                                topLeft: Radius.circular(15),
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
                                      padding: const EdgeInsets.all(3),
                                      child: Image.asset(
                                        'lib/icons/signout.png',
                                        color: isDarkMode
                                          ? Colors.white
                                          : const Color.fromRGBO(0, 0, 0, 1),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Sign Out',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Poppins',
                                      color: isDarkMode ? Colors.white : Colors.black,
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
        ),
      ),
    );
  }
}
