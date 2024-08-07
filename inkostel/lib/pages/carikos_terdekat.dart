// ignore_for_file: unused_element, library_private_types_in_public_api

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inkostel/notification_controller.dart';
import 'package:inkostel/pages/detailk.dart';
import 'package:inkostel/pages/home.dart';
import 'package:inkostel/pages/jualkos.dart';
import 'package:inkostel/pages/profile.dart';
import 'package:inkostel/pages/settings.dart';
import 'package:inkostel/pages/simpan.dart';
import 'package:inkostel/service/kost_model.dart';
import 'package:inkostel/service/user_model.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class CariKosTerdekat extends StatefulWidget {
  final String searchText;

  const CariKosTerdekat({super.key, required this.searchText});

  static Future<List<Kost>> fetchData() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("Kos").get();
    List<Kost> kostList =
        querySnapshot.docs.map((doc) => Kost.fromFirestore(doc)).toList();

    // Urutkan berdasarkan jarak terdekat
    kostList.sort((a, b) => a.jarakKost.compareTo(b.jarakKost));

    return kostList;
  }

  @override
  _CariKosTerdekatState createState() => _CariKosTerdekatState();
}

class _CariKosTerdekatState extends State<CariKosTerdekat> {
  List<Kost> _allKosts = [];
  List<Kost> _displayedKosts = [];
  bool _isLoading = true;
  bool _isLoadingMore = false;
  // ignore: prefer_final_fields
  int _batchSize = 3;
  int _currentBatch = 0;
  // ignore: prefer_final_fields
  ScrollController _scrollController = ScrollController();
  String _selectedCategory = '';
  bool isChecked100Meters = false;
  bool isChecked200Meters = false;
  bool isChecked500Meters = false;
  bool isChecked1KM = false;
  bool isCheckedLebih1KM = false;
  double _currentSliderValue = 0.0;
  UserProfile? userProfile;

  void applyFilters(
    bool checked100Meters,
    bool checked200Meters,
    bool checked500Meters,
    bool checked1KM,
    bool checkedLebih1KM,
    double sliderValue,
  ) {
    setState(() {
      isChecked100Meters = checked100Meters;
      isChecked200Meters = checked200Meters;
      isChecked500Meters = checked500Meters;
      isChecked1KM = checked1KM;
      isCheckedLebih1KM = checkedLebih1KM;
      _currentSliderValue = sliderValue;
      _filteredKosts();
    });
  }

