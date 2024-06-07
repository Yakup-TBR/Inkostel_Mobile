import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:inkostel/pages/carikos.dart';
import 'package:inkostel/pages/jualkos.dart';
import 'package:inkostel/pages/settings.dart';
import 'package:inkostel/pages/simpan.dart';
import 'package:inkostel/service/kost_model.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:inkostel/utils/format_currency.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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

    final Uri _url = Uri.parse(
        'https://www.google.com/maps/place/Universitas+Telkom/@-6.973007,107.6291105,17z/data=!3m1!4b1!4m6!3m5!1s0x2e68e9adf177bf8d:0x437398556f9fa03!8m2!3d-6.973007!4d107.6316854!16s%2Fm%2F0y6lbq_?entry=ttu');

    Future<void> _launchUrl() async {
      if (!await launchUrl(_url)) {
        throw Exception('Could not launch $_url');
      }
    }

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          double minHeight = constraints.maxHeight * 0.65;
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
                      CarouselSlider(
                        options: CarouselOptions(
                          height: 317,
                          viewportFraction: 2.0, // Full Page?
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
                        items: [
                          'images/kamar.png',
                          'images/hapid.jpg',
                          'images/contoh.jpg',
                        ].map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(i),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                      Positioned(
                        top: 55,
                        left: 20,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios_new,
                              size: 20,
                              color: Color.fromRGBO(100, 204, 197, 1),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 55,
                        right: 20,
                        child: GestureDetector(
                          onTap: () {},
                          onTapDown: (details) {
                            setState(() {
                              isSimpanPressed = !isSimpanPressed;
                            });
                          },
                          onTapCancel: () {
                            setState(() {
                              isSimpanPressed = !isSimpanPressed;
                            });
                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Image.asset(
                              'lib/icons/simpan.png',
                              color: isSimpanPressed
                                  ? Colors.blue
                                  : const Color.fromRGBO(128, 128, 128, 1),
                            ),
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
                          SizedBox(
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 50, left: 22.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _kos!.namaKost,
                                        style: const TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10, left: 22.0, right: 22.0),
                            child: GestureDetector(
                              onTap: _launchUrl,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.location_on,
                                        color: Color.fromRGBO(72, 255, 249, 1),
                                        size: 20,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        _kos!.alamatKos,
                                        style: const TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10, left: 25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                if (_kos?.fasilitas['AC'] == true)
                                  Row(
                                    children: [
                                      Icon(
                                        MdiIcons.airConditioner,
                                        color: Color.fromRGBO(72, 255, 249, 1),
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
                                              Color.fromRGBO(72, 255, 249, 1),
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
                                        color: Color.fromRGBO(72, 255, 249, 1),
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
                                              Color.fromRGBO(72, 255, 249, 1),
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
                                        color: Color.fromRGBO(72, 255, 249, 1),
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
                                              Color.fromRGBO(72, 255, 249, 1),
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
                                        color: Color.fromRGBO(72, 255, 249, 1),
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
                                              Color.fromRGBO(72, 255, 249, 1),
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
                                        color: Color.fromRGBO(72, 255, 249, 1),
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
                                              Color.fromRGBO(72, 255, 249, 1),
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
                                    fontSize: 25,
                                    fontWeight: FontWeight.normal,
                                    color: Color.fromRGBO(67, 104, 80, 1),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  _kos!.deskripsi,
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey,
                                  ),
                                  maxLines: null,
                                  overflow: TextOverflow.clip,
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
                                    fontSize: 20,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  formatCurrency(_kos!.hargaPertahun),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
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
                                    const Color.fromARGB(255, 71, 228, 243),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.phone,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    'whatsapp',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ],
                              ),
                              onPressed: _launchwa,
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
                MaterialPageRoute(builder: (context) => const CariKos()),
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
