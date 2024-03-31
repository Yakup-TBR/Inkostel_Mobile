import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inkostel/pages/carikos.dart';
import 'package:inkostel/pages/simpan.dart';
import 'package:inkostel/pages/jualkos.dart';
import 'package:inkostel/pages/tes.dart';

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
                  child: Image.asset(
                    'lib/icons/orang.png',
                    color: const Color.fromRGBO(100, 204, 197, 1),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text('Hai, Supri Makmur',
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
              // ----- End Filter
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Rekomendasi',
                      textAlign: TextAlign.start,
                      style: GoogleFonts.getFont(
                        'Poppins',
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      )),
                  
                ],
              )
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
}
