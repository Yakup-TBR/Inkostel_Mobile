import 'package:flutter/material.dart';

class CariKos extends StatelessWidget {
  const CariKos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cari Kos'),
        backgroundColor: const Color.fromRGBO(231, 246, 255, 1)
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            color:const Color.fromRGBO(39, 188, 49, 1),
            height: 100,
            child: const Text(
              "Container"
            ),
            
          ),
          Expanded(child: Container(
            color:const Color.fromRGBO(171, 81, 204, 1),
            child: const Text(
              "Expanded"
            )
            
          ))
        ],
      ),
    );
  }
}
