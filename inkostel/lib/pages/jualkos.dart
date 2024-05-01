import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart'; // Import intl package
import 'package:inkostel/pages/home.dart';
import 'package:inkostel/pages/settings.dart';
import 'package:inkostel/pages/simpan.dart';
import 'package:inkostel/pages/profile.dart';

void main() {
  runApp(const JualKos());
}

class JualKos extends StatefulWidget {
  const JualKos({Key? key}) : super(key: key);

  @override
  State<JualKos> createState() => _JualKosState();
}

class _JualKosState extends State<JualKos> {
  // Define a list of facilities
  List<String> facilities = [
    'AC',
    'WiFi',
    'Kulkas',
    'Tempat Parkir',
    'Kamar Mandi Dalam'
  ];

  // Maintain the state of each checkbox
  Map<String, bool> facilityValues = {
    'AC': false,
    'WiFi': false,
    'Kulkas': false,
    'Tempat Parkir': false,
    'Kamar Mandi Dalam': false,
  };

  // Formatter for price text field
  final priceFormatter = NumberTextInputFormatter();
  File? _imageFile;

  // Function to handle selecting an image from the gallery
  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromRGBO(253, 252, 248, 1),
        appBar: AppBar(
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
                        MaterialPageRoute(builder: (context) => Profile()),
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                Container(
                  // ---------Pop up Gagal Login
                  constraints:
                      const BoxConstraints(minWidth: 150, maxWidth: 330),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 209, 205, 205),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color:
                            const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
                        spreadRadius: 0,
                        blurRadius: 4,
                        offset: const Offset(0, 1), // Atur posisi shadow
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 20, left: 24, right: 24, bottom: 35),
                    child: Column(
                      children: [
                        Text('Daftarkan kostan Anda sekarang!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 20),
                        // TextFormField for Nama Kostan with prefix icon
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Nama Kostan',
                          ),
                        ),
                        const SizedBox(height: 10),
                        // TextFormField for Nomor Telepon with prefix text
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Nomor Telepon',
                            prefixText: '+62 ', // Add the prefix text
                          ),
                        ),
                        const SizedBox(height: 10),
                        // TextFormField for Alamat with prefix icon
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Alamat',
                          ),
                        ),
                        const SizedBox(height: 10),
                        // TextFormField for Harga with prefix icon
                        TextFormField(
                          inputFormatters: [priceFormatter], // Apply formatter
                          keyboardType: TextInputType.number, // Set keyboard type
                          decoration: const InputDecoration(
                            labelText: 'Harga',
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Add the title "Fasilitas"
                        Text(
                          'Fasilitas',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Add facility checkboxes
                        ...facilities.map((facility) => CheckboxListTile(
                          title: Text(facility),
                          value: facilityValues[facility],
                          onChanged: (newValue) {
                            setState(() {
                              facilityValues[facility] = newValue!;
                            });
                          },
                        )),
                        const SizedBox(height: 10),
                        // Add ImagePicker
                        Column(
                          children: [
                            const Text(
                              'Tambah Tampilan Kost',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SafeArea(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          ListTile(
                                            leading: const Icon(Icons.photo_library),
                                            title: const Text('Choose from gallery'),
                                            onTap: () {
                                              _pickImage(ImageSource.gallery);
                                              Navigator.pop(context);
                                            },
                                          ),
                                          ListTile(
                                            leading: const Icon(Icons.photo_camera),
                                            title: const Text('Take a picture'),
                                            onTap: () {
                                              _pickImage(ImageSource.camera);
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              child: _imageFile == null
                                  ? Icon(Icons.add_a_photo)
                                  : Image.file(_imageFile!),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            // Action when submit button is pressed
                          },
                          child: const Text('Submit'),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  // Isi
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 230, 71, 71)),
                ),
              ],
            ),
          ),
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
                // Navigasi ke halaman Save
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Simpan()),
                );
                break;
              case 2:
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
}

// Custom TextInputFormatter for formatting price
class NumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final regEx = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    String newString = newValue.text.replaceAll(regEx, r'$1.');
    return TextEditingValue(
      text: 'Rp. ${NumberFormat('#,###').format(int.parse(newString))}', // Format the number
      selection: TextSelection.collapsed(offset: newString.length + 4),
    );
  }
}
