import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const CariKos());
}

class CariKos extends StatelessWidget {
  const CariKos({super.key});

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
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            borderSide: BorderSide(
                              width: 0.8,
                              color: Color.fromRGBO(100, 204, 197, 1),
                            ),
                          ),
                          disabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            borderSide: BorderSide(
                              width: 0.5,
                              color: Color.fromRGBO(100, 204, 197, 1),
                            ),
                          ), // Tidak ada perubahan ? Opsional dihapus nanti
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
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
                const Row()
              ],
            ),
            SizedBox(height: 20),
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
                        return Color.fromRGBO(100, 204, 197,
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
                      return Color.fromRGBO(100, 204, 197,
                          1); // Kembali ke warna teks aslinya saat tidak ditekan
                    }),
                    side: MaterialStateProperty.all(BorderSide(
                      color: const Color.fromRGBO(100, 204, 197,
                          1), // Ubah warna border sesuai keinginan Anda
                      width: 1.0, // Atur lebar border
                    )),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: const Text(
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
                        return Color.fromRGBO(100, 204, 197,
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
                      return Color.fromRGBO(100, 204, 197,
                          1); // Kembali ke warna teks aslinya saat tidak ditekan
                    }),
                    side: MaterialStateProperty.all(BorderSide(
                      color: const Color.fromRGBO(100, 204, 197,
                          1), // Ubah warna border sesuai keinginan Anda
                      width: 1.0, // Atur lebar border
                    )),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: const Text(
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
                        return Color.fromRGBO(100, 204, 197,
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
                      return Color.fromRGBO(100, 204, 197,
                          1); // Kembali ke warna teks aslinya saat tidak ditekan
                    }),
                    side: MaterialStateProperty.all(BorderSide(
                      color: const Color.fromRGBO(100, 204, 197,
                          1), // Ubah warna border sesuai keinginan Anda
                      width: 1.0, // Atur lebar border
                    )),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: const Text(
                      'Campur',
                      style: TextStyle(
                        fontSize: 20, // Sesuaikan ukuran font di sini
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          Container(
                            width: 370,
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Color.fromARGB(109, 134, 146, 134),
                              ),
                              borderRadius: BorderRadius.circular(20.0),
                              image: DecorationImage(
                                image: AssetImage('images/kamar.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 10,
                                  right: 10,
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors
                                          .white, // Mengatur warna background menjadi putih penuh
                                      borderRadius: BorderRadius.circular(
                                          20), // Mengatur borderRadius menjadi lebih besar untuk membuat border lonjong
                                      border: Border.all(
                                        color: Colors.black.withOpacity(
                                            0.5), // Mengatur warna border
                                        width: 1, // Mengatur lebar border
                                      ),
                                    ),
                                    child: Text(
                                      formatCurrency(8500000),
                                      style: TextStyle(
                                        color:
                                            Colors.black, // Mengatur warna teks
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 35,
                                  left: 10,
                                  child: Container(
                                    child: Text(
                                      'Kost Putri Pondok Firdaus',
                                      style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 255, 255, 255),
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 10,
                                  left: 10,
                                  child: Container(
                                    child: Text(
                                      getDistanceText(900),
                                      style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 255, 255, 255),
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            width: 370,
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Color.fromARGB(109, 134, 146, 134),
                              ),
                              borderRadius: BorderRadius.circular(20.0),
                              image: DecorationImage(
                                image: AssetImage('images/kamar.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 10,
                                  right: 10,
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors
                                          .white, // Mengatur warna background menjadi putih penuh
                                      borderRadius: BorderRadius.circular(
                                          20), // Mengatur borderRadius menjadi lebih besar untuk membuat border lonjong
                                      border: Border.all(
                                        color: Colors.black.withOpacity(
                                            0.5), // Mengatur warna border
                                        width: 1, // Mengatur lebar border
                                      ),
                                    ),
                                    child: Text(
                                      formatCurrency(9000000),
                                      style: TextStyle(
                                        color:
                                            Colors.black, // Mengatur warna teks
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 35,
                                  left: 10,
                                  child: Container(
                                    child: Text(
                                      'Kost Putra Pondok Firdaus',
                                      style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 255, 255, 255),
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 10,
                                  left: 10,
                                  child: Container(
                                    child: Text(
                                      getDistanceText(5000),
                                      style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 255, 255, 255),
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            width: 370,
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Color.fromARGB(109, 134, 146, 134),
                              ),
                              borderRadius: BorderRadius.circular(20.0),
                              image: DecorationImage(
                                image: AssetImage('images/kamar.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 10,
                                  right: 10,
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors
                                          .white, // Mengatur warna background menjadi putih penuh
                                      borderRadius: BorderRadius.circular(
                                          20), // Mengatur borderRadius menjadi lebih besar untuk membuat border lonjong
                                      border: Border.all(
                                        color: Colors.black.withOpacity(
                                            0.5), // Mengatur warna border
                                        width: 1, // Mengatur lebar border
                                      ),
                                    ),
                                    child: Text(
                                      formatCurrency(7000000),
                                      style: TextStyle(
                                        color:
                                            Colors.black, // Mengatur warna teks
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 35,
                                  left: 10,
                                  child: Container(
                                    child: Text(
                                      'Kost Putri Pondok Firdaus',
                                      style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 255, 255, 255),
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 10,
                                  left: 10,
                                  child: Container(
                                    child: Text(
                                      getDistanceText(600),
                                      style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 255, 255, 255),
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            width: 370,
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Color.fromARGB(109, 134, 146, 134),
                              ),
                              borderRadius: BorderRadius.circular(20.0),
                              image: DecorationImage(
                                image: AssetImage('images/kamar.png'),
                                colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.2),
                                    BlendMode.darken),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 10,
                                  right: 10,
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: Colors.black.withOpacity(0.5),
                                        width: 1,
                                      ),
                                    ),
                                    child: Text(
                                      formatCurrency(10000000),
                                      style: TextStyle(
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
                                  child: Container(
                                    child: Text(
                                      'Kost Putra Pondok Firdaus',
                                      style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 255, 255, 255),
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 10,
                                  left: 10,
                                  child: Container(
                                    child: Text(
                                      getDistanceText(6500),
                                      style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 255, 255, 255),
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        // Bottom NavBar
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
      ),
    ));
  }

// Fungsi untuk mengonversi harga
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

  // Fungsi untuk mengonversi jarak
  String getDistanceText(int distance) {
    if (distance >= 1000) {
      double km = distance / 1000;
      // Jika nilai jarak adalah bilangan bulat, kembalikan sebagai kilometer tanpa desimal
      if (distance % 1000 == 0) {
        return '${km.toInt()} km';
      } else {
        // Jika nilai jarak memiliki desimal, tampilkan satu angka di belakang koma
        return '${km.toStringAsFixed(1)} km';
      }
    } else {
      // Untuk jarak di bawah 1000 meter, kembalikan sebagai meter
      return '${distance} meter';
    }
  }
}
