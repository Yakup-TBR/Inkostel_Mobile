import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);
  final double coverHeight = 280;
  final double profileSize = 144;

  @override
  Widget build(BuildContext context) {
    final top = coverHeight - profileSize / 2;
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          buildCoverImage(),
          Positioned(
            top: top,
            child: buildProfileImage(),
          ),
        ],
      ),
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

  Widget buildProfileImage() => ClipRRect( // Menggunakan ClipRRect di sini
    borderRadius: BorderRadius.circular(16), // Atur sudut border sesuai keinginan
    child: Image.network(
      'https://s3-alpha-sig.figma.com/img/e5bd/2aef/17da75645f56342cadd550313e0262d4?Expires=1711929600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=RzpMf7Ze1xFaaBmOvV2CYUXMU3O7uwBwFcew~bBavyAVl9DBZCJeh~nG2L-BN0ACt6ZOddTNfwluT4i42BTH8wE4Am52y-NYxFurFfmH0TLmYb34r3eQ0CnsZRTaV-ErZYODViA0nCq2KQwbgvzmflDYGYI2DFi-rI0LKPZLWWLszxAIsFLtm1IDBw8wxlUAnjEU-wLAjwl0Fd9Up2wtaDM-siJBI0Xg9VpXrKl~282WvbWGbqM3Dz50QcL-3P6eUSjOGiHUAUuyRUlX8CtAyHSDZHVk5ljghiuaosofHjBgQJTV1vHs2YK2JB5h37f1m5kVs0IiQz4HpbQYaGcC6A__',
      width: profileSize,
      height: profileSize,
      fit: BoxFit.cover,
    ),
  );
}
