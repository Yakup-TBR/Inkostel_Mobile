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
              const Flexible(
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              Container(
                margin: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(20),
                ),
                height: 150,
                width: double.infinity,
              ),
              Container(
                margin: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(20),
                ),
                height: 150,
                width: double.infinity,
              ),
              Container(
                margin: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(20),
                ),
                height: 150,
                width: double.infinity,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
