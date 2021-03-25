import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:tma_bus/screens/trip/starttrip.dart';
import 'package:location/location.dart';
import 'package:tma_bus/screens/trip/starttrip.dart';
import 'package:geofence_service/geofence_service.dart';
import 'dart:async';

int lastStopPassed = 0;
int nextStop = 1;
int stopCount;
String tripID = 'T3000';
String tripName;
double stopLat;
double stopLng;
String stopID;
int geoGate = 0;

StreamController<String> streamController = StreamController<String>();

class TripControlView extends StatefulWidget {

  TripControlView(this.title, this.stream);
  final String title;
  final Stream<int> stream;

  @override
  _TripControlViewState createState() => _TripControlViewState();
}

class _TripControlViewState extends State<TripControlView> {
  String tripStatus = "off";

  @override
  void initState() {
    super.initState();

    void mySetState(int index) {
      List statusList = ['A', 'B', 'C'];
      setState(() {
        statusName = statusList[index];
      });
    }

    widget.stream.listen((index) {
      mySetState(index);
    });



    FirebaseFirestore.instance.collection('trips').doc('$tripID').get().then((DocumentSnapshot tripDoc) {
      if (tripDoc.exists) {
        print('Document exists on the database');
        //lastStopPassed = tripDoc.data()['lastStopPassed'];
        stopCount = tripDoc.data()['stopCount'];
      }
    });

    if(geoGate == 0){
      initTrip();
    }

    //storeUserLocation();

  }

  @override
  Widget build(BuildContext context) {
    if (tripStatus == "off") {
      return FutureBuilder<DocumentSnapshot>(
        future:
            FirebaseFirestore.instance.collection('trips').doc('T3000').get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data.data();

            lastStopPassed = data['lastStopPassed'];

            return Scaffold(
              appBar: AppBar(
                title: Text('Trip Info'),
                centerTitle: true,
                backgroundColor: Colors.black,
              ),
              body: Container(
                child: Center(
                  child: Column(
                    children: [
                      Text(data['startCity']),
                      Text(data['startTime']),
                      Text(data['endCity']),
                      Text(data['endTime']),
                      Text('$lastStopPassed'),
                      Text('$geofenceList')
                    ],
                  ),
                ),
              ),
            );
          }

          return Text("loading");
        },
      );
    } else {
      return TripNav();
    }
  }
}

storeUserLocation() {
  Location location = new Location();
  /*
  FirebaseFirestore.instance.collection('buses').doc('eg2345').set({
      'location' : GeoPoint(currentLocation.latitude, currentLocation.longitude)
    });
   */
  location.onLocationChanged.listen((LocationData currentLocation) {
    print("*******");
  });
}


final geofenceService = GeofenceService(
    interval: 5000,
    accuracy: 100,
    allowMockLocations: true
);

final geofenceList = <Geofence>[];

void onGeofenceStatusChanged(Geofence geofence, GeofenceRadius geofenceRadius,
    GeofenceStatus geofenceStatus) {
  //print('geofence: ${geofence.toMap()}');
  // print('geofenceRadius: ${geofenceRadius.toMap()}');
  print('geofenceStatus: ${geofenceStatus.toString()}\n');

  String geoStatus = geofenceStatus.toString();
  int passed = int.parse(geofence.toMap()['id']);
  print(passed);

  if (geoStatus == 'GeofenceStatus.ENTER') {

    FirebaseFirestore.instance.collection('trips').doc('$tripID').update({
      'lastStopPassed' : passed
    });

  }
}

Future initTrip() async {

  FirebaseFirestore.instance.collection('trips').doc('$tripID').collection('stops').get().then((querySnapshot) {querySnapshot.docs.forEach((stopDoc) {
    print(stopDoc.data()['name']);

    stopID = stopDoc.id;
    stopLat = stopDoc.data()['location'].latitude.toDouble();
    stopLng = stopDoc.data()['location'].longitude.toDouble();

    final geoNew = Geofence(
      id: '$stopID',
      latitude: stopLat,
      longitude: stopLng,
      radius: [
        GeofenceRadius(id: 'bus_stop_radius', length: 100),
      ],
    );

    geofenceList.add(geoNew);
    print(geofenceList.length);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      geofenceService.setOnGeofenceStatusChanged(onGeofenceStatusChanged);
      geofenceService.setOnActivityChanged(onActivityChanged);
      geofenceService.setOnStreamError(onError);
      geofenceService.start(geofenceList).catchError(onError);
    });

  });
  }).catchError((onError) {
    print("Database Error!");
    print(onError);
  });
  geoGate = 1;
}

void onActivityChanged(Activity prevActivity, Activity currActivity) {
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