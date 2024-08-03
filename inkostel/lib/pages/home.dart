import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inkostel/pages/carikos.dart';
import 'package:inkostel/pages/carikos_terdekat.dart';
import 'package:inkostel/pages/carikos_termurah.dart';
import 'package:inkostel/pages/detailk.dart';
import 'package:inkostel/pages/jualkos.dart';
import 'package:inkostel/pages/profile.dart';
import 'package:inkostel/pages/settings.dart';
import 'package:inkostel/pages/simpan.dart';
import 'package:inkostel/service/home_service.dart';
import 'package:inkostel/service/kost_model.dart';
import 'package:inkostel/service/user_model.dart';
import 'package:inkostel/utils/format_currency.dart';

class Home extends StatefulWidget {
  Home({super.key});
  // ignore: unused_field
  final TextEditingController _searchController = TextEditingController();

  @override
  // ignore: library_private_types_in_public_api
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
  // ignore: unused_field
  late Future<List<Kost>> _kostsFuture;
  final TextEditingController _searchController = TextEditingController();
  UserProfile? userProfile;

  @override
  void initState() {
    super.initState();
    _kostsFuture = fetchData();
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
      // ignore: avoid_print
      print("Error fetching user profile: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color.fromRGBO(253, 252, 248, 1),
        appBar: AppBar(
          // ----------Appbar
          backgroundColor: const Color.fromRGBO(253, 252, 248, 1),
          scrolledUnderElevation: 0.0,
          toolbarHeight: 100,
          title: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Row(
              children: [
                GestureDetector(
                  key: const Key('profileButton'),
                  onTap: () {
                    // Tambahkan kode navigasi ke halaman profil di sini
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Profile(),
                      ),
                    );
                  },
                  child: Container(
                    key: const Key('orang_image'),
                    width: 50,
                    height: 50,
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
                      image: userProfile != null &&
                              userProfile!.photoURL.isNotEmpty
                          ? DecorationImage(
                              image: NetworkImage(userProfile!.photoURL),
                              fit: BoxFit.cover,
                              onError: (exception, stackTrace) {
                                // Handle the error, for example by showing a default image
                                const DecorationImage(
                                  image: AssetImage(
                                    'lib/icons/orang.png',
                                  ),
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
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        );
                      } else {
                        return const Text(
                          '',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        );
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
        body: Stack(
          children: [
            Column(children: [
              // ----------SearchBar
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      key: const Key('searchBar'),
                      padding: const EdgeInsets.only(left: 22, right: 22),
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(254, 251, 246, 1),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintStyle: GoogleFonts.getFont(
                              'Poppins',
                              fontSize: 16,
                            ),
                            hintText: 'Cari Kos Disini..',
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: InkWell(
                                onTap: () {
                                  String searchText = _searchController.text;
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CariKos(searchText: searchText),
                                    ),
                                  );
                                },
                                child: Image.asset(
                                  'lib/icons/search.png',
                                  key: const Key('search_image'),
                                  color: const Color.fromRGBO(100, 204, 197, 1),
                                  width: 20,
                                  height: 20,
                                  fit: BoxFit.fill,
                                ),
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
                            ),
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
              // ---------- End SearchBar,
              const SizedBox(height: 20),
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
                                      builder: (context) => const CariKos(
                                            searchText: '',
                                          )),
                                );
                              },
                              child: Text(
                                'See All',
                                key: const Key('seeAllRekomendasi'),
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
                                        return CardRekomendasi(
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
                            Text('Terdekat dari Tel-U',
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
                                      builder: (context) =>
                                          const CariKosTerdekat(
                                            searchText: '',
                                          )),
                                );
                              },
                              child: Text(
                                'See All',
                                key: const Key('seeAllTerdekat'),
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
                            child: FutureBuilder<List<Kost>>(
                                future: fetchDataTerdekat(),
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
                                        return CardTerdekat(
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
                                      builder: (context) =>
                                          const CariKosTermurah(
                                            searchText: '',
                                          )),
                                );
                              },
                              child: Text(
                                'See All',
                                key: const Key('seeAllTermurah'),
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
                            child: FutureBuilder<List<Kost>>(
                                future: fetchDataTermurah(),
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
                                        return CardTermurah(
                                            kost: snapshot.data![index]);
                                      },
                                    );
                                  }
                                })),
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
                key: const Key('homeActive_image'),
                height: 30,
              ),
              label: 'Home',
              key: const Key('homeNavItem'),
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'lib/icons/simpan.png',
                key: const Key('simpan_image'),
                height: 30,
              ),
              label: 'Search',
              key: const Key('simpanNavItem'),
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'lib/icons/plus.png',
                key: const Key('plus_image'),
                height: 30,
              ),
              label: 'Save',
              key: const Key('saveNavItem'),
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'lib/icons/gear.png',
                key: const Key('gear_image'),
                height: 30,
              ),
              label: 'Settings',
              key: const Key('SetNavItem'),
            ),
          ],
        ),
      ),
    );
  }
}

// ListView Rekomendasi
class CardRekomendasi extends StatefulWidget {
  final Kost kost;

  const CardRekomendasi({super.key, required this.kost});

  @override
  State<CardRekomendasi> createState() => _CardRekomendasiState();
}

class _CardRekomendasiState extends State<CardRekomendasi> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Detail(kosId: widget.kost.kosId),
              ));
        },
        child: Container(
          width: 230,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: const Color.fromARGB(109, 134, 146, 134),
            ),
            borderRadius: BorderRadius.circular(20.0),
            image: DecorationImage(
              image: NetworkImage(widget.kost.imageUrl[0]),
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.2), BlendMode.darken),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Visibility(
                visible: false,
                child: Text(widget.kost.kosId),
              ),
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

// ListView Terdekat
class CardTerdekat extends StatefulWidget {
  final Kost kost;

  const CardTerdekat({super.key, required this.kost});

  @override
  State<CardTerdekat> createState() => _CardTerdekatState();
}

class _CardTerdekatState extends State<CardTerdekat> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Detail(kosId: widget.kost.kosId),
              ));
        },
        child: Container(
          width: 230,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: const Color.fromARGB(109, 134, 146, 134),
            ),
            borderRadius: BorderRadius.circular(20.0),
            image: DecorationImage(
              image: NetworkImage(widget.kost.imageUrl[0]),
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.2), BlendMode.darken),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Visibility(
                visible: false,
                child: Text(widget.kost.kosId),
              ),
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

// ListView Termurah
class CardTermurah extends StatefulWidget {
  final Kost kost;

  const CardTermurah({super.key, required this.kost});

  @override
  State<CardTermurah> createState() => _CardTermurahState();
}

class _CardTermurahState extends State<CardTermurah> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Detail(kosId: widget.kost.kosId),
              ));
        },
        child: Container(
          width: 230,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: const Color.fromARGB(109, 134, 146, 134),
            ),
            borderRadius: BorderRadius.circular(20.0),
            image: DecorationImage(
              image: NetworkImage(widget.kost.imageUrl[0]),
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.2), BlendMode.darken),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Visibility(
                visible: false,
                child: Text(widget.kost.kosId),
              ),
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
