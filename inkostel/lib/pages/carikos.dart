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

        backgroundColor: const Color.fromRGBO(173,188,159, 1),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Expanded(
                    flex: 3,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Cari Kos Disini..',
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
              child: Stack( // Gunakan Stack sebagai wadah
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
                  
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 50,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8, 
                      height: 60,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(67,104,80, 1),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
