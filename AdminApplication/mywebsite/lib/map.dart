import 'package:flutter/material.dart';
import 'package:google_maps_flutter_web/google_maps_flutter_web.dart';


class GoogleMap extends StatefulWidget {
  @override
  _GoogleMapState createState() => _GoogleMapState();
}

class _GoogleMapState extends State<GoogleMap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition,
      ),
    );
  }
}