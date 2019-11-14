import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Geolocation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LocationPage(title: 'Geolocation'),
    );
  }
}

class LocationPage extends StatefulWidget {
  LocationPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  var _geolocator = Geolocator();
  var _positionMessage = '';

  void _updateLocation() {
    _geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    ).then((Position userLocation) {
      setState(() {
        _positionMessage = userLocation.latitude.toString() + 
                          ', ' +
                          userLocation.longitude.toString();
        
        // test out reverse geocoding
        _geolocator.placemarkFromCoordinates(
          userLocation.latitude, 
          userLocation.longitude
        ).then((List<Placemark> places) {
          print('Reverse geocoding results:');
          for (Placemark place in places) {
            print('\t${place.name}, ${place.subThoroughfare}, ${place.thoroughfare}, ${place.locality}, ${place.subAdministrativeArea}');
          }
        });
        
      });      
    });
  }

  @override
  Widget build(BuildContext context) {
    _geolocator.checkGeolocationPermissionStatus().then((GeolocationStatus geolocationStatus) {
      print('Geolocation status: $geolocationStatus');
    });

    _geolocator.getPositionStream(
      LocationOptions(
        accuracy: LocationAccuracy.best,
        timeInterval: 5000,
      )
    ).listen((userLocation) {
      setState(() {
        _positionMessage = userLocation.latitude.toString() +
                           ', ' +
                           userLocation.longitude.toString();
      });
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Your location:', textScaleFactor: 2.0),
            Text(_positionMessage, textScaleFactor: 1.5),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _updateLocation,
        tooltip: 'FAB',
        child: Icon(Icons.update),
      ),
    );
  }
}
