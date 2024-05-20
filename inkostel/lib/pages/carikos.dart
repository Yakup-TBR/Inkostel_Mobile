import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inkostel/notification_controller.dart';
import 'package:inkostel/pages/detail.dart';
import 'package:inkostel/pages/home.dart';
import 'package:inkostel/pages/jualkos.dart';
import 'package:inkostel/pages/profile.dart';
import 'package:inkostel/pages/settings.dart';
import 'package:inkostel/pages/simpan.dart';
import 'package:inkostel/pages/tes.dart';
import 'package:random_string/random_string.dart';
import 'package:inkostel/service/image_service.dart';
// import 'package:inkostel/main.dart';
import 'package:inkostel/service/kost_model.dart';

void main() {
  runApp(const CariKos());
}

class CariKos extends StatefulWidget {
  const CariKos({super.key});

  static Future<List<Kost>> fetchData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("Kos") // Ganti dengan nama koleksi yang sesuai
        .get();
    return querySnapshot.docs.map((doc) => Kost.fromFirestore(doc)).toList();
  }

  @override
  // ignore: library_private_types_in_public_api
  _CariKosState createState() => _CariKosState();
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

class _CariKosState extends State<CariKos> {
  // Untuk Lazy load
  int _batchSize = 3;
  int _currentBatch = 0;
  ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false;

  List<Kost> _kostList = [];
  bool _isLoading = true;

  Future<void> _fetchData({bool loadMore = false}) async {
    setState(() {
      if (loadMore)
        _isLoadingMore = true;
      else
        _isLoading = true;
    });

    List<Kost> fetchedKostList = await CariKos.fetchData();
    setState(() {
      if (loadMore) {
        _kostList.addAll(fetchedKostList
            .skip(_currentBatch * _batchSize)
            .take(_batchSize)
            .toList());
        _isLoadingMore = false;
      } else {
        _kostList = fetchedKostList.take(_batchSize).toList();
        _isLoading = false;
      }
      _currentBatch++;
    });
  }

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
    _fetchData();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          !_isLoadingMore) {
        _fetchData(loadMore: true);
      }
    });
  }

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
                child: GestureDetector(
                  onTap: () {
                    // Tambahkan kode navigasi ke halaman profil di sini
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Profile()),
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
                    padding: const EdgeInsets.only(left: 22),
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
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const FilterDialog();
                        },
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
                child: _kostList.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        controller: _scrollController,
                        itemCount: _kostList.length + 1,
                        itemBuilder: (context, index) {
                          if (index == _kostList.length) {
                            return _isLoadingMore
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : Container();
                          }
                          final Kost kost = _kostList[index];
                          return Container(
                            width: double.infinity,
                            margin: const EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 255, 255),
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
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            image: DecorationImage(
                                              image:
                                                  NetworkImage(kost.imageUrl),
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
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              width: 1,
                                            ),
                                          ),
                                          child: Text(
                                            kost.hargaPertahun,
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
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 10,
                                        left: 10,
                                        child: GestureDetector(
                                          onTap: () async {
                                            setState(() {
                                              kost.toggleFavoriteStatus();
                                              if (kost.isFavorite) {
                                                AwesomeNotifications()
                                                    .createNotification(
                                                  content: NotificationContent(
                                                    id: 1,
                                                    channelKey: 'notif_simpan',
                                                    title:
                                                        'Kos ${kost.namaKost} telah Disimpan!',
                                                    body: 'Ketuk untuk melihat',
                                                  ),
                                                );
                                              }
                                            });

                                            // Update status favorit di Firestore
                                            await FirebaseFirestore.instance
                                                .collection('Kos')
                                                .doc(kost.kosId)
                                                .update(kost.toFirestore());
                                          },
                                          child: Row(
                                            children: [
                                              const SizedBox(width: 5),
                                              Image.asset(
                                                'lib/icons/simpan_active.png',
                                                color: kost.isFavorite
                                                    ? const Color.fromRGBO(
                                                        100, 204, 197, 1)
                                                    : Colors.grey,
                                                width: 30,
                                                height: 30,
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return const Icon(Icons.error,
                                                      color: Colors.red);
                                                },
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
      return '$distance meter';
    }
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
