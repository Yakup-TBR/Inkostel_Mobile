import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:inkostel/pages/carikos.dart';
import 'package:inkostel/pages/jualkos.dart';
import 'package:inkostel/pages/signin.dart';
import 'package:inkostel/pages/simpan.dart';
import 'package:inkostel/pages/tes.dart';
import 'package:inkostel/service/user_model.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final double coverHeight = 170;
  final double profileSize = 110;
  final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>(); // Tambahkan global key

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Gunakan global key pada Scaffold
      body: FutureBuilder<UserProfile?>(
        future: _getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const SignInScreen();
          } else {
            UserProfile user = snapshot.data!;
            String userName = user.nama.isNotEmpty ? user.nama : 'User';
            String userUsername =
                user.username.isNotEmpty ? user.username : 'username';
            String userPhone = user.nomorTelepon.isNotEmpty
                ? user.nomorTelepon
                : '+62 123456789';
            String userEmail =
                user.email.isNotEmpty ? user.email : 'user@example.com';
            String userDescription = user.deskripsi.isNotEmpty
                ? user.deskripsi
                : 'Deskripsi belum diisi';
            String userPhotoURL =
                user.photoURL.isNotEmpty ? user.photoURL : 'images/profile.png';

            return Stack(
              children: [
                ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    buildTop(context, userPhotoURL),
                    buildBottom(context, userName, userUsername, userPhone,
                        userEmail, userDescription),
                    const SizedBox(height: 100),
                  ],
                ),
              ],
            );
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

  Future<UserProfile?> _getUserData() async {
    if (FirebaseAuth.instance.currentUser != null) {
      await createUserProfileIfNotExists();
      var userProfile = await getUserProfile();
      if (userProfile != null) {
        return userProfile;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Widget buildTop(BuildContext context, String photoURL) {
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
          child: buildProfileImageWithShadow(context, photoURL),
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

  Widget buildProfileImageWithShadow(BuildContext context, String photoURL) {
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
            child: Image.network(
              photoURL,
              width: profileSize,
              height: profileSize,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  Image.asset('images/profile.png'),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: () {
              editProfile(context);
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

  Widget buildBottom(BuildContext context, String name, String username,
      String phone, String email, String description) {
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
            phone,
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

  void editProfile(BuildContext context) async {
    UserProfile? userProfile = await _getUserData();

    if (userProfile == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to fetch user data.')));
      }
      return;
    }

    TextEditingController nameController =
        TextEditingController(text: userProfile.nama);
    TextEditingController numberController = TextEditingController(
        text: userProfile.nomorTelepon.replaceFirst('+62', ''));
    TextEditingController descriptionController =
        TextEditingController(text: userProfile.deskripsi);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Profil'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                OutlinedButton(
                  onPressed: () {
                    showImageSourceDialog(context);
                  },
                  child: Text(
                    'Ubah Gambar Profil',
                    style: TextStyle(
                      color: Color.fromARGB(255, 76, 165, 175),
                    ),
                  ),
                  style: ButtonStyle(
                    side:
                        MaterialStateProperty.resolveWith<BorderSide>((states) {
                      return BorderSide(color: Colors.grey, width: 1);
                    }),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nama',
                    labelStyle:
                        TextStyle(color: Color.fromARGB(255, 76, 165, 175)),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: numberController,
                  decoration: const InputDecoration(
                    labelText: 'Nomor',
                    prefixText: '+62 ',
                    labelStyle:
                        TextStyle(color: Color.fromARGB(255, 76, 165, 175)),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Deskripsi',
                    labelStyle:
                        TextStyle(color: Color.fromARGB(255, 76, 165, 175)),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Batal',
                style: TextStyle(
                  color: Color.fromARGB(255, 76, 165, 175),
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                String newName = nameController.text;
                String newNumber = '+62' + numberController.text;
                String newDescription = descriptionController.text;

                await updateProfileName(newName);
                await updateProfilePhoneNumber(newNumber);
                await updateProfileDescription(newDescription);

                if (mounted) {
                  Navigator.of(context).pop();
                  // Tambahkan sedikit penundaan sebelum menampilkan Snackbar
                  Future.delayed(Duration(milliseconds: 300), () {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Profile updated successfully.')));
                  });
                }
              },
              child: const Text(
                'Simpan',
                style: TextStyle(
                  color: Color.fromARGB(255, 76, 165, 175),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

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

  Future<void> _uploadImageToStorage(BuildContext parentContext, File imageFile) async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    return;
  }

  String filePath = 'profile/${user.uid}/${DateTime.now().millisecondsSinceEpoch}.png';
  Reference storageRef = FirebaseStorage.instance.ref().child(filePath);
  UploadTask uploadTask = storageRef.putFile(imageFile);

  TaskSnapshot snapshot = await uploadTask;
  String downloadURL = await snapshot.ref.getDownloadURL();

  await updateProfileImageURL(downloadURL);
}

void _showAlertDialog(BuildContext context, String title, String message) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  });
}

void _handleImageUpload(BuildContext parentContext, File imageFile) async {
  try {
    await _uploadImageToStorage(parentContext, imageFile);
    _showAlertDialog(parentContext, 'Success', 'Profile picture updated successfully.');
  } catch (e) {
    _showAlertDialog(parentContext, 'Error', 'Failed to upload profile picture.');
  }


}

void _getImageFromGallery(BuildContext parentContext) async {
  final picker = ImagePicker();
  final pickedImage = await picker.pickImage(source: ImageSource.gallery);
  if (pickedImage != null) {
    File imageFile = File(pickedImage.path);
    _handleImageUpload(parentContext, imageFile);
  }
}

void _getImageFromCamera(BuildContext parentContext) async {
  final picker = ImagePicker();
  final pickedImage = await picker.pickImage(source: ImageSource.camera);
  if (pickedImage != null) {
    File imageFile = File(pickedImage.path);
    _handleImageUpload(parentContext, imageFile);
  }
}


}
