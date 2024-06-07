import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:inkostel/pages/carikos.dart';
import 'package:inkostel/pages/jualkos.dart';
import 'package:inkostel/pages/signin.dart';
import 'package:inkostel/pages/simpan.dart';
import 'package:inkostel/pages/tes.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});
  final double coverHeight = 170;
  final double profileSize = 110;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<User?>(
        future: _getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            User user = snapshot.data!;
            String name = user.displayName ?? 'User';
            String email = user.email ?? 'No Email';
            String userId = user.uid;
            String username = '@username'; // Set username sesuai kebutuhan Anda
            String number = '+62 - 8123 - 5643 - 8923';
            String description = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.';

            return Stack(
              children: [
                ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    buildTop(context),
                    buildBottom(name, username, number, email, userId, description),
                    const SizedBox(height: 100), // Membuat ruang kosong di bagian bawah untuk memberi tempat pada tombol back
                  ],
                ),
              ],
            );
          } else {
            // Jika pengguna belum masuk, arahkan ke halaman login
            return SignInScreen();
          }
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
          // Handle bottom navigation bar item tap here
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
                MaterialPageRoute(builder: (context) => const Tes()),
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
              'lib/icons/gear_active.png',
              height: 30,
            ),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  Future<User?> _getUserData() async {
    return FirebaseAuth.instance.currentUser;
  }

  Widget buildTop(BuildContext context) {
    final bottom = profileSize / 2;
    final top = coverHeight - profileSize / 2 - 30;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: bottom),
          child: buildCoverImage(),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: coverHeight / 2,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18.0),
                topRight: Radius.circular(18.0),
              ),
            ),
          ),
        ),
        Positioned(
          top: top,
          child: buildProfileImageWithShadow(context),
        ),
        Positioned(
          left: 10,
          top: 40,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                child: Image.asset(
                  'lib/icons/back.png',
                  color: const Color.fromRGBO(100, 204, 197, 1),
                  width: 20,
                  height: 20,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildCoverImage() => Container(
        color: Colors.grey,
        child: Image.asset(
          'images/gambar.png',
          fit: BoxFit.cover,
          width: double.infinity,
          height: coverHeight,
        ),
      );

  Widget buildProfileImageWithShadow(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: profileSize,
          height: profileSize,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              'images/profile.png',
              width: profileSize,
              height: profileSize,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: () {
              EditProfile(context); // Function to handle profile edit
            },
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                child: SvgPicture.asset(
                  "lib/icons/pen.svg",
                  width: 20,
                  height: 20,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildBottom(String name, String username, String number, String email, String userId, String description) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            name,
            style: GoogleFonts.getFont(
              'Poppins',
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF436850),
            ),
          ),
          Text(
            username,
            style: GoogleFonts.getFont(
              'Poppins',
              fontSize: 18,
              color: Colors.grey,
            ),
          ),
          Text(
            number,
            style: GoogleFonts.getFont(
              'Poppins',
              fontSize: 18,
              color: Colors.grey,
            ),
          ),
          Text(
            email,
            style: GoogleFonts.getFont(
              'Poppins',
              fontSize: 18,
              color: Colors.grey,
            ),
          ),
          // Text(
          //   'User ID: $userId',
          //   style: GoogleFonts.getFont(
          //     'Poppins',
          //     fontSize: 18,
          //     color: Colors.grey,
          //   ),
          // ),
          const SizedBox(height: 30),
          Text(
            description,
            style: GoogleFonts.getFont(
              'Poppins',
              fontSize: 18,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  void EditProfile(BuildContext context) {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;

    // Create TextEditingControllers with initial values
    TextEditingController nameController = TextEditingController(text: user?.displayName ?? 'User');
    TextEditingController numberController = TextEditingController(text: '+62 - 8123 - 5643 - 8923'.replaceAll('+62', ''));
    TextEditingController descriptionController = TextEditingController(text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.');

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Profil'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              OutlinedButton(
                onPressed: () {
                  showImageSourceDialog(context);
                },
                child: Text(
                  'Ubah Gambar Profil',
                  style: TextStyle(
                    color: Color.fromARGB(255, 76, 165, 175), // Warna teks hijau
                  ),
                ),
                style: ButtonStyle(
                  side: MaterialStateProperty.resolveWith<BorderSide>((states) {
                    // Menetapkan ketebalan outline dan warna abu-abu
                    return BorderSide(color: Colors.grey, width: 1);
                  }),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama',
                  labelStyle: TextStyle(color: Color.fromARGB(255, 76, 165, 175)), // Warna teks hijau
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: numberController,
                decoration: const InputDecoration(
                  labelText: 'Nomor',
                  // Tambahkan teks +62 secara otomatis sebagai prefix
                  prefixText: '+62 ',
                  labelStyle: TextStyle(color: Color.fromARGB(255, 76, 165, 175)), 
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Deskripsi',
                  labelStyle: TextStyle(color: Color.fromARGB(255, 76, 165, 175)), // Warna teks hijau
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Batal',
                style: TextStyle(
                  color: Color.fromARGB(255, 76, 165, 175), // Warna teks hijau
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                String newName = nameController.text;
                String newNumber = '+62' + numberController.text; // Gabungkan dengan prefix +62
                String newDescription = descriptionController.text;

                // Update user profile in Firebase Authentication
                await user?.updateDisplayName(newName);

                // Close the dialog
                Navigator.of(context).pop();
              },
              child: const Text(
                'Simpan',
                style: TextStyle(
                  color: Color.fromARGB(255, 76, 165, 175), // Warna teks hijau
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  //Method untuk menampilkan dialog pilihan sumber gambar
  void showImageSourceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pilih Sumber Gambar'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Galeri'),
                onTap: () {
                  Navigator.pop(context);
                  _getImageFromGallery(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Kamera'),
                onTap: () {
                  Navigator.pop(context);
                  _getImageFromCamera(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  //Method untuk mengambil gambar dari galeri
  void _getImageFromGallery(BuildContext context) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      File imageFile = File(pickedImage.path);
      //Menggunakan imageFile untuk menampilkan gambar atau menyimpannya
    }
  }

  //Method untuk mengambil gambar dari kamera
  void _getImageFromCamera(BuildContext context) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      File imageFile = File(pickedImage.path);
      //Menggunakan imageFile untuk menampilkan gambar atau menyimpannya
    }
  }
}
