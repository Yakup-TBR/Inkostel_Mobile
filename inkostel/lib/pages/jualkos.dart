import 'package:flutter/material.dart';

void main() {
  runApp(const jualkos());
}

class jualkos extends StatelessWidget {
  const jualkos({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(18, 55, 42, 1),
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
                    color: Colors.blue,
                    onPressed: () {
                      // Action when profile icon is pressed
                    },
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'Test',
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
              decoration: BoxDecoration(
                color: const Color.fromRGBO(18, 55, 42, 1),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Expanded(
                    flex: 3,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Cari Kos Disini..',
                        hintStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      // Action when search icon is pressed
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.filter_list),
                    onPressed: () {
                      // atur filter
                    },
                  ),
                ],
              ),
            ),
            Expanded(
  child: ListView(
    children: [
      Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Column(
                children: [
                  Text(
                    'Daftarkan kostan Anda sekarang!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Tampilkan kostan terbaikmu dengan hadir di online.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Nama Kostan',
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Nomor Telepon',
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Alamat',
              ),
            ),
            const SizedBox(height: 10),
            // Add image upload functionality
            ElevatedButton(
              onPressed: () {
                // Action when image upload button is pressed
              },
              child: Text('Upload Foto Kostan'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Action when submit button is pressed
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    ],
  ),
),

            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Positioned(
                left: 0,
                right: 0,
                bottom: 50,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 60,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(18, 55, 42, 1),
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
