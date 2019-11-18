// CSCI 4100U - 10b Geolocation and Geocoding

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

//import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Location Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LocationPage(title: 'Location Example'),
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
  //var _location = Location();
  var _positionMessage = '';

  void _updateLocation(userLocation) {
    // location plug-in:
    /*
    _location.getLocation().then((userLocation) {
      setState(() {
        _positionMessage = userLocation.latitude.toString() + ', ' + userLocation.longitude.toString();
      });
      print('New location: ${userLocation.latitude}, ${userLocation.longitude}.');
    });
    */

    // geolocator plug-in:
    setState(() {
      _positionMessage = userLocation.latitude.toString() + ', ' + userLocation.longitude.toString();
    });
    print('New location: ${userLocation.latitude}, ${userLocation.longitude}.');

    // test out reverse geocoding
    _geolocator.placemarkFromCoordinates(userLocation.latitude, userLocation.longitude).then((List<Placemark> places) {
      print('Reverse geocoding results:');
      for (Placemark place in places) {
        print('\t${place.name}, ${place.subThoroughfare}, ${place.thoroughfare}, ${place.locality}, ${place.subAdministrativeArea}');
      }
    });
    
    // testing out forward geocoding
    String address = '301 Front St W, Toronto, ON';
    _geolocator.placemarkFromAddress(address).then((List<Placemark> places) {
      print('Forward geocoding results:');
      for (Placemark place in places) {
        print('\t${place.name}, ${place.subThoroughfare}, ${place.thoroughfare}, ${place.locality}, ${place.subAdministrativeArea}');
      }
    });
  }

  @override 
  void initState() {
        // this is called when the location changes
    /*
    // location plug-in version:
    _location.onLocationChanged().listen((LocationData userLocation) {
      setState(() {
        _positionMessage = userLocation.latitude.toString() + ', ' + userLocation.longitude.toString();
      });
    });
    */
    // geolocator plug-in version:
    _geolocator.checkGeolocationPermissionStatus().then((GeolocationStatus geolocationStatus) {
      print('Geolocation status: $geolocationStatus.');
    });

    _geolocator.getPositionStream(LocationOptions(accuracy: LocationAccuracy.best, timeInterval: 5000))
      .listen((userLocation) {
        _updateLocation(userLocation);
      }
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Your location:',
              textScaleFactor: 2.0,
            ),
            Text(
              _positionMessage,
              textScaleFactor: 1.5,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Update',
        child: Icon(Icons.update),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
