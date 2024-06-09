import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inkostel/pages/settings.dart';
import 'package:random_string/random_string.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
            return _buildProfileUI(user);
          }
        },
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildProfileUI(UserProfile user) {
    String userName = user.nama.isNotEmpty ? user.nama : 'User';
    String userUsername = user.username.isNotEmpty ? user.username : 'username';
    String userPhone = user.nomorTelepon.isNotEmpty ? user.nomorTelepon : '';
    String userEmail = user.email.isNotEmpty ? user.email : 'user@example.com';
    String userDescription = user.deskripsi.isNotEmpty ? user.deskripsi : '';
    String userPhotoURL = user.photoURL.isNotEmpty ? user.photoURL : 'lib/icons/orang.png';

    return Stack(
      children: [
        ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            buildTop(context, userPhotoURL),
            buildBottom(context, userName, userUsername, userEmail, userPhone, userDescription),
            const SizedBox(height: 100),
          ],
        ),
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
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
        );
  }

  Future<UserProfile?> _getUserData() async {
    if (FirebaseAuth.instance.currentUser != null) {
      print('User is signed in');
      await createUserProfileIfNotExists();
      var userProfile = await getUserProfile();
      if (userProfile != null) {
        print('UserProfile fetched: $userProfile');
        return userProfile;
      } else {
        print('No UserProfile found');
        return null;
      }
    } else {
      print('No user signed in');
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
            color: Colors.white, // Set the background color to white
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
              errorBuilder: (context, error, stackTrace) =>Image.asset('lib/icons/orang.png'),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: () {
              _showEditOptions(context);
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
      String email, String phone, String description) {
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
              fontWeight: FontWeight.w300,
              color: const Color(0xFF436850),
            ),
          ),
          Text(
            email,
            style: GoogleFonts.getFont(
              'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.w300,
              color: const Color(0xFF436850),
            ),
          ),
          const Divider(
            thickness: 1,
            color: Colors.grey,
            indent: 40,
            endIndent: 40,
          ),
          _buildProfileInfo('Nomor Telepon', phone, context, Icons.phone),
          _buildProfileInfo('Deskripsi', description, context, Icons.description),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildProfileInfo(
      String title, String content, BuildContext context, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF436850)),
      title: Text(
        title,
        style: GoogleFonts.getFont(
          'Poppins',
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF436850),
        ),
      ),
      subtitle: Text(
        content,
        style: GoogleFonts.getFont(
          'Poppins',
          fontSize: 14,
          fontWeight: FontWeight.w300,
          color: const Color(0xFF436850),
        ),
      ),
    );
  }

  void _showEditOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text('Edit Photo'),
            onTap: () {
              _pickImage(ImageSource.gallery);
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Edit Nama'),
            onTap: () {
              Navigator.of(context).pop();
              _editProfileField(context, 'Nama', '');
            },
          ),
          ListTile(
            leading: const Icon(Icons.phone),
            title: const Text('Edit Nomor Telepon'),
            onTap: () {
              Navigator.of(context).pop();
              _editProfileField(context, 'Nomor Telepon', '');
            },
          ),
          ListTile(
            leading: const Icon(Icons.description),
            title: const Text('Edit Deskripsi'),
            onTap: () {
              Navigator.of(context).pop();
              _editProfileField(context, 'Deskripsi', '');
            },
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _updateProfileImageURL(pickedFile);
      });
    }
  }

  Future<void> _updateProfileImageURL(XFile pickedFile) async {
    final storage = FirebaseStorage.instance;
    final ref = storage
        .ref()
        .child('user_profiles')
        .child(FirebaseAuth.instance.currentUser!.uid)
        .child('profile_image.jpg');
    final uploadTask = ref.putFile(File(pickedFile.path));
    final snapshot = await uploadTask.whenComplete(() {});
    final downloadURL = await snapshot.ref.getDownloadURL();
    updateProfileImageURL(downloadURL); // This should update the profile image URL in your user profile.
    setState(() {});
  }

  Future<void> _editProfileField(
      BuildContext context, String field, String currentValue) async {
    TextEditingController _controller = TextEditingController(text: currentValue);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit $field'),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(hintText: "Enter new $field"),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('SAVE'),
              onPressed: () {
                _saveProfileField(field, _controller.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _saveProfileField(String field, String newValue) {
    switch (field) {
      case 'Nama':
        updateProfileName(newValue);
        break;
      case 'Nomor Telepon':
        updateProfilePhoneNumber(newValue);
        break;
      case 'Deskripsi':
        updateProfileDescription(newValue);
        break;
    }
    setState(() {});
  }
}
