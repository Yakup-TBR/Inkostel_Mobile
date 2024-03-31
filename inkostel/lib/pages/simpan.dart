import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(Simpan());
}

class Simpan extends StatefulWidget {
  const Simpan({Key? key}) : super(key: key);

  @override
  _SimpanState createState() => _SimpanState();
}

class _SimpanState extends State<Simpan> {
  bool isFavorite1 = false;
  bool isFavorite2 = false;
  bool isFavorite3 = false;
  bool isFavorite4 = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromRGBO(253, 252, 248, 1),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(253, 252, 248, 1),
          toolbarHeight: 75,
          title: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Row(
              children: [
                _buildProfileImage(),
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
        bottomNavigationBar: _buildBottomNavigationBar(),
      ),
    );
  }

  Widget _buildProfileImage() {
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
      padding: const EdgeInsets.all(11),
      child: Image.asset(
        'lib/icons/back.png',
        color: const Color.fromRGBO(100, 204, 197, 1),
      ),
    );
  }

  Widget _buildElevatedButton(String label) {
    return ElevatedButton(
      onPressed: () {
        // Action when button is pressed
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateColor.resolveWith((states) {
          return states.contains(MaterialState.pressed)
              ? const Color.fromRGBO(100, 204, 197, 1)
              : Colors.white;
        }),
        foregroundColor: MaterialStateColor.resolveWith((states) {
          return states.contains(MaterialState.pressed)
              ? Colors.white
              : const Color.fromRGBO(100, 204, 197, 1);
        }),
        side: MaterialStateProperty.all(
          const BorderSide(
            color: Color.fromRGBO(100, 204, 197, 1),
            width: 1.0,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
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

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: const Color.fromRGBO(100, 204, 197, 1),
      selectedItemColor: const Color.fromARGB(255, 232, 255, 240),
      unselectedItemColor: Colors.grey,
      selectedFontSize: 14,
      unselectedFontSize: 14,
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Image.asset(
            'lib/icons/home.png',
            height: 30,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'lib/icons/search.png',
            color: const Color.fromARGB(159, 252, 252, 252),
            height: 30,
          ),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'lib/icons/simpan.png',
            height: 30,
          ),
          label: 'Save',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'lib/icons/plus.png',
            height: 30,
          ),
          label: 'Add',
        ),
      ],
      onTap: (int index) {
        // Handle bottom navigation bar item tap here
        // You can navigate to different screens or perform any other actions
      },
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
