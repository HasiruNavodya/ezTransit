import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:geofence_service/geofence_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tma_bus/main.dart';
import 'package:tma_bus/screens/home/addtrip.dart';

int lastStopPassed = 0;
int nextStop = 1;
int stopCount;
String tripID = 'T3001';
String tripName;
double stopLat;
double stopLng;
String stopID;
int geoGate = 0;
String tripState = "on";
String busNo = 'GE-3412';
LocationData lastLocation;
String test;
String startCity;
String endCity;
String busEmail;
String bus;

StreamController<String> getTripID = StreamController<String>();

// ignore: must_be_immutable
class TripView extends StatefulWidget {

<<<<<<< HEAD
  AddTripView tripid = AddTripView();

=======
  TripView(this.stream);
  final Stream<String> stream;
>>>>>>> parent of 9511974 (.)

  @override
  _TripViewState createState() => _TripViewState();
}

class _TripViewState extends State<TripView> {

  Location location = new Location();
  StreamSubscription<Position> positionStream;

  final myController = TextEditingController();
  final myController2 = TextEditingController();

  @override
  void initState() {
    super.initState();

<<<<<<< HEAD
    print('XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX');
    //print(tripid.tripID);
=======
    widget.stream.listen((tripid) {
      setTripID(tripid);
    });
>>>>>>> parent of 9511974 (.)

    FirebaseAuth auth = FirebaseAuth.instance;

    if (auth.currentUser != null) {
      print(auth.currentUser.email);
      busEmail = auth.currentUser.email;
      List list = busEmail.split('@');
      bus = list[0].toString().toUpperCase();
      print(bus);
    }



    print(tripState);
  }

  void setTripID(String tripid) {
    tripID = tripid;
  }

  @override
  Widget build(BuildContext context) {
    if (tripState == 'on') {
      if(geoGate == 0){
        initTrip();
        streamLiveLocation();
      }
      return FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('trips').doc('$tripID').get(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data.data();

            lastStopPassed = data['lastStopPassed'];

            return Scaffold(
              appBar: AppBar(
                title: Text('Current Trip Info'),
                centerTitle: true,
                backgroundColor: Colors.black,
              ),
              body: Center(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '${data['startCity']}' + ' - ' + '${data['endCity']}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24.0,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '${data['startTime']}' + ' - ' + '${data['endTime']}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          return Scaffold(
            body: Container(
              child: SpinKitDualRing(color: Colors.black87),
            ),
          );
        },
      );
    }
    else {
      return Scaffold(
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'You Have Reached the Trip Destination. \nEnding Trip Now...\n\n\n',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                SpinKitDualRing(color: Colors.black87),
              ],
            ),
          ),
        ),
      );
    }
  }

  Future initTrip() async {

    print(tripID);

    FirebaseFirestore.instance.collection('trips').doc('$tripID').collection('stops').get().then((querySnapshot) {
      querySnapshot.docs.forEach((stopDoc) {
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

    FirebaseFirestore.instance.collection('trips').doc('$tripID').get().then((DocumentSnapshot tripDoc) {
      if (tripDoc.exists) {
        print('Document exists on the database');
        //lastStopPassed = tripDoc.data()['lastStopPassed'];
        stopCount = tripDoc.data()['stopCount'];
        startCity = tripDoc.data()['startCity'];
        endCity = tripDoc.data()['endCity'];
      }
    });

    geoGate = 1;
    print(geoGate);
    //streamLiveLocation();

  }

  void streamLiveLocation() async{
    positionStream = Geolocator.getPositionStream().listen((Position position) {
      print(position.latitude.toString() + ', ' + position.longitude.toString());

      /*FirebaseFirestore.instance.collection('buses').doc('GE-3412').update({
        'location' : GeoPoint(position.latitude, position.longitude)
      });*/
    });
  }

  void pauseLocationStream() {
    print('paused');
    positionStream.pause();
  }

  void resumeLocationStream() {
    print('resumed');
    positionStream.resume();
  }



  final geofenceService = GeofenceService(
      interval: 5000,
      accuracy: 100,
      allowMockLocations: true
  );

  final geofenceList = <Geofence>[];

  void onGeofenceStatusChanged(Geofence geofence, GeofenceRadius geofenceRadius, GeofenceStatus geofenceStatus) {
    //print('geofence: ${geofence.toMap()}');
    // print('geofenceRadius: ${geofenceRadius.toMap()}');
    print('geofenceStatus: ${geofenceStatus.toString()}\n');

    String geoStatus = geofenceStatus.toString();

    if (geoStatus == 'GeofenceStatus.ENTER') {
      /*FirebaseFirestore.instance.collection('trips').doc('$tripID').update({
        'lastStopPassed' : passed
      });*/

      FirebaseFirestore.instance.collection('trips').doc('$tripID').collection('stops').doc(geofence.id).update({
        'passed' : 'true'
      });

      if(geofence.id == endCity){
        setState(() {
          tripState = 'off';
        });
        endTrip();
      }
    }

  }

  void onActivityChanged(Activity prevActivity, Activity currActivity) {
    //print('prevActivity: ${prevActivity.toMap()}');
    print('currActivity: ${currActivity.toMap()}\n');

    if(currActivity.type.toString() != 'ActivityType.STILL'){
      if(positionStream.isPaused){
        positionStream.resume();
        print('resumed');
      }
    }
    else{
      if(positionStream.isPaused){
        positionStream.pause();
        print('paused');
      }
    }
  }

  void endTrip(){

    positionStream.cancel();

    setState(() {
      tripState = 'off';
    });

    FirebaseFirestore.instance.collection('trips').doc('$tripID').collection('stops').get().then((querySnapshot) {
      querySnapshot.docs.forEach((stopDoc) {
        FirebaseFirestore.instance.collection('trips').doc('$tripID').collection('stops').doc(stopDoc.id).update({
          'passed' : 'false'
        });
      });
    });

    FirebaseFirestore.instance.collection('trips').doc('$tripID').update({
      'lastStopPassed' : 0
    });


    Future.delayed(const Duration(seconds: 3), () {
      streamController.add(0);
    });

  }

  void onError(dynamic error) {
    final errorCode = getErrorCodesFromError(error);
    if (errorCode == null) {
      print('Undefined error: $error');
      return;
    }
    print('ErrorCode: $errorCode');
  }

}



