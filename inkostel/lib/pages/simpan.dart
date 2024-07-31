// ignore_for_file: use_super_parameters, library_private_types_in_public_api, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inkostel/pages/Detailk.dart';
import 'package:inkostel/pages/carikos.dart';
import 'package:inkostel/pages/home.dart';
import 'package:inkostel/pages/jualkos.dart';
import 'package:inkostel/pages/settings.dart';

class Simpan extends StatefulWidget {
  const Simpan({Key? key}) : super(key: key);

  @override
  _SimpanState createState() => _SimpanState();
}

class _SimpanState extends State<Simpan> {
  List<DocumentSnapshot> _savedKosts = [];
  bool _isLoading = true;
  bool _isLoadingMore = false;
  final ScrollController _scrollController = ScrollController();
  final int _itemsPerPage = 10;
  DocumentSnapshot? _lastDocument;

  @override
  void initState() {
    super.initState();
    _fetchSavedKosts();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _fetchMoreSavedKosts();
      }
    });
  }

  Future<void> _fetchSavedKosts() async {
    setState(() {
      _isLoading = true;
    });

    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('SimpanKos')
          .where('User ID', isEqualTo: user.uid)
          .limit(_itemsPerPage)
          .get();

      setState(() {
        _savedKosts = querySnapshot.docs;
        _isLoading = false;
        if (_savedKosts.isNotEmpty) {
          _lastDocument = _savedKosts.last;
        }
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      print('User not logged in');
    }
  }

  Future<void> _fetchMoreSavedKosts() async {
    if (_isLoadingMore || _lastDocument == null) return;

    setState(() {
      _isLoadingMore = true;
    });

    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('SimpanKos')
          .where('User ID', isEqualTo: user.uid)
          .startAfterDocument(_lastDocument!)
          .limit(_itemsPerPage)
          .get();

      setState(() {
        _savedKosts.addAll(querySnapshot.docs);
        _isLoadingMore = false;
        if (querySnapshot.docs.isNotEmpty) {
          _lastDocument = querySnapshot.docs.last;
        }
      });
    } else {
      setState(() {
        _isLoadingMore = false;
      });
      print('User not logged in');
    }
  }

  Future<void> _removeFromSaved(String documentId, String kosId) async {
    await FirebaseFirestore.instance
        .collection('SimpanKos')
        .doc(documentId)
        .delete();

    await FirebaseFirestore.instance
        .collection('Kos')
        .doc(kosId)
        .update({'isFavorite': false});
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(253, 252, 248, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(253, 252, 248, 1),
        toolbarHeight: 65,
        automaticallyImplyLeading: false,
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
      body: Column(
        children: [
          const SizedBox(height: 10),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    controller: _scrollController,
                    itemCount: _savedKosts.length + 1,
                    itemBuilder: (context, index) {
                      if (index == _savedKosts.length) {
                        return _isLoadingMore
                            ? const Center(child: CircularProgressIndicator())
                            : Container();
                      }
                      final DocumentSnapshot kostDoc = _savedKosts[index];
                      final Map<String, dynamic> kostData = kostDoc.data() as Map<String, dynamic>;

                      final List<String> imageUrls = List<String>.from(kostData['ImageURLs'] ?? []);
                      final int price = int.tryParse(kostData['Harga Pertahun'].toString()) ?? 0;
                      final String name = kostData['Nama Kos'] ?? '';
                      final int distance = int.tryParse(kostData['Jarak'].toString()) ?? 0;
                      final bool isFavorite = kostData['isFavorite'] ?? false;
                      final String kosId = kostData['Kos ID'] ?? '';

                      return _buildListItem(
                        imagePath: imageUrls.isNotEmpty ? imageUrls[0] : '',
                        price: price,
                        name: name,
                        distance: formatJarak(distance),
                        isFavorite: isFavorite,
                        documentId: kostDoc.id,
                        kosId: kosId,
                        onTapFavorite: () async {
                          setState(() {
                            kostData['isFavorite'] = !kostData['isFavorite'];
                          });

                          // Update favorit status di Firestore
                          await FirebaseFirestore.instance
                              .collection('SimpanKos')
                              .doc(kostDoc.id)
                              .update({'isFavorite': kostData['isFavorite']});

                          // Update status isFavorite di tabel Kos menjadi false
                          final user = FirebaseAuth.instance.currentUser;
                          if (user != null) {
                            await FirebaseFirestore.instance
                                .collection('Kos')
                                .doc(kosId)
                                .update({'isFavorite': kostData['isFavorite']});
                          }

                          // Hapus item dari daftar jika tidak lagi ditandai sebagai favorit
                          if (!kostData['isFavorite']) {
                            // Hapus data dari Firestore
                            await FirebaseFirestore.instance
                                .collection('SimpanKos')
                                .doc(kostDoc.id)
                                .delete();

                            setState(() {
                              _savedKosts.removeAt(index);
                            });
                          }
                        },
                      );
                    },
                  ),
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
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CariKos(searchText: '',)),
          );
        },
      ),
    );
  }

  Widget _buildListItem({
    required String imagePath,
    required int price,
    required String name,
    required String distance,
    required bool isFavorite,
    required String documentId,
    required String kosId,
    required VoidCallback onTapFavorite,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Detail(kosId: kosId),
          ),
        );
      },
      child: Container(
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
                  image: NetworkImage(imagePath),
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
                          distance,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 254, 254, 254),
                            fontSize: 17,
                          ),
                        ),
                        const SizedBox(width: 260),
                        GestureDetector(
                          onTap: onTapFavorite,
                          child: Image.asset(
                            'lib/icons/simpan_active.png',
                            color: isFavorite
                                ? const Color.fromRGBO(100, 204, 197, 1)
                                : Colors.white,
                            width: 30,
                            height: 30,
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
      ),
    );
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
        return 'Rp ${result.toInt()} k/bln';
      } else {
        return 'Rp ${result.toStringAsFixed(1)} k/bln';
      }
    } else {
      return 'Rp $amount';
    }
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
}
