import 'package:flutter/material.dart';
void main() {
  runApp(const Tes());
}

class Tes extends StatelessWidget {
  const Tes({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: const Color.fromRGBO(173, 188, 159, 1),
      appBar: AppBar( // ----------Appbar 
        toolbarHeight: 100,
        backgroundColor: const Color.fromRGBO(173, 188, 159, 1),
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
                child: Image.asset(
                  'lib/icons/orang.png',
                  color: const Color.fromRGBO(67, 104, 80, 1),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'Hai, Supri Makmur',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          Column(children: [ // ----------SearchBar dan Tombol
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(254, 251, 246, 1),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                          hintStyle: TextStyle(fontSize: 17),
                          hintText: 'Cari Kos Disini..',
                          suffixIcon: Icon(Icons.search),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 20, top: 8),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 0, 0, 0)
                              .withOpacity(0.5),
                          spreadRadius: 0,
                          blurRadius: 4,
                          offset:
                              const Offset(0, 1), // Atur posisi shadow
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(7),
                    child: Image.asset(
                      'lib/icons/filter.png',
                      color: const Color.fromRGBO(67, 104, 80, 1),
                    ),
                  ),
                ),
                const Row()
              ],
            ),
          ]),
          Container(// Tombol Terdekat Termurah Rekomendasi

              ),
          Container(// Isi

              ),
          Container( // ----------Bottom Navigation Bar
            height: 65,
            margin: const EdgeInsets.only(
              // Harus diatur per halaman R,L,T,B nya
              right: 50,
              left: 50,
              top: 430,
              bottom: 100,
            ),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(67, 104, 80, 1),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
                  spreadRadius: 0,
                  blurRadius: 4,
                  offset: const Offset(0, 1), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  height: 35,
                  'lib/icons/home.png',
                  color: const Color.fromARGB(255, 232, 255, 240),
                ),
                Image.asset(
                  'lib/icons/search.png',
                  height: 35,
                  color: const Color.fromARGB(255, 232, 255, 240),
                ),
                Image.asset(
                  height: 35,
                  'lib/icons/simpan.png',
                  color: const Color.fromARGB(255, 232, 255, 240),
                ),
                Image.asset(
                  height: 35,
                  'lib/icons/plus.png',
                  color: const Color.fromARGB(255, 232, 255, 240),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
