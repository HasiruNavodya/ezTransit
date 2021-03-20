import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:tma_bus/screens/trip/starttrip.dart';
import 'package:location/location.dart';
import 'package:tma_bus/screens/trip/starttrip.dart';
import 'package:geofence_service/geofence_service.dart';

final geofenceService = GeofenceService(
    interval: 5000,
    accuracy: 100,
    allowMockLocations: true
);

final geofenceList = <Geofence>[
  Geofence(
      id: 'place_1',
      latitude: 6.8408,
      longitude: 79.9992,
      radius: [
        GeofenceRadius(id: 'radius_25m', length: 25),
        GeofenceRadius(id: 'radius_100m', length: 100)
      ]
  ),
];

class TripCheck extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class TripControlView extends StatefulWidget {
  @override
  _TripControlViewState createState() => _TripControlViewState();
}

class _TripControlViewState extends State<TripControlView> {

  String tripStatus = "off";

  void onGeofenceStatusChanged(
      Geofence geofence,
      GeofenceRadius geofenceRadius,
      GeofenceStatus geofenceStatus) {
   // print('geofence: ${geofence.toMap()}');
   // print('geofenceRadius: ${geofenceRadius.toMap()}');
    print('geofenceStatus: ${geofenceStatus.toString()}\n');
  }

  void onActivityChanged(
      Activity prevActivity,
      Activity currActivity) {
    print('prevActivity: ${prevActivity.toMap()}');
    print('currActivity: ${currActivity.toMap()}\n');
  }

  void onError(dynamic error) {
    final errorCode = getErrorCodesFromError(error);
    if (errorCode == null) {
      print('Undefined error: $error');
      return;
    }

    print('ErrorCode: $errorCode');
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      geofenceService.setOnGeofenceStatusChanged(onGeofenceStatusChanged);
      geofenceService.setOnActivityChanged(onActivityChanged);
      geofenceService.setOnStreamError(onError);
      geofenceService.start(geofenceList).catchError(onError);
    });
    storeUserLocation();
  }


  @override
  Widget build(BuildContext context) {

    if (tripStatus == "off"){
      return Scaffold(
        appBar: AppBar(
          title: Text("Trip"),
          backgroundColor: Colors.black,
          centerTitle: true,
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {},
            child: Text('Share Location'),
          ),
        ),
      );
    }

    else{
      return TripNav();
    }
  }
}

storeUserLocation(){

  Location location = new Location();

  location.onLocationChanged.listen((LocationData currentLocation) {
    FirebaseFirestore.instance.collection('buses').doc('eg2345').set({
      'location' : GeoPoint(currentLocation.latitude, currentLocation.longitude)
    });
  });
}
