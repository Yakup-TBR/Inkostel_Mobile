import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:inkostel/pages/carikos.dart';
import 'package:inkostel/pages/home.dart';
import 'package:inkostel/pages/jualkos.dart';
import 'package:inkostel/pages/settings.dart';
import 'package:inkostel/pages/simpan.dart';
import 'package:inkostel/service/kost_model.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:inkostel/utils/format_currency.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:auto_size_text/auto_size_text.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Detail(kosId: 'kosId'),
    );
  }
}

class Detail extends StatefulWidget {
  final String kosId;

  const Detail({required this.kosId, Key? key}) : super(key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  Kost? _kos;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchKost();
  }

  Future<void> _fetchKost() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('Kos')
        .doc(widget.kosId)
        .get();
    setState(() {
      _kos = Kost.fromFirestore(snapshot);
      _isLoading = false;
    });
  }

  Future<void> _reloadKost() async {
    setState(() {
      _isLoading = true;
    });
    await _fetchKost();
  }

  bool _showPerYear = true;

  void _togglePriceType() {
    setState(() {
      _showPerYear = !_showPerYear;
    });
  }

  bool isSimpanPressed = false;
  final PanelController _panelController = PanelController();

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text('Loading...')),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final Uri _wa = Uri.parse('https://wa.me/${_kos?.noWA}');
    Future<void> _launchwa() async {
      if (!await launchUrl(_wa)) {
        throw Exception('Could not launch $_wa');
      }
    }

    Future<void> _launchUrl() async {
      if (_kos?.urlMap == null || _kos!.urlMap.isEmpty) {
        // Menonaktifkan tombol jika URL kosong
        return;
      }

      final Uri _url = Uri.parse(_kos!.urlMap);

      if (!await canLaunch(_url.toString())) {
        throw Exception('Could not launch $_url');
      } else {
        await launch(_url.toString());
      }
    }

    String hargaPertahun(int amount) {
      if (amount >= 1000000) {
        double result = amount / 1000000;
        if (result % 1 == 0) {
          return 'Rp ${result.toInt()} jt/thn';
        } else {
          return 'Rp ${result.toStringAsFixed(1)} jt/thn';
        }
      } else {
        // Mengembalikan string dengan format 'Rp {amount} ribu/thn' jika amount kurang dari 1 juta
        double result = amount / 1000;
        return 'Rp ${result.toInt()} ribu/thn';
      }
    }

    String formatJarak(int jarak) {
      if (jarak >= 1000) {
        double km = jarak / 1000.0;
        return '${km.toStringAsFixed(1)} km';
      } else {
        return '$jarak m';
      }
    }

    String hargaPerbulan(int amount) {
      if (amount >= 1000) {
        double result = amount / 1000;
        if (result % 1 == 0) {
          return 'Rp ${result.toInt()} k/bln';
        } else {
          return 'Rp ${result.toStringAsFixed(1)} ribu/bln';
        }
      } else {
        // Mengembalikan string dengan format 'Rp {amount} ribu/bln' jika amount kurang dari 1000
        return 'Rp $amount ribu/bln';
      }
    }

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          double minHeight = constraints.maxHeight * 0.628;
          double maxHeight = constraints.maxHeight * 0.8;

          return SizedBox(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: Stack(
              children: [
                Positioned(
                  width: constraints.maxWidth,
                  height: 317,
                  child: Stack(
                    alignment: Alignment.topLeft,
                    children: [
                      CarouselSlider.builder(
                        options: CarouselOptions(
                          height: 317,
                          viewportFraction: 1.0,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          scrollDirection: Axis.horizontal,
                        ),
                        itemCount: _kos!.imageUrl
                            .length, // Menggunakan imageUrls dari objek _kos
                        itemBuilder:
                            (BuildContext context, int index, int realIndex) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 0),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(_kos!.imageUrl[
                                    index]), // Menggunakan imageUrls dari objek _kos
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      ),
                      Positioned(
                        top: 55,
                        left: 20,
                        width: 40, // atur lebar
                        height: 40, // atur tinggi
                        child: GestureDetector(
                          onTap: () {
                            // Tambahkan kode navigasi ke halaman profil di sini
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>  CariKos(searchText: '',)),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(254, 251, 246, 1),
                              borderRadius: BorderRadius.circular(18),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  spreadRadius: 0,
                                  blurRadius: 4,
                                  offset:
                                      const Offset(0, 1), // Atur posisi shadow
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                'lib/icons/back.png',
                                color: const Color.fromRGBO(100, 204, 197, 1),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 55,
                        right: 20,
                        child: GestureDetector(
                          onTap: () async {
                            final user = FirebaseAuth.instance.currentUser;
                            if (user != null) {
                              final userId = user.uid;

                              setState(() {
                                _kos?.toggleFavoriteStatus();
                                if (_kos!.isFavorite) {
                                  AwesomeNotifications().createNotification(
                                    content: NotificationContent(
                                      id: 1,
                                      channelKey: 'notif_simpan',
                                      title:
                                          'Kos ${_kos?.namaKost} telah Disimpan!',
                                      body: 'Ketuk untuk melihat',
                                    ),
                                  );
                                }
                              });

                              // Perbarui status favorit di Firestore
                              await FirebaseFirestore.instance
                                  .collection('Kos')
                                  .doc(_kos?.kosId)
                                  .update(_kos!.toFirestore());

                              // Simpan detail Kost ke koleksi SimpanKos
                              final simpanKosDocId = '${userId}_${_kos?.kosId}';
                              if (_kos!.isFavorite) {
                                await FirebaseFirestore.instance
                                    .collection('SimpanKos')
                                    .doc(simpanKosDocId)
                                    .set({
                                  'Nama Kos': _kos?.namaKost,
                                  'Harga Pertahun': _kos?.hargaPertahun,
                                  'ImageURLs': _kos?.imageUrl,
                                  'Kos ID': _kos?.kosId,
                                  'User ID': userId,
                                  'Alamat Kos': _kos?.alamatKos,
                                  'Jarak': _kos?.jarakKost,
                                  'isFavorite': _kos?.isFavorite,
                                });
                              } else {
                                await FirebaseFirestore.instance
                                    .collection('SimpanKos')
                                    .doc(simpanKosDocId)
                                    .delete();
                              }

                              // Update status isFavorite di tabel Kos
                              await FirebaseFirestore.instance
                                  .collection('Kos')
                                  .doc(_kos?.kosId)
                                  .update(
                                      {'isFavorite_$userId': _kos?.isFavorite});
                            } else {
                              // Tangani kasus ketika pengguna tidak login
                              print('Pengguna tidak login');
                            }
                          },
                          child: Row(
                            children: [
                              const SizedBox(width: 5),
                              Image.asset(
                                'lib/icons/simpan_active.png',
                                color: _kos!.isFavorite
                                    ? const Color.fromRGBO(100, 204, 197, 1)
                                    : Colors.grey,
                                width: 30,
                                height: 30,
                                errorBuilder: (context, error, stackTrace) {
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
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: SlidingUpPanel(
                    minHeight: minHeight,
                    maxHeight: maxHeight,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(24.0)),
                    renderPanelSheet: false,
                    panel: Container(
                      width: 360,
                      height: 400,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(24.0)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex:
                                    3, // Misalnya, memberikan lebih banyak fleksibilitas kepada Expanded ini
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 50, left: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Menghapus Expanded di dalam Column karena tidak diperlukan
                                      Text(
                                        _kos!.namaKost,
                                        style: const TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(255, 0, 0, 0),
                                        ),
                                        textAlign: TextAlign.left,
                                        // Hapus atau set maxLines ke null untuk membiarkan teks meluas ke beberapa baris
                                        maxLines: null,
                                        overflow: TextOverflow
                                            .visible, // Atur overflow menjadi visible
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 50, right: 15.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Jarak :',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 25,
                                        color: Color.fromARGB(255, 7, 4, 4),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      formatJarak(_kos!.jarakKost),
                                      style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 25,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, left: 19),
                            child: GestureDetector(
                              onTap: _launchUrl,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    color: Color.fromRGBO(100, 204, 197, 1),
                                    size: 20,
                                  ),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    // Tambahkan Expanded di sekitar AutoSizeText
                                    child: AutoSizeText(
                                      _kos!.alamatKos,
                                      style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.grey,
                                      ),
                                      textAlign: TextAlign.left,
                                      // Hapus atau set maxLines ke null untuk membiarkan teks meluas ke beberapa baris
                                      overflow: TextOverflow
                                          .visible, // Atur overflow menjadi visible
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10, left: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                if (_kos?.fasilitas['AC'] == true)
                                  Row(
                                    children: [
                                      Icon(
                                        MdiIcons.airConditioner,
                                        color: Color.fromRGBO(100, 204, 197, 1),
                                        size: 20,
                                      ),
                                      const SizedBox(width: 1),
                                      const Text(
                                        'AC',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromRGBO(100, 204, 197, 1),
                                        ),
                                      ),
                                    ],
                                  ),
                                const SizedBox(width: 5),
                                if (_kos?.fasilitas['WiFi'] == true)
                                  Row(
                                    children: [
                                      Icon(
                                        MdiIcons.wifi,
                                        color: Color.fromRGBO(100, 204, 197, 1),
                                        size: 20,
                                      ),
                                      SizedBox(width: 1),
                                      const Text(
                                        'WIFI',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromRGBO(100, 204, 197, 1),
                                        ),
                                      ),
                                    ],
                                  ),
                                const SizedBox(width: 5),
                                if (_kos?.fasilitas['Kulkas'] == true)
                                  Row(
                                    children: [
                                      Icon(
                                        MdiIcons.fridgeOutline,
                                        color: Color.fromRGBO(100, 204, 197, 1),
                                        size: 20,
                                      ),
                                      const SizedBox(width: 1),
                                      const Text(
                                        'Kulkas',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromRGBO(100, 204, 197, 1),
                                        ),
                                      ),
                                    ],
                                  ),
                                SizedBox(width: 5),
                                if (_kos?.fasilitas['Tempat Parkir'] == true)
                                  Row(
                                    children: [
                                      Icon(
                                        MdiIcons.parking,
                                        color: const Color.fromRGBO(
                                            100, 204, 197, 1),
                                        size: 20,
                                      ),
                                      const SizedBox(width: 1),
                                      const Text(
                                        'Parkir',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromRGBO(100, 204, 197, 1),
                                        ),
                                      ),
                                    ],
                                  ),
                                const SizedBox(width: 1),
                                if (_kos?.fasilitas['Kamar Mandi Dalam'] ==
                                    true)
                                  Row(
                                    children: [
                                      Icon(
                                        MdiIcons.toilet,
                                        color: Color.fromRGBO(100, 204, 197, 1),
                                        size: 20,
                                      ),
                                      const SizedBox(width: 1),
                                      const Text(
                                        'Kamar mandi',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromRGBO(100, 204, 197, 1),
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20, left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Deskripsi',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 30,
                                    fontWeight: FontWeight.normal,
                                    color: Color.fromRGBO(0, 0, 0, 1),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    _kos?.deskripsi ?? '',
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey,
                                    ),
                                    textAlign: TextAlign.left,
                                    maxLines: null,
                                    overflow: TextOverflow.clip,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(bottom: 15.0, left: 30),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Harga Sewa:',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 25,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                const SizedBox(height: 5),
                                GestureDetector(
                                  onTap: _togglePriceType,
                                  child: Text(
                                    _showPerYear
                                        ? hargaPertahun(_kos!.hargaPertahun)
                                        : hargaPerbulan(_kos!.hargaPerbulan),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(bottom: 20.0, right: 30),
                          child: Align(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(30, 50),
                                backgroundColor:
                                    const Color.fromRGBO(100, 204, 197, 1),
                              ),
                              onPressed: _launchwa,
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.phone,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    'whatsapp',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
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
                MaterialPageRoute(builder: (context) =>  Home()),
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
                MaterialPageRoute(builder: (context) => const Pengaturan()),
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
    );
  }
}
