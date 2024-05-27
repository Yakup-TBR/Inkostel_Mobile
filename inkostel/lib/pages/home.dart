import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inkostel/pages/carikos.dart';
import 'package:inkostel/pages/Detailk.dart';
import 'package:inkostel/pages/profile.dart';
import 'package:inkostel/pages/simpan.dart';
import 'package:inkostel/pages/jualkos.dart';
import 'package:inkostel/pages/settings.dart';
import 'package:inkostel/service/kost_model.dart';
import 'package:inkostel/utils/format_currency.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

String getLabel(double value) {
  if (value < 500) {
    return "< 500 Meter";
  } else if (value >= 500 && value < 1000) {
    return "500 Meter - 1 KM";
  } else if (value >= 1000 && value < 2000) {
    return "1 KM - 2 KM";
  } else {
    return "> 2 KM";
  }
}

class _HomeState extends State<Home> {
  double currentSliderValue = 0.0;
  late Future<List<Kost>> _kostsFuture;

  @override
  void initState() {
    super.initState();
    _kostsFuture = fetchData();
  }

  Future<List<Kost>> fetchData() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("Kos").get();
    return querySnapshot.docs.map((doc) => Kost.fromFirestore(doc)).toList();
  }

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
                      padding: const EdgeInsets.only(left: 22, right: 22),
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
                            // List Rekomendasi
                            child: FutureBuilder<List<Kost>>(
                                future: fetchData(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  } else if (snapshot.hasError) {
                                    return Center(
                                        child:
                                            Text('Error: ${snapshot.error}'));
                                  } else if (!snapshot.hasData ||
                                      snapshot.data!.isEmpty) {
                                    return const Center(
                                        child: Text('No data available'));
                                  } else {
                                    return ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (context, index) {
                                        return KostCard(
                                            kost: snapshot.data![index]);
                                      },
                                    );
                                  }
                                })),
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
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Detail(
                        kosId: '',
                      )));
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
              image: const AssetImage('images/kamar_2.jpg'),
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
                            text: 'Harganya',
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
                        "NamaKos",
                        style: GoogleFonts.getFont(
                          'Poppins',
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "Alamat",
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

class KostCard extends StatefulWidget {
  final Kost kost;

  KostCard({required this.kost});

  @override
  State<KostCard> createState() => _KostCardState();
}

class _KostCardState extends State<KostCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: GestureDetector(
        // onTap: () {
        //   Navigator.push(
        //       context, MaterialPageRoute(builder: (context) => detail()));
        // },
        child: Container(
          width: 230,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: const Color.fromARGB(109, 134, 146, 134),
            ),
            borderRadius: BorderRadius.circular(20.0),
            image: DecorationImage(
              image: AssetImage('images/kamar.png'),
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
                    child: Text(
                      formatCurrency(widget.kost.hargaPertahun),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
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
                        widget.kost.namaKost,
                        style: GoogleFonts.getFont(
                          'Poppins',
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        widget.kost.alamatKos,
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
      ),
    );
  }
}

// Class Filter Dialog dibuat stateful
class FilterDialog extends StatefulWidget {
  const FilterDialog({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FilterDialogState createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  double _currentSliderValue = 0.0;
  bool isChecked100Meters = false;
  bool isChecked200Meters = false;
  bool isChecked500Meters = false;
  bool isChecked1KM = false;
  bool isCheckedLebih1KM = false;

  String _getLabel(double value) {
    if (value < 500) {
      return "< 5 Juta";
    } else if (value >= 500 && value < 1000) {
      return "5 - 7 Juta";
    } else if (value >= 1000 && value < 1500) {
      return "7 - 10 Juta";
    } else if (value >= 1500 && value < 2000) {
      return "10 - 15 Juta";
    } else {
      return "> 15 Juta";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Filter',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Jarak',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            CheckboxListTile(
              title: const Text('Kurang 100 Meter'),
              value: isChecked100Meters,
              onChanged: (bool? value) {
                setState(() {
                  isChecked100Meters = value!;
                });
              },
              activeColor: const Color.fromRGBO(100, 204, 197, 1),
              checkColor: Colors.white,
            ),
            CheckboxListTile(
              title: const Text('100 - 300 Meter'),
              value: isChecked200Meters,
              onChanged: (bool? value) {
                setState(() {
                  isChecked200Meters = value!;
                });
              },
              activeColor: const Color.fromRGBO(100, 204, 197, 1),
              checkColor: Colors.white,
            ),
            CheckboxListTile(
              title: const Text('300 - 500 Meter'),
              value: isChecked500Meters,
              onChanged: (bool? value) {
                setState(() {
                  isChecked500Meters = value!;
                });
              },
              activeColor: const Color.fromRGBO(100, 204, 197, 1),
              checkColor: Colors.white,
            ),
            CheckboxListTile(
              title: const Text('500 - 1 KM'),
              value: isChecked1KM,
              onChanged: (bool? value) {
                setState(() {
                  isChecked1KM = value!;
                });
              },
              activeColor: const Color.fromRGBO(100, 204, 197, 1),
              checkColor: Colors.white,
            ),
            CheckboxListTile(
              title: const Text('Lebih dari 1 KM'),
              value: isCheckedLebih1KM,
              onChanged: (bool? value) {
                setState(() {
                  isCheckedLebih1KM = value!;
                });
              },
              activeColor: const Color.fromRGBO(100, 204, 197, 1),
              checkColor: Colors.white,
            ),
            const SizedBox(height: 20),
            const Text(
              'Harga Pertahun',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            Slider(
              value: _currentSliderValue,
              max: 2000,
              divisions: 4,
              label: _getLabel(_currentSliderValue),
              onChanged: (double value) {
                setState(() {
                  _currentSliderValue = value;
                });
              },
              activeColor: const Color.fromRGBO(100, 204, 197, 1),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Tutup',
                    style: GoogleFonts.getFont(
                      'Poppins',
                      fontSize: 17,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
