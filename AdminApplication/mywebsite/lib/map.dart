import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();
Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
 
  //get marker 

void getMarkers(double lat, double long) {
    MarkerId markerId = MarkerId(lat.toString() + long.toString());
    Marker marker = Marker(
        markerId: markerId,
        position: LatLng(lat, long),
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(snippet: 'Address'));
    setState(() {
      markers[markerId] = marker;
    });
  } 

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(7.8731, 80.7718),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
    
        onTap: (tapped) async {
                    getMarkers(tapped.latitude, tapped.longitude);
                    await FirebaseFirestore.instance
                        .collection('Marker_location')
                        .add({
                      'latitude': tapped.latitude,
                      'longitude': tapped.longitude,
                    });
                  },

        mapType: MapType.normal,
        compassEnabled: true,
        trafficEnabled: true,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      
      ),

    
    );
  }

 
}
