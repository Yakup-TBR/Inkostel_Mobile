import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Validation());
}

class Validation extends StatelessWidget {
  const Validation({Key? key});
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(173,188,159, 1),

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

        backgroundColor: const Color.fromRGBO(173,188,159, 1),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                   Expanded(
                    flex: 2,
                    child: TextField(
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                      hintText: 'Cari Kos Disini..',
                      suffixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(color: Colors.white), // Belum berubah
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      hintStyle: const TextStyle(color: Colors.grey, fontSize: 14.0),
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
                            offset: const Offset(0, 3), // Offset shadow (horizontal, vertical)
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
            Expanded(
              child: Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text('Item $index'),
                          onTap: () {
                            // Action icon
                          },
                        );
                      },
                    ),
                  ),
                ],
              )
            )
          ],
        ),
      )
    );
  }
}
