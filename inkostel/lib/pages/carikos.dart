import 'package:flutter/material.dart';

void main() {
  runApp(CariKos());
}

class CariKos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          actions: [
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  // Logo profile di sini
                  const Expanded(
                    child: Text('Logo Profile'),
                  ),
                  // Kolom search di sini
                  const Expanded(
                    flex: 3,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search...',
                      ),
                    ),
                  ),
                  // Icon filter di sini
                  IconButton(
                    icon: const Icon(Icons.filter_list),
                    onPressed: () {
                      // Action when filter icon is pressed
                    },
                  ),
                ],
              ),
            ),
            // Tiga tombol terdekat, termurah, dan rekomendasi
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Action when nearest button is pressed
                  },
                  child: const Text('Nearest'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Action when cheapest button is pressed
                  },
                  child: const Text('Cheapest'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Action when recommended button is pressed
                  },
                  child: const Text('Recommended'),
                ),
              ],
            ),
            // Persegi panjang di satu kolom
            Container(
              height: 200,
              color: Colors.blue,
              child: const Center(
                child: Text('Square 1'),
              ),
            ),
            // Persegi panjang di kolom sendiri
            Container(
              height: 200,
              color: Colors.green,
              child: const Center(
                child: Text('Square 2'),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
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
    );
  }
}
