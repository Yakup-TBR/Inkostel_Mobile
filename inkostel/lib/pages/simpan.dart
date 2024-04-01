import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inkostel/pages/home.dart';
import 'package:inkostel/pages/jualkos.dart';
import 'package:inkostel/pages/tes.dart';

void main() {
  runApp(const Simpan());
}

class Simpan extends StatefulWidget {
  const Simpan({super.key});

  @override
  _SimpanState createState() => _SimpanState();
}

class _SimpanState extends State<Simpan> {
  bool isFavorite1 = true;
  bool isFavorite2 = true;
  bool isFavorite3 = true;
  bool isFavorite4 = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromRGBO(253, 252, 248, 1),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(253, 252, 248, 1),
          toolbarHeight: 65,
          title: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Row(
              children: [
                _buildBackbutton(),
                Padding(
                  padding: const EdgeInsets.only(left: 70),
                  child: Text(
                    'Kos Tersimpan',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 0),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildListItem(
                          imagePath: 'images/kamar.png',
                          price: 8500000,
                          name: 'Kost Putri Pondok Firdaus',
                          distance: 900,
                          isFavorite: isFavorite1,
                          onTap: () {
                            setState(() {
                              isFavorite1 = !isFavorite1;
                            });
                          },
                        ),
                        _buildListItem(
                          imagePath: 'images/kamar.png',
                          price: 9000000,
                          name: 'Kost Putra Pondok Firdaus',
                          distance: 5000,
                          isFavorite: isFavorite2,
                          onTap: () {
                            setState(() {
                              isFavorite2 = !isFavorite2;
                            });
                          },
                        ),
                        _buildListItem(
                          imagePath: 'images/kamar.png',
                          price: 7000000,
                          name: 'Kost Putri Pondok Firdaus',
                          distance: 600,
                          isFavorite: isFavorite3,
                          onTap: () {
                            setState(() {
                              isFavorite3 = !isFavorite3;
                            });
                          },
                        ),
                        _buildListItem(
                          imagePath: 'images/kamar.png',
                          price: 10000000,
                          name: 'Kost Putra Pondok Firdaus',
                          distance: 6500,
                          isFavorite: isFavorite4,
                          onTap: () {
                            setState(() {
                              isFavorite4 = !isFavorite4;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color.fromRGBO(100, 204, 197, 1),
          selectedItemColor: const Color.fromARGB(255, 232, 255, 240),
          unselectedItemColor: Colors.grey,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedFontSize: 14,
          unselectedFontSize: 14,
          onTap: (int index) {
            switch (index) {
              case 0:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Home()),
                );
                break;
              case 1:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Simpan()),
                );
                break;
              case 2:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const JualKos()),
                );
                break;
              case 3:
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
                'lib/icons/simpan_active.png',
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

  Widget _buildBackbutton() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(254, 251, 246, 1),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
            spreadRadius: 0,
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: IconButton(
        icon: Image.asset(
          'lib/icons/back.png',
          color: const Color.fromRGBO(100, 204, 197, 1),
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  Widget _buildListItem({
    required String imagePath,
    required int price,
    required String name,
    required int distance,
    required bool isFavorite,
    required VoidCallback onTap,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Container(
            width: 370,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: const Color.fromARGB(108, 206, 206, 206),
              ),
              borderRadius: BorderRadius.circular(20.0),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.black.withOpacity(0.5),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      formatCurrency(price),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 35,
                  left: 10,
                  child: Text(
                    name,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Row(
                    children: [
                      Text(
                        getDistanceText(distance),
                        style: const TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 17,
                        ),
                      ),
                      const SizedBox(width: 5),
                      GestureDetector(
                        onTap: onTap,
                        child: Icon(
                          Icons.favorite,
                          color: isFavorite ? Colors.red : Colors.white,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 2),
        ],
      ),
    );
  }

  String formatCurrency(int amount) {
    if (amount >= 1000000) {
      double result = amount / 1000000;
      if (result % 1 == 0) {
        return 'Rp ${result.toInt()} jt/thn';
      } else {
        return 'Rp ${result.toStringAsFixed(1)} jt/thn';
      }
    } else if (amount >= 1000) {
      double result = amount / 1000;
      if (result % 1 == 0) {
        return 'Rp ${result.toInt()} thn';
      } else {
        return 'Rp ${result.toStringAsFixed(1)} thn';
      }
    } else {
      return 'Rp $amount';
    }
  }

  String getDistanceText(int distance) {
    if (distance >= 1000) {
      double km = distance / 1000;
      if (distance % 1000 == 0) {
        return '${km.toInt()} km';
      } else {
        return '${km.toStringAsFixed(1)} km';
      }
    } else {
      return '$distance meter';
    }
  }
}
