import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inkostel/pages/carikos.dart';
import 'package:inkostel/pages/detail.dart';
import 'package:inkostel/pages/profile.dart';
import 'package:inkostel/pages/simpan.dart';
import 'package:inkostel/pages/jualkos.dart';
import 'package:inkostel/pages/settings.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color.fromRGBO(253, 252, 248, 1),
        appBar: AppBar(
          // ----------Appbar
          backgroundColor: const Color.fromRGBO(253, 252, 248, 1),
          toolbarHeight: 100,
          title: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(254, 251, 246, 1),
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color:
                            const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
                        spreadRadius: 0,
                        blurRadius: 4,
                        offset: const Offset(0, 1), // Atur posisi shadow
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(11),
                  child: GestureDetector(
                    onTap: () {
                      // Tambahkan kode navigasi ke halaman profil di sini
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Profile()),
                      );
                    },
                    child: Image.asset(
                      'lib/icons/orang.png',
                      color: const Color.fromRGBO(100, 204, 197, 1),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text('Hai, Supri Basuki',
                      style: GoogleFonts.getFont('Poppins',
                          fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ),
        body: Stack(
          children: [
            Column(children: [
              // ----------SearchBar dan Tombol
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(254, 251, 246, 1),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintStyle: GoogleFonts.getFont(
                              'Poppins',
                              fontSize: 16,
                            ),
                            hintText: 'Cari Kos Disini..',
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Image.asset(
                                'lib/icons/search.png',
                                color: const Color.fromRGBO(100, 204, 197, 1),
                                width: 20,
                                height: 20,
                                fit: BoxFit.fill,
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              borderSide: BorderSide(
                                width: 0.8,
                                color: Color.fromRGBO(100, 204, 197, 1),
                              ),
                            ),
                            disabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              borderSide: BorderSide(
                                width: 0.5,
                                color: Color.fromRGBO(100, 204, 197, 1),
                              ),
                            ), // Tidak ada perubahan ? Opsional dihapus nanti
                            enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              borderSide: BorderSide(
                                width: 0.8,
                                color: Color.fromRGBO(100, 204, 197, 1),
                              ),
                            ),
                            contentPadding:
                                const EdgeInsets.only(left: 20, top: 8),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: const Color.fromRGBO(100, 204, 197, 1),
                          width: 0.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(31, 106, 106, 106)
                                .withOpacity(0.6),
                            spreadRadius: 0,
                            blurRadius: 2,
                            offset: const Offset(0, 2), // Atur posisi shadow
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(7),
                      child: Image.asset(
                        'lib/icons/filter.png',
                        color: const Color.fromRGBO(100, 204, 197, 1),
                      ),
                    ),
                  ),
                ],
              ),
              // ---------- End SearchBar dan Tombol,
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Action when nearest button is pressed
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith((states) {
                        if (states.contains(MaterialState.pressed)) {
                          return const Color.fromRGBO(100, 204, 197,
                              1); // Ubah warna latar belakang menjadi biru ketika ditekan
                        }
                        return Colors
                            .white; // Kembali ke warna latar belakang putih saat tidak ditekan
                      }),
                      foregroundColor: MaterialStateColor.resolveWith((states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors
                              .white; // Ubah warna teks menjadi putih ketika ditekan
                        }
                        return const Color.fromRGBO(100, 204, 197,
                            1); // Kembali ke warna teks aslinya saat tidak ditekan
                      }),
                      side: MaterialStateProperty.all(const BorderSide(
                        color: Color.fromRGBO(100, 204, 197,
                            1), // Ubah warna border sesuai keinginan Anda
                        width: 1.0, // Atur lebar border
                      )),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(3.0),
                      child: Text(
                        'Putra',
                        style: TextStyle(
                          fontSize: 20, // Sesuaikan ukuran font di sini
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Action when cheapest button is pressed
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith((states) {
                        if (states.contains(MaterialState.pressed)) {
                          return const Color.fromRGBO(100, 204, 197,
                              1); // Ubah warna latar belakang menjadi biru ketika ditekan
                        }
                        return Colors
                            .white; // Kembali ke warna latar belakang putih saat tidak ditekan
                      }),
                      foregroundColor: MaterialStateColor.resolveWith((states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors
                              .white; // Ubah warna teks menjadi putih ketika ditekan
                        }
                        return const Color.fromRGBO(100, 204, 197,
                            1); // Kembali ke warna teks aslinya saat tidak ditekan
                      }),
                      side: MaterialStateProperty.all(const BorderSide(
                        color: Color.fromRGBO(100, 204, 197,
                            1), // Ubah warna border sesuai keinginan Anda
                        width: 1.0, // Atur lebar border
                      )),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(3.0),
                      child: Text(
                        'Putri',
                        style: TextStyle(
                          fontSize: 20, // Sesuaikan ukuran font di sini
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Action when recommended button is pressed
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith((states) {
                        if (states.contains(MaterialState.pressed)) {
                          return const Color.fromRGBO(100, 204, 197,
                              1); // Ubah warna latar belakang menjadi biru ketika ditekan
                        }
                        return Colors
                            .white; // Kembali ke warna latar belakang putih saat tidak ditekan
                      }),
                      foregroundColor: MaterialStateColor.resolveWith((states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors
                              .white; // Ubah warna teks menjadi putih ketika ditekan
                        }
                        return const Color.fromRGBO(100, 204, 197,
                            1); // Kembali ke warna teks aslinya saat tidak ditekan
                      }),
                      side: MaterialStateProperty.all(const BorderSide(
                        color: Color.fromRGBO(100, 204, 197,
                            1), // Ubah warna border sesuai keinginan Anda
                        width: 1.0, // Atur lebar border
                      )),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(3.0),
                      child: Text(
                        'Campur',
                        style: TextStyle(
                          fontSize: 20, // Sesuaikan ukuran font di sini
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // ---------- End Filter, Start Isi
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 25, right: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Rekomendasi',
                                style: GoogleFonts.getFont(
                                  'Poppins',
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                )),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const CariKos()),
                                );
                              },
                              child: Text(
                                'See All',
                                style: GoogleFonts.getFont(
                                  'Poppins',
                                  color: const Color.fromRGBO(100, 204, 197, 1),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, top: 8),
                        child: Container(
                            height: 260,
                            color: const Color.fromRGBO(254, 251, 246, 1),
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                buildCard(),
                                buildCard(),
                                buildCard(),
                                buildCard(),
                              ],
                            )),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 10, left: 25, right: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Terdekat',
                                style: GoogleFonts.getFont(
                                  'Poppins',
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                )),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const CariKos()),
                                );
                              },
                              child: Text(
                                'See All',
                                style: GoogleFonts.getFont(
                                  'Poppins',
                                  color: const Color.fromRGBO(100, 204, 197, 1),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, top: 8),
                        child: Container(
                            height: 260,
                            color: const Color.fromRGBO(254, 251, 246, 1),
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                buildCard(),
                                buildCard(),
                                buildCard(),
                                buildCard(),
                              ],
                            )),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 10, left: 25, right: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Termurah',
                                style: GoogleFonts.getFont(
                                  'Poppins',
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                )),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const CariKos()),
                                );
                              },
                              child: Text(
                                'See All',
                                style: GoogleFonts.getFont(
                                  'Poppins',
                                  color: const Color.fromRGBO(100, 204, 197, 1),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, top: 8),
                        child: Container(
                            height: 260,
                            color: const Color.fromRGBO(254, 251, 246, 1),
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                buildCard(),
                                buildCard(),
                                buildCard(),
                                buildCard(),
                              ],
                            )),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          bottom: 10,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ]),
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
                  MaterialPageRoute(builder: (context) => const Pengaturan()),
                );
                break;
              default:
            }
          },
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                'lib/icons/home_active.png',
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
                'lib/icons/gear.png',
                height: 30,
              ),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCard() => Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: GestureDetector(
        onTap: () {
           Navigator.push(context, MaterialPageRoute(builder: (context) => detail()));
        },
        child: Container(
          // Widget Card Kos
          width: 230,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: const Color.fromARGB(109, 134, 146, 134),
            ),
            borderRadius: BorderRadius.circular(20.0),
            image: DecorationImage(
              image: const AssetImage('images/kamar.png'),
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.2), BlendMode.darken),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.black.withOpacity(0.5),
                        width: 0,
                      ),
                    ),
                    child: RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: '1 Juta /',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: ' Bln',
                            style: TextStyle(
                              color: Colors
                                  .grey, // Atur warna yang diinginkan untuk bagian "Juta / Bln"
                              fontSize: 15,
                              fontWeight: FontWeight
                                  .normal, // Jika diperlukan, ubah berat font sesuai kebutuhan
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, bottom: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Kos Mak Cik",
                        style: GoogleFonts.getFont(
                          'Poppins',
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "Sukapura, DeyeuhKolot",
                        style: GoogleFonts.getFont(
                          'Poppins',
                          fontSize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ));
}
