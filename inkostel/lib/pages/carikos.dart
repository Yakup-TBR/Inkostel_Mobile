import 'package:flutter/material.dart';

void main() {
  runApp(const CariKos());
}

class CariKos extends StatelessWidget {
  const CariKos({Key? key});

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
                onTap: () {
                  // Action when the box is tapped
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.account_circle),
                    color: const Color.fromARGB(255, 0, 0, 0),
                    onPressed: () {
                      // Action when profile icon is pressed
                    },
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'Validation - Admin',
                style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
              ),
            ],
          ),
        ),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextField(
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 1, horizontal: 10),
                        hintText: 'Cari Kos Disini..',
                        suffixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(
                              color: Colors.white), // Belum berubah
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                        hintStyle:
                            const TextStyle(color: Colors.grey, fontSize: 14.0),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2, // Penyebaran shadow
                            blurRadius: 3, // Blur radius shadow
                            offset: const Offset(
                                0, 3), // Offset shadow (horizontal, vertical)
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.filter_list),
                        onPressed: () {
                          // atur filter
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Action when nearest button is pressed
                  },
                  child: const Text('Terdekat'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Action when cheapest button is pressed
                  },
                  child: const Text('Termurah'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Action when recommended button is pressed
                  },
                  child: const Text('Recommended'),
                ),
              ],
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    width: 400,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Color.fromARGB(109, 134, 146, 134),
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  Container(
                    width: 400,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Color.fromARGB(109, 134, 146, 134),
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 50,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(173, 188, 159, 1),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.home),
                            iconSize: 30,
                            onPressed: () {
                              // Action when home icon is pressed
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.search),
                            iconSize: 30,
                            onPressed: () {
                              // Action when search icon is pressed
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.save),
                            iconSize: 30,
                            onPressed: () {
                              // Action when save icon is pressed
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.add),
                            iconSize: 30,
                            onPressed: () {
                              // Action when add icon button is pressed
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
