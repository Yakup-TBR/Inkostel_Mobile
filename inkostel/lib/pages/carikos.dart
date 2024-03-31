import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inkostel/notification_controller.dart';
import 'package:inkostel/pages/detail.dart';
import 'package:inkostel/pages/jualkos.dart';
import 'package:inkostel/pages/simpan.dart';
import 'package:inkostel/pages/tes.dart';
import 'package:inkostel/main.dart';

import 'detail.dart';

void main() {
  runApp(const CariKos());
}

class CariKos extends StatefulWidget {
  const CariKos({Key? key}) : super(key: key);

  @override
  _CariKosState createState() => _CariKosState();
}

class _CariKosState extends State<CariKos> {
  @override
  void initState() {
    AwesomeNotifications().setListeners(
        onActionReceivedMethod: NotificationController.onActionReceivedMethod,
        onNotificationCreatedMethod:
            NotificationController.onNotificationCreateMethod,
        onNotificationDisplayedMethod:
            NotificationController.onNotificationDisplayMethod,
        onDismissActionReceivedMethod:
            NotificationController.onDissmissActionReceivedMethod);
    super.initState();
  }

  bool isFavorite1 = false;
  bool isFavorite2 = false;
  bool isFavorite3 = false;
  bool isFavorite4 = false; // State variable to track love icon color

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
                          const SizedBox(height: 20),
                          Container(
                            width: 370,
                            height: 200,
                            child: Stack(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => detail(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        color: const Color.fromARGB(
                                            109, 134, 146, 134),
                                      ),
                                      borderRadius: BorderRadius.circular(20.0),
                                      image: const DecorationImage(
                                        image: AssetImage('images/kamar.png'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
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
                                      formatCurrency(8500000),
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
                                  child: Container(
                                    child: const Text(
                                      'Kost Putri Pondok Firdaus',
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 10,
                                  left: 10,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isFavorite1 = !isFavorite1;
                                        if (isFavorite1) {
                                          AwesomeNotifications()
                                              .createNotification(
                                            content: NotificationContent(
                                              id: 1,
                                              channelKey: 'notif_simpan',
                                              title: 'Kos Bla Bla Bla telah Disimpan!',
                                              body: 'Ketuk untuk melihat',
                                            ),
                                          );
                                        }
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          getDistanceText(900),
                                          style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                            fontSize: 17,
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        Image.asset(
                                          'lib/icons/simpan_active.png',
                                          color: isFavorite1
                                              ? const Color.fromRGBO(
                                                  100, 204, 197, 1)
                                              : Colors.white,
                                          width: 30,
                                          height: 30,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        detail()), // Navigasi ke halaman detail.dart
                              );
                            },
                            child: Container(
                              width: 370,
                              height: 200,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color:
                                      const Color.fromARGB(109, 134, 146, 134),
                                ),
                                borderRadius: BorderRadius.circular(20.0),
                                image: const DecorationImage(
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
                                      padding: const EdgeInsets.all(10),
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
                                        style: const TextStyle(
                                          color: Colors
                                              .black, // Mengatur warna teks
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
                                      child: const Text(
                                        'Kost Putra Pondok Firdaus',
                                        style: TextStyle(
                                          color: Color.fromARGB(
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
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isFavorite2 = !isFavorite2;
                                          if (isFavorite2) {
                                          AwesomeNotifications()
                                              .createNotification(
                                            content: NotificationContent(
                                              id: 1,
                                              channelKey: 'notif_simpan',
                                              title: 'Kos Bla Bla Bla telah Disimpan!',
                                              body: 'Ketuk untuk melihat',
                                            ),
                                          );
                                        }
                                        });
                                      },
                                      child: Row(
                                        children: [
                                          Text(
                                            getDistanceText(5000),
                                            style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                              fontSize: 17,
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          Image.asset(
                                            'lib/icons/simpan_active.png',
                                            color: isFavorite2
                                                ? const Color.fromRGBO(
                                                    100, 204, 197, 1)
                                                : Colors.white,
                                            width: 30,
                                            height: 30,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        detail()), // Navigasi ke halaman detail.dart
                              );
                            },
                            child: Container(
                              width: 370,
                              height: 200,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color:
                                      const Color.fromARGB(109, 134, 146, 134),
                                ),
                                borderRadius: BorderRadius.circular(20.0),
                                image: const DecorationImage(
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
                                      padding: const EdgeInsets.all(10),
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
                                        style: const TextStyle(
                                          color: Colors
                                              .black, // Mengatur warna teks
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
                                      child: const Text(
                                        'Kost Putri Pondok Firdaus',
                                        style: TextStyle(
                                          color: Color.fromARGB(
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
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isFavorite3 = !isFavorite3;
                                          if (isFavorite3) {
                                          AwesomeNotifications()
                                              .createNotification(
                                            content: NotificationContent(
                                              id: 1,
                                              channelKey: 'notif_simpan',
                                              title: 'Kos Bla Bla Bla telah Disimpan!',
                                              body: 'Ketuk untuk melihat',
                                            ),
                                          );
                                        }
                                        });
                                      },
                                      child: Row(
                                        children: [
                                          Text(
                                            getDistanceText(600),
                                            style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                              fontSize: 17,
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          Image.asset(
                                            'lib/icons/simpan_active.png',
                                            color: isFavorite3
                                                ? const Color.fromRGBO(
                                                    100, 204, 197, 1)
                                                : Colors.white,
                                            width: 30,
                                            height: 30,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        detail()), // Navigasi ke halaman detail.dart
                              );
                            },
                            child: Container(
                              width: 370,
                              height: 200,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color:
                                      const Color.fromARGB(109, 134, 146, 134),
                                ),
                                borderRadius: BorderRadius.circular(20.0),
                                image: DecorationImage(
                                  image: const AssetImage('images/kamar.png'),
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
                                        formatCurrency(10000000),
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
                                    child: Container(
                                      child: const Text(
                                        'Kost Putra Pondok Firdaus',
                                        style: TextStyle(
                                          color: Color.fromARGB(
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
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isFavorite4 = !isFavorite4;
                                          if (isFavorite4) {
                                          AwesomeNotifications()
                                              .createNotification(
                                            content: NotificationContent(
                                              id: 1,
                                              channelKey: 'notif_simpan',
                                              title: 'Kos Bla Bla Bla telah Disimpan!',
                                              body: 'Ketuk untuk melihat',
                                            ),
                                          );
                                        }
                                        });
                                      },
                                      child: Row(
                                        children: [
                                          Text(
                                            getDistanceText(6500),
                                            style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                              fontSize: 17,
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          Image.asset(
                                            'lib/icons/simpan_active.png',
                                            color: isFavorite4
                                                ? const Color.fromRGBO(
                                                    100, 204, 197, 1)
                                                : Colors.white,
                                            width: 30,
                                            height: 30,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
