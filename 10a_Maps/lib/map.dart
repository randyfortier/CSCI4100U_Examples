// CSCI 4100U - 10a Maps

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class Map extends StatelessWidget {
  final centre = LatLng(43.9457842,-78.895896);
  final path = [LatLng(43.9457842,-78.893896), LatLng(43.9437842,-78.897896), LatLng(43.9457842,-78.895896)];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
          minZoom: 16.0,
          center: centre,
        ),
        layers: [
          TileLayerOptions(
            /*
            // for OpenStreetMaps:
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
            */
            ///*
            // for MapBox:
            urlTemplate: 'https://api.mapbox.com/styles/v1/rfortier/cjzcobx1x2csf1cmppuyzj5ys/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoicmZvcnRpZXIiLCJhIjoiY2p6Y282cWV4MDg0ZDNibG9zdWZ6M3YzciJ9.p1ePjCH-zs0RdBbLx40pgQ',
            additionalOptions: {
              'accessToken': 'pk.eyJ1IjoicmZvcnRpZXIiLCJhIjoiY2p6Y282cWV4MDg0ZDNibG9zdWZ6M3YzciJ9.p1ePjCH-zs0RdBbLx40pgQ',
              'id': 'mapbox.mapbox-streets-v8'
            }
            //*/
          ),
          MarkerLayerOptions(
            markers: [
              Marker(
                width: 45.0,
                height: 45.0,
                point: centre,
                builder: (context) => Container(
                  child: IconButton(
                    icon: Icon(Icons.location_on),
                    color: Colors.blue,
                    iconSize: 45.0,
                    onPressed: () {
                      print('Icon clicked');
                    },
                  ),
                ),
              ),
            ],
          ),
          PolylineLayerOptions(
            polylines: [
              Polyline(
                points: path,
                strokeWidth: 2.0,
                color: Colors.blue,
              ),
            ],
          ),
        ],
      ),
    );
  }

}