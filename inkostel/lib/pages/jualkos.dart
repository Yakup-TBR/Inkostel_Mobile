import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inkostel/pages/home.dart';
import 'package:inkostel/pages/profile.dart';
import 'package:inkostel/pages/settings.dart';
import 'package:inkostel/pages/simpan.dart';
import 'package:inkostel/service/database.dart';
import 'package:inkostel/service/user_model.dart';
import 'package:random_string/random_string.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class JualKos extends StatefulWidget {
  const JualKos({super.key});

  @override
  State<JualKos> createState() => _JualKosState();
}

class _JualKosState extends State<JualKos> {
  // Text Editing Controller tiap textField
  TextEditingController namaKosController = TextEditingController();
  TextEditingController nomorTelponController = TextEditingController();
  TextEditingController alamatKos1Controller = TextEditingController();
  TextEditingController alamatlinkController = TextEditingController();
  TextEditingController hargaPertahunController = TextEditingController();
  TextEditingController hargaPerbulanController = TextEditingController();
  TextEditingController deskripsiController = TextEditingController();
  TextEditingController JarakController = TextEditingController();
  UserProfile? userProfile;

  void initState() {
    super.initState();
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
      print("Error fetching user profile: $e");
    }
  }

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

  List<File> _imageFiles = [];

  // Function to handle selecting an image from the gallery or camera
  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    setState(() {
      if (pickedFile != null) {
        if (_imageFiles.length < 6) {
          _imageFiles.add(File(pickedFile.path));
        } else {
          Fluttertoast.showToast(
            msg: "You can only upload up to 6 images",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );
        }
      }
    });
  }

  Future<String> uploadImageToFirebase(String imagePath, String imageName) async {
    try {
      File imageFile = File(imagePath);
      Reference storageRef = FirebaseStorage.instance.ref().child('images/$imageName');
      UploadTask uploadTask = storageRef.putFile(imageFile);
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> _uploadImagesAndSaveUrls(List<File> imageFiles) async {
    List<String> imageUrls = [];
    for (int i = 0; i < imageFiles.length; i++) {
      String imageName = 'kost_image_${DateTime.now().millisecondsSinceEpoch}_$i.jpg';
      String downloadUrl = await uploadImageToFirebase(imageFiles[i].path, imageName);
      imageUrls.add(downloadUrl);
    }

    // Simpan URL gambar ke Firestore
    for (String url in imageUrls) {
      await FirebaseFirestore.instance.collection('images').add({
        'url': url,
        'uploaded_at': Timestamp.now(),
      });
    }
    Fluttertoast.showToast(
      msg: "Images uploaded and URLs saved successfully!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );
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
                          color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
                          spreadRadius: 0,
                          blurRadius: 4,
                          offset: const Offset(0, 1), // Atur posisi shadow
                        ),
                      ],
                      image: userProfile != null && userProfile!.photoURL.isNotEmpty
                          ? DecorationImage(
                              image: NetworkImage(userProfile!.photoURL),
                              fit: BoxFit.cover,
                              onError: (exception, stackTrace) {
                                // Handle the error, for example by showing a default image
                                DecorationImage(
                                  image: AssetImage('lib/icons/orang.png'),
                                  fit: BoxFit.cover,
                                  colorFilter: ColorFilter.mode(
                                      const Color.fromRGBO(100, 204, 197, 1),
                                      BlendMode.srcATop),
                                );
                              },
                            )
                          : DecorationImage(
                              image: AssetImage('lib/icons/orang.png'),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                  const Color.fromRGBO(100, 204, 197, 1),
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
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        );
                      } else {
                        return Text(
                          '',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        );
                      }
                    },
                  ),
                )
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
                  constraints: const BoxConstraints(minWidth: 150, maxWidth: 330),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 209, 205, 205),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
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
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
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
                        TextFormField(
                          controller: JarakController,
                          // inputFormatters: [priceFormatter], // Apply formatter
                          keyboardType: TextInputType.number, // Set keyboard type
                          decoration: const InputDecoration(
                            labelText: 'Jarak dari Telkom University',
                          ),
                        ),
                        const SizedBox(height: 10),
                        // TextFormField for Harga with prefix icon
                        TextFormField(
                          controller: hargaPertahunController,
                          // inputFormatters: [priceFormatter], // Apply formatter
                          keyboardType: TextInputType.number, // Set keyboard type
                          decoration: const InputDecoration(
                            labelText: 'Harga Pertahun (Wajib diisi)',
                          ),
                        ),
                        TextFormField(
                          controller: hargaPerbulanController,
                          // inputFormatters: [priceFormatter], // Apply formatter
                          keyboardType: TextInputType.number, // Set keyboard type
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
                        // Add the description form field
                        TextFormField(
                          controller: deskripsiController,
                          decoration: const InputDecoration(
                            labelText: 'Deskripsi Kostan',
                          ),
                          maxLines: 2,
                        ),
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
                                _showImagePicker(); // Panggil fungsi untuk menampilkan pemilih gambar
                              },
                              child: Column(
                                children: [
                                  if (_imageFiles.isEmpty)
                                    const Icon(Icons.add_a_photo)
                                  else
                                    GridView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 4.0,
                                        mainAxisSpacing: 4.0,
                                      ),
                                      itemCount: _imageFiles.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        return Stack(
                                          children: [
                                            Image.file(
                                              _imageFiles[index],
                                              fit: BoxFit.cover,
                                            ),
                                            Positioned(
                                              top: -10,
                                              right: -10,
                                              child: IconButton(
                                                icon: const Icon(Icons.cancel, color: Colors.red),
                                                onPressed: () {
                                                  setState(() {
                                                    _imageFiles.removeAt(index);
                                                  });
                                                },
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () async {
                            String Id = randomAlphaNumeric(8);

                            // Upload images to Firebase Storage
                            List<String> imageUrls = [];
                            for (int i = 0; i < _imageFiles.length; i++) {
                              String imageName = 'kost_image_${Id}_$i.jpg';
                              String imageUrl = await uploadImageToFirebase(_imageFiles[i].path, imageName);
                              imageUrls.add(imageUrl);
                            }

                            // Update kosDataMap with imageUrls
                            Map<String, dynamic> kosDataMap = {
                              "Kos ID": Id,
                              "Nama Kos": namaKosController.text,
                              "Nomor Telepon": "62" + nomorTelponController.text,
                              "Alamat Kos": alamatKos1Controller.text,
                              "Link Map": alamatlinkController.text,
                              "Harga Pertahun": int.tryParse(hargaPertahunController.text) ?? 0,
                              "Harga Perbulan": int.tryParse(hargaPerbulanController.text) ?? 0,
                              "Fasilitas": facilityValues,
                              "Deskripsi": deskripsiController.text,
                              "ImageURLs": imageUrls,
                              "Jarak": int.tryParse(JarakController.text) ?? 0,
                            };

                            // Tambahkan data kos ke Firebase Database
                            await DatabaseMethods().addKosDetails(kosDataMap, Id).then((value) {
                              Fluttertoast.showToast(
                                msg: "Berhasil Mengirim, Data Kos Anda Akan diverifikasi oleh Admin",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 3,
                                backgroundColor: const Color.fromARGB(255, 16, 173, 89),
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
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
                  MaterialPageRoute(builder: (context) =>  Home()),
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
              'lib/icons/plus_active.png',
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
