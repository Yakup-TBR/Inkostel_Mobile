import 'package:flutter/material.dart';

void main() {
  runApp(const Simpan());
}

class Simpan extends StatelessWidget {
  const Simpan({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(173, 188, 159, 1),
          title: Row(
            children: [
              InkWell(
                onTap: () {},
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.account_circle),
                    color: Colors.blue,
                    onPressed: () {},
                  ),
                ),
              ),
              const Expanded(
                child: Center(
                  child: Text(
                    'Kos Tersimpan',
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: const Color.fromRGBO(173, 188, 159, 1),
        body: Stack(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: 150,
                    width: double.infinity,
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: 150,
                    width: double.infinity,
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: 150,
                    width: double.infinity,
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: 102,
                    width: double.infinity,
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: MediaQuery.of(context).size.height * 0.07,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 81, 109, 91),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.home),
                        onPressed: () {
                          // Action when home icon is pressed
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          // Action when search icon is pressed
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.save),
                        onPressed: () {
                          // Action when save icon is pressed
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          // Action when add icon is pressed
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
