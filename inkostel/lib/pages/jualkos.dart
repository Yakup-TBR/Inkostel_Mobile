import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inkostel/service/database.dart';
import 'package:intl/intl.dart'; // Import intl package
import 'package:inkostel/pages/home.dart';
import 'package:inkostel/pages/settings.dart';
import 'package:inkostel/pages/simpan.dart';
import 'package:inkostel/pages/profile.dart';
import 'package:random_string/random_string.dart';
import 'package:inkostel/service/image_service.dart';

void main() {
  runApp(const JualKos());
}

class JualKos extends StatefulWidget {
  const JualKos({super.key});

  @override
  State<JualKos> createState() => _JualKosState();
}

class _JualKosState extends State<JualKos> {
  Future<void> _saveImageLocally(File imageFile) async {
    final imagePath = await saveImageLocally(imageFile);
    print('Image saved locally at $imagePath');
  }

  Future<void> _uploadImageToFirebase(String imagePath) async {
    final String imageName = 'kost_image.jpg'; // Nama gambar yang akan diunggah
    final imageUrl = await uploadImageToFirebase(imagePath, imageName);
    print('Image uploaded to Firebase. URL: $imageUrl');
    // Di sini Anda dapat melakukan apa pun yang Anda inginkan dengan URL gambar, misalnya menyimpannya di database Firebase
  }

  // Text Editing Controller tiap textField
  TextEditingController namaKosController = new TextEditingController();
  TextEditingController nomorTelponController = new TextEditingController();
  TextEditingController alamatKos1Controller = new TextEditingController();
  TextEditingController alamatlinkController = new TextEditingController();
  TextEditingController hargaPertahunController = new TextEditingController();
  TextEditingController hargaPerbulanController = new TextEditingController();

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

  // Variable to store selected distance
  String? selectedDistance;

  // Formatter for price text field
  // final priceFormatter = NumberTextInputFormatter();
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
                const Padding(
                  padding: EdgeInsets.only(left: 20),
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
                        const Text('Daftarkan kostan Anda sekarang!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 20),
                        // TextFormField for Nama Kostan with prefix icon
                        TextFormField(
                          controller: namaKosController,
                          decoration: const InputDecoration(
                            labelText: 'Nama Kostan',
                          ),
                        ),
                        const SizedBox(height: 10),
                        // TextFormField for Nomor Telepon with prefix text
                        TextFormField(
                          controller: nomorTelponController,
                          decoration: const InputDecoration(
                            labelText: 'Nomor Telepon',
                            prefixText: '+62 ', // Add the prefix text
                          ),
                        ),
                        const SizedBox(height: 10),
                        // TextFormField for Alamat with prefix icon
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: alamatKos1Controller,
                                decoration: const InputDecoration(
                                  labelText: 'Alamat',
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextFormField(
                                controller: alamatlinkController,
                                decoration: const InputDecoration(
                                  labelText: 'Link Map',
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        // Dropdown for Jarak
                        DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: 'Jarak',
                          ),
                          value: selectedDistance,
                          items: const [
                            DropdownMenuItem(
                              value: '100-500 M',
                              child: Text('100-500 M'),
                            ),
                            DropdownMenuItem(
                              value: '500-1000 M',
                              child: Text('500-1000 M'),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              selectedDistance = value;
                            });
                          },
                        ),
                        const SizedBox(height: 10),
                        // TextFormField for Harga with prefix icon
                        TextFormField(
                          controller: hargaPertahunController,
                          // inputFormatters: [priceFormatter], // Apply formatter
                          keyboardType:
                              TextInputType.number, // Set keyboard type
                          decoration: const InputDecoration(
                            labelText: 'Harga Pertahun (Wajib diisi)',
                          ),
                        ),
                        TextFormField(
                          controller: hargaPerbulanController,
                          // inputFormatters: [priceFormatter], // Apply formatter
                          keyboardType:
                              TextInputType.number, // Set keyboard type
                          decoration: const InputDecoration(
                            labelText: 'Harga Perbulan (Opsional)',
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Add the title "Fasilitas"
                        const Text(
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
                            const SizedBox(height: 10),
                            GestureDetector(
                              onTap: _showImagePicker,
                              child: Container(
                                color: Colors.grey[200],
                                height: 200,
                                width: double.infinity,
                                child: _imageFile != null
                                    ? Image.file(_imageFile!,
                                        fit: BoxFit.cover)
                                    : const Icon(Icons.camera_alt,
                                        color: Colors.grey),
                              ),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () async {
                                if (_imageFile != null) {
                                  await _saveImageLocally(_imageFile!);
                                }
                              },
                              child: const Text('Save Image Locally'),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () async {
                                if (_imageFile != null) {
                                  await _uploadImageToFirebase(
                                      _imageFile!.path);
                                }
                              },
                              child: const Text('Upload Image to Firebase'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () async {
                            String Id = randomAlphaNumeric(8);

                            // Upload image to Firebase Storage
                            String imagePath =
                                _imageFile != null ? _imageFile!.path : '';
                            String imageUrl = '';
                            if (imagePath.isNotEmpty) {
                              imageUrl = await uploadImageToFirebase(
                                  imagePath, 'kost_image.jpg');
                            }

                            // Update kosDataMap with imageUrl
                            Map<String, dynamic> kosDataMap = {
                              "Kos ID": Id,
                              "Nama Kos": namaKosController.text,
                              "Nomor Telepon": nomorTelponController.text,
                              "Alamat Kos": alamatKos1Controller.text +
                                  ' ' +
                                  alamatlinkController.text,
                              "Harga Pertahun": hargaPertahunController.text,
                              "Harga Perbulan": hargaPerbulanController.text,
                              "Fasilitas": facilityValues,
                              "ImageURL": imageUrl,
                              "Jarak": selectedDistance,
                            };

                            // Tambahkan data kos ke Firebase Database
                            await DatabaseMethods()
                                .addKosDetails(kosDataMap, Id)
                                .then((value) {
                              Fluttertoast.showToast(
                                  msg:
                                      "Berhasil Mengirim, Data Kos Anda Akan diverifikasi oleh Admin",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 3,
                                  backgroundColor:
                                      Color.fromARGB(255, 16, 173, 89),
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            });
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

  // Fungsi di ikon kamera untuk ambil gambar
  // Function to show the image picker modal bottom sheet
  void _showImagePicker() {
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
  }
}
