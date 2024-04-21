import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Location CRUD',
      home: LocationScreen(),
    );
  }
}

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String _location = '';

  Future<void> _getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _location = 'Lat: ${position.latitude}, Long: ${position.longitude}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location CRUD'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Location:',
              style: TextStyle(fontSize: 20.0),
            ),
            Text(
              _location,
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _getLocation,
              child: Text('Get Location'),
            ),
          ],
        ),
      ),
    );
  }
}
