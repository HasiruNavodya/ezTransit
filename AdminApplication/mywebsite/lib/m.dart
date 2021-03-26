//import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  GoogleMapController googleMapController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};


  void getMarkers(double lat, double long) {
    MarkerId markerId = MarkerId(lat.toString() + long.toString());
    Marker marker = Marker(
        markerId: markerId,
        position: LatLng(lat, long),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
        infoWindow: InfoWindow(snippet: 'MarkerId'));
    setState(() {
      markers[markerId] = marker;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Column(
        children: [
          SizedBox(
              height: 700.0,
              child: GoogleMap(
                  onTap: (tapped) async {
                    getMarkers(tapped.latitude, tapped.longitude);
                    await FirebaseFirestore.instance
                        .collection('location')
                        .add({
                      'latitude': tapped.latitude,
                      'longitude': tapped.longitude,
                    });
                    if (GoogleMapController != null) {
                      final String latitude =
                          'latitude:\n${tapped.latitude ?? ""}\n';
                      final String longitude =
                          'longitude:\n${tapped.longitude ?? ""}';

                          

                      print((latitude));
                      print((longitude));
                    }
                  },
                  mapType: MapType.hybrid,
                  compassEnabled: true,
                  trafficEnabled: true,
                  onMapCreated: (GoogleMapController controller) {
                    setState(() {
                      googleMapController = controller;
                    });
                  },
                  initialCameraPosition: CameraPosition(
                      target: LatLng(7.8731, 80.7718), zoom: 15.0),
                  markers: Set<Marker>.of(markers.values))),
        ],
      ),
    ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
