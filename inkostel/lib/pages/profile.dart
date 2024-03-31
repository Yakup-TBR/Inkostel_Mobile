import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);
  final double coverHeight = 250;
  final double profileSize = 136;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          buildTop(),
          SizedBox(height: 20),
          buildContent(),
        ],
      ),
    );
  }

  Widget buildTop() {
    final bottom = profileSize / 2;
    final top = coverHeight - profileSize / 2;
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: bottom),
          child: buildCoverImage(),
        ),
        Positioned(
          top: top,
          child: buildProfileImageWithShadow(),
        ),
      ],
    );
  }

  Widget buildCoverImage() => Container(
    color: Colors.grey,
    child: Image.network(
      'https://s3-alpha-sig.figma.com/img/db12/58a7/aac69a079d74defbae519713a88c46c6?Expires=1711929600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=jBaaxdBltN1CxYzmRH35Zh5OrXx2l7diuBbpmobA2hOZuq0N8VVm0dAxMYhDdm9YROxTANd82XkhjBz9iOGCdcDWZ1TM9JddRYK3RgpsZoDwEcNBDBYtsAZOwobRM2YD4LIVXzCXEFn53y8U6PkAKlWTE6mSX7MCHy-gvLqLdizxZLH4izj677wXq22CLrQZ2Wyw1wUuwD2UoEfBGKF7zuG3clHKm8ZecfneK2B9n~2Q3OF4sAjCQ7BxWJGOXe1VDWqwwcToFTO6G0Bssuo1n1w85VZ4aq4nOI2pikXcbpuJLG3lgBij2ZmZ7A0NIfD3ZGwz9dzfX-ibLdGDPLTTMQ__',
      fit: BoxFit.cover,
      width: double.infinity,
      height: coverHeight,
    ),
  );

  Widget buildProfileImageWithShadow() => Container(
    width: profileSize,
    height: profileSize,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          spreadRadius: 2,
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.network(
        'https://s3-alpha-sig.figma.com/img/e5bd/2aef/17da75645f56342cadd550313e0262d4?Expires=1711929600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=RzpMf7Ze1xFaaBmOvV2CYUXMU3O7uwBwFcew~bBavyAVl9DBZCJeh~nG2L-BN0ACt6ZOddTNfwluT4i42BTH8wE4Am52y-NYxFurFfmH0TLmYb34r3eQ0CnsZRTaV-ErZYODViA0nCq2KQwbgvzmflDYGYI2DFi-rI0LKPZLWWLszxAIsFLtm1IDBw8wxlUAnjEU-wLAjwl0Fd9Up2wtaDM-siJBI0Xg9VpXrKl~282WvbWGbqM3Dz50QcL-3P6eUSjOGiHUAUuyRUlX8CtAyHSDZHVk5ljghiuaosofHjBgQJTV1vHs2YK2JB5h37f1m5kVs0IiQz4HpbQYaGcC6A__',
        width: profileSize,
        height: profileSize,
        fit: BoxFit.cover,
      ),
    ),
  );

  Widget buildContent() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      
      children: [
        Text(
          'Supri Basuki', 
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold, 
            color: Color(0xFF436850),
          ),
        ),
        // SizedBox(height: 10),
        // Text(
        //   'UI/UX Designer', // Ganti dengan pekerjaan atau deskripsi singkat
        //   style: TextStyle(
        //     fontSize: 16,
        //     color: Colors.grey,
        //   ),
        // ),
        // SizedBox(height: 10),
        // Text(
        //   'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
        //   textAlign: TextAlign.center,
        //   style: TextStyle(
        //     fontSize: 16,
        //   ),
        // ),
      ],
    );
  }


}