  void _filteredKosts() {
    setState(() {
      _displayedKosts = _allKosts.where((kost) {
        bool matchesDistance = true;
        bool matchesPrice = true;

        // Filter jarak
        if (isChecked100Meters) {
          matchesDistance = matchesDistance && kost.jarakKost <= 100;
        }
        if (isChecked200Meters) {
          matchesDistance = matchesDistance &&
              (kost.jarakKost >= 100 && kost.jarakKost <= 300);
        }
        if (isChecked500Meters) {
          matchesDistance = matchesDistance &&
              (kost.jarakKost >= 300 && kost.jarakKost <= 500);
        }
        if (isChecked1KM) {
          matchesDistance = matchesDistance &&
              (kost.jarakKost >= 500 && kost.jarakKost <= 1000);
        }
        if (isCheckedLebih1KM) {
          matchesDistance = matchesDistance && kost.jarakKost >= 1000;
        }

        // Debug print for distance filtering

        // Filter harga
        if (_currentSliderValue < 500) {
          matchesPrice = kost.hargaPertahun < 5000000;
        } else if (_currentSliderValue >= 500 && _currentSliderValue < 1000) {
          matchesPrice =
              kost.hargaPertahun >= 5000000 && kost.hargaPertahun <= 7000000;
        } else if (_currentSliderValue >= 1000 && _currentSliderValue < 1500) {
          matchesPrice =
              kost.hargaPertahun >= 7000000 && kost.hargaPertahun <= 10000000;
        } else if (_currentSliderValue >= 1500 && _currentSliderValue < 2000) {
          matchesPrice =
              kost.hargaPertahun >= 10000000 && kost.hargaPertahun <= 15000000;
        } else {
          matchesPrice = kost.hargaPertahun >= 15000000;
        }

        // Debug print for price filtering
        // ignore: avoid_print
        print(
            'kost.hargaPertahun: ${kost.hargaPertahun}, matchesPrice: $matchesPrice');

        return matchesDistance && matchesPrice;
      }).toList();
    });
  }

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

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FilterDialog(
          applyFilters: (bool checked100Meters,
              bool checked200Meters,
              bool checked500Meters,
              bool checked1KM,
              bool checkedLebih1KM,
              double sliderValue) {
            applyFilters(checked100Meters, checked200Meters, checked500Meters,
                checked1KM, checkedLebih1KM, sliderValue);
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredKosts();
    _fetchInitialData();
    _fetchUserProfile();
    AwesomeNotifications().setListeners(
        onActionReceivedMethod: NotificationController.onActionReceivedMethod,
        onNotificationCreatedMethod:
            NotificationController.onNotificationCreateMethod,
        onNotificationDisplayedMethod:
            NotificationController.onNotificationDisplayMethod,
        onDismissActionReceivedMethod:
            NotificationController.onDissmissActionReceivedMethod);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          !_isLoadingMore) {
        _loadMoreData();
      }
    });
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

  Future<void> _fetchInitialData() async {
    List<Kost> fetchedKostList = await CariKosTerdekat.fetchData();
    setState(() {
      _allKosts = fetchedKostList;
      _currentBatch = 0;
      _displayedKosts = _allKosts.take(_batchSize).toList();
      _isLoading = false;
    });
  }

  Future<void> _loadMoreData() async {
    if (_currentBatch * _batchSize >= _allKosts.length) return;

    setState(() {
      _isLoadingMore = true;
    });

    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _currentBatch++;
      List<Kost> newBatch = _allKosts
          .skip((_currentBatch - 1) * _batchSize)
          .take(_batchSize)
          .toList();
      _displayedKosts.addAll(newBatch.where((kost) => !_displayedKosts
          .any((displayedKost) => displayedKost.kosId == kost.kosId)));
      _isLoadingMore = false;
    });
  }

  Future<void> _searchKostNames() async {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _displayedKosts =
            _allKosts.take((_currentBatch + 1) * _batchSize).toList();
      } else {
        _displayedKosts = _allKosts.where((kost) {
          return kost.namaKost.toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  void _filterKosts(String category) {
    setState(() {
      _selectedCategory = category;
      if (_selectedCategory == '') {
        _displayedKosts =
            _allKosts.take((_currentBatch + 1) * _batchSize).toList();
      } else {
        _displayedKosts = _allKosts
            .where((kost) => kost.namaKost
                .toLowerCase()
                .contains(_selectedCategory.toLowerCase()))
            .take((_currentBatch + 1) * _batchSize)
            .toList();
      }
    });
  }

  void _toggleFilter(String filter) {
    setState(() {
      if (_selectedCategory == filter) {
        _selectedCategory = '';
      } else {
        _selectedCategory = filter;
      }
      _filterKosts(_selectedCategory);
    });
  }

// untuk menarik gambar dari firebase
  // Future<void> uploadImageAndSaveUrl(
  //     String imagePath, String imageName, String documentId) async {
  //   String downloadURL = await uploadImageToFirebase(imagePath, imageName);
  //   if (downloadURL.isNotEmpty) {
  //     await FirebaseFirestore.instance
  //         .collection('Kos')
  //         .doc(documentId)S
  //         .update({
  //       'ImageURL': downloadURL,
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
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
                      future:
                          getUserProfile(), // Panggil metode getUserProfile()
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
                // ----------SearchBar dan Tombol
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 22),
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
                                    // Call the search function here
                                    _searchKostNames();
                                  },
                                  child: Image.asset(
                                    'lib/icons/search.png',
                                    color:
                                        const Color.fromRGBO(100, 204, 197, 1),
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
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => FilterDialog(
                              applyFilters: applyFilters,
                            ),
                          );
                        },
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
                                offset: const Offset(0, 2),
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
                    ),
                    const Row()
                  ],
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () => _toggleFilter('putra'),
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateColor.resolveWith((states) {
                            return _selectedCategory == 'putra'
                                ? const Color.fromRGBO(100, 204, 197, 1)
                                : Colors.white;
                          }),
                          foregroundColor:
                              WidgetStateColor.resolveWith((states) {
                            return _selectedCategory == 'putra'
                                ? Colors.white
                                : const Color.fromRGBO(100, 204, 197, 1);
                          }),
                          side: WidgetStateProperty.all(const BorderSide(
                            color: Color.fromRGBO(100, 204, 197, 1),
                            width: 1.0,
                          )),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(3.0),
                          child: Text(
                            'Putra',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => _toggleFilter('putri'),
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateColor.resolveWith((states) {
                            return _selectedCategory == 'putri'
                                ? const Color.fromRGBO(100, 204, 197, 1)
                                : Colors.white;
                          }),
                          foregroundColor:
                              WidgetStateColor.resolveWith((states) {
                            return _selectedCategory == 'putri'
                                ? Colors.white
                                : const Color.fromRGBO(100, 204, 197, 1);
                          }),
                          side: WidgetStateProperty.all(const BorderSide(
                            color: Color.fromRGBO(100, 204, 197, 1),
                            width: 1.0,
                          )),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(3.0),
                          child: Text(
                            'Putri',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => _toggleFilter('campur'),
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateColor.resolveWith((states) {
                            return _selectedCategory == 'campur'
                                ? const Color.fromRGBO(100, 204, 197, 1)
                                : Colors.white;
                          }),
                          foregroundColor:
                              WidgetStateColor.resolveWith((states) {
                            return _selectedCategory == 'campur'
                                ? Colors.white
                                : const Color.fromRGBO(100, 204, 197, 1);
                          }),
                          side: WidgetStateProperty.all(const BorderSide(
                            color: Color.fromRGBO(100, 204, 197, 1),
                            width: 1.0,
                          )),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(3.0),
                          child: Text(
                            'Campur',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: _isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : ListView.builder(
                            controller: _scrollController,
                            // itemCount: _kostList.length + 1,
                            itemCount: _displayedKosts.length + 1,
                            itemBuilder: (context, index) {
                              if (index == _displayedKosts.length) {
                                return _isLoadingMore
                                    ? const Center(
                                        child: CircularProgressIndicator())
                                    : Container();
                              }
                              final Kost kost = _displayedKosts[index];
                              return Container(
                                width: double.infinity,
                                margin: const EdgeInsets.only(
                                    bottom: 10, left: 1, right: 1),
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    Visibility(
                                      visible: false,
                                      child: Text(kost.kosId),
                                    ),
                                    const SizedBox(height: 20),
                                    SizedBox(
                                      width: 370,
                                      height: 200,
                                      child: Stack(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      Detail(kosId: kost.kosId),
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
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                                image: DecorationImage(
                                                  image: NetworkImage(kost
                                                          .imageUrl[
                                                      0]), // Menggunakan imageUrls dari objek _kos
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
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                border: Border.all(
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                  width: 1,
                                                ),
                                              ),
                                              child: Text(
                                                formatCurrency(
                                                    kost.hargaPertahun),
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
                                              kost.namaKost,
                                              style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 10,
                                            left: 10,
                                            child: Text(
                                              formatJarak(kost.jarakKost),
                                              style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          //UNTUK SIMPAN KOS
                                          Positioned(
                                            bottom: 10,
                                            right: 10,
                                            child: StreamBuilder<QuerySnapshot>(
                                              stream: FirebaseFirestore.instance
                                                  .collection('SimpanKos')
                                                  .where('User ID',
                                                      isEqualTo: FirebaseAuth
                                                          .instance
                                                          .currentUser
                                                          ?.uid)
                                                  .snapshots(),
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return const CircularProgressIndicator();
                                                }
                                                if (snapshot.hasError) {
                                                  return Text(
                                                      'Error: ${snapshot.error}');
                                                }
                                                if (!snapshot.hasData ||
                                                    snapshot
                                                        .data!.docs.isEmpty) {
                                                  // Tidak ada data yang tersimpan untuk pengguna saat ini
                                                  return GestureDetector(
                                                    onTap: () async {
                                                      final user = FirebaseAuth
                                                          .instance.currentUser;
                                                      if (user != null) {
                                                        final userId = user.uid;
                                                        kost.toggleFavoriteStatus();
                                                        if (kost.isFavorite) {
                                                          AwesomeNotifications()
                                                              .createNotification(
                                                            content:
                                                                NotificationContent(
                                                              id: 1,
                                                              channelKey:
                                                                  'notif_simpan',
                                                              title:
                                                                  'Kos ${kost.namaKost} telah Disimpan!',
                                                              body:
                                                                  'Ketuk untuk melihat',
                                                            ),
                                                          );
                                                        }
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection('Kos')
                                                            .doc(kost.kosId)
                                                            .update(kost
                                                                .toFirestore());

                                                        final simpanKosDocId =
                                                            '${userId}_${kost.kosId}';
                                                        if (kost.isFavorite) {
                                                          await FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'SimpanKos')
                                                              .doc(
                                                                  simpanKosDocId)
                                                              .set({
                                                            'Nama Kos':
                                                                kost.namaKost,
                                                            'Harga Pertahun': kost
                                                                .hargaPertahun,
                                                            'ImageURLs':
                                                                kost.imageUrl,
                                                            'Kos ID':
                                                                kost.kosId,
                                                            'User ID': userId,
                                                            'Alamat Kos':
                                                                kost.alamatKos,
                                                            'Jarak':
                                                                kost.jarakKost,
                                                            'isFavorite':
                                                                kost.isFavorite,
                                                          });
                                                        } else {
                                                          await FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'SimpanKos')
                                                              .doc(
                                                                  simpanKosDocId)
                                                              .delete();
                                                        }

                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection('Kos')
                                                            .doc(kost.kosId)
                                                            .update({
                                                          // ignore: unnecessary_brace_in_string_interps
                                                          'isFavorite_${userId}':
                                                              kost.isFavorite
                                                        });
                                                      } else {
                                                        // ignore: avoid_print
                                                        print(
                                                            'Pengguna tidak login');
                                                      }
                                                    },
                                                    child: Row(
                                                      children: [
                                                        const SizedBox(
                                                            width: 5),
                                                        Image.asset(
                                                          'lib/icons/simpan_active.png',
                                                          color: Colors.grey,
                                                          width: 30,
                                                          height: 30,
                                                          errorBuilder:
                                                              (context, error,
                                                                  stackTrace) {
                                                            return const Icon(
                                                                Icons.error,
                                                                color:
                                                                    Colors.red);
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                } else {
                                                  // Data telah disimpan oleh pengguna saat ini
                                                  final user = FirebaseAuth
                                                      .instance.currentUser;
                                                  final userId = user?.uid;
                                                  final docs =
                                                      snapshot.data!.docs;
                                                  final isKostSaved = docs.any(
                                                      (doc) =>
                                                          doc['Kos ID'] ==
                                                              kost.kosId &&
                                                          doc['User ID'] ==
                                                              userId);
                                                  return GestureDetector(
                                                    onTap: () async {
                                                      if (user != null) {
                                                        kost.toggleFavoriteStatus();
                                                        if (kost.isFavorite) {
                                                          AwesomeNotifications()
                                                              .createNotification(
                                                            content:
                                                                NotificationContent(
                                                              id: 1,
                                                              channelKey:
                                                                  'notif_simpan',
                                                              title:
                                                                  'Kos ${kost.namaKost} telah Disimpan!',
                                                              body:
                                                                  'Ketuk untuk melihat',
                                                            ),
                                                          );
                                                        }
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection('Kos')
                                                            .doc(kost.kosId)
                                                            .update(kost
                                                                .toFirestore());

                                                        final simpanKosDocId =
                                                            '${userId}_${kost.kosId}';
                                                        if (kost.isFavorite) {
                                                          await FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'SimpanKos')
                                                              .doc(
                                                                  simpanKosDocId)
                                                              .set({
                                                            'Nama Kos':
                                                                kost.namaKost,
                                                            'Harga Pertahun': kost
                                                                .hargaPertahun,
                                                            'ImageURLs':
                                                                kost.imageUrl,
                                                            'Kos ID':
                                                                kost.kosId,
                                                            'User ID': userId,
                                                            'Alamat Kos':
                                                                kost.alamatKos,
                                                            'Jarak':
                                                                kost.jarakKost,
                                                            'isFavorite':
                                                                kost.isFavorite,
                                                          });
                                                        } else {
                                                          await FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'SimpanKos')
                                                              .doc(
                                                                  simpanKosDocId)
                                                              .delete();
                                                        }

                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection('Kos')
                                                            .doc(kost.kosId)
                                                            .update({
                                                          // ignore: unnecessary_brace_in_string_interps
                                                          'isFavorite_${userId}':
                                                              kost.isFavorite
                                                        });
                                                      } else {
                                                        // ignore: avoid_print
                                                        print(
                                                            'Pengguna tidak login');
                                                      }
                                                    },
                                                    child: Row(
                                                      children: [
                                                        const SizedBox(
                                                            width: 5),
                                                        Image.asset(
                                                          'lib/icons/simpan_active.png',
                                                          color: isKostSaved
                                                              ? const Color
                                                                  .fromRGBO(100,
                                                                  204, 197, 1)
                                                              : Colors.grey,
                                                          width: 30,
                                                          height: 30,
                                                          errorBuilder:
                                                              (context, error,
                                                                  stackTrace) {
                                                            return const Icon(
                                                                Icons.error,
                                                                color:
                                                                    Colors.red);
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                }
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          )),
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
                    MaterialPageRoute(builder: (context) => Home()),
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
        ));
  }

  // Fungsi untuk mengonversi jarak
  String formatJarak(int jarak) {
    if (jarak >= 1000) {
      double km = jarak / 1000.0;
      return '${km.toStringAsFixed(1)} km';
    } else {
      return '$jarak meter';
    }
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
}

// Class Filter Dialog dibuat stateful
class FilterDialog extends StatefulWidget {
  final Function(
    bool isChecked100Meters,
    bool isChecked200Meters,
    bool isChecked500Meters,
    bool isChecked1KM,
    bool isCheckedLebih1KM,
    double sliderValue,
  ) applyFilters;

  // ignore: use_super_parameters, prefer_const_constructors_in_immutables
  FilterDialog({required this.applyFilters, Key? key}) : super(key: key);

  @override
  _FilterDialogState createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  double _currentSliderValue = 0.0;
  bool isChecked100Meters = false;
  bool isChecked200Meters = false;
  bool isChecked500Meters = false;
  bool isChecked1KM = false;
  bool isCheckedLebih1KM = false;

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
                TextButton(
                  onPressed: () {
                    widget.applyFilters(
                      isChecked100Meters,
                      isChecked200Meters,
                      isChecked500Meters,
                      isChecked1KM,
                      isCheckedLebih1KM,
                      _currentSliderValue,
                    );
                    Navigator.of(context)
                        .pop(); // Close the dialog after applying filters
                  },
                  child: Text(
                    'Terapkan',
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
}
