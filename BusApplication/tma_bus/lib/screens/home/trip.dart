import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:tma_bus/screens/trip/starttrip.dart';
import 'package:location/location.dart';
import 'package:tma_bus/screens/trip/starttrip.dart';
import 'package:geofence_service/geofence_service.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

int lastStopPassed = 0;
int nextStop = 1;
int stopCount;
String tripID;
String tripName;
double stopLat;
double stopLng;
String stopID;
int geoGate = 0;
String tripStatus = "off";
String busNo = 'GE-3412';
LocationData lastLocation;
String test;

class TripControlView extends StatefulWidget {
  @override
  _TripControlViewState createState() => _TripControlViewState();
}

class _TripControlViewState extends State<TripControlView> {

  Location location = new Location();
  StreamSubscription<Position> positionStream;

  final myController = TextEditingController();
  final myController2 = TextEditingController();

  @override
  void initState() {
    super.initState();
    print(tripStatus);
    myController.text = 'current';
    myController2.text = 'previous';
  }

  @override
  Widget build(BuildContext context) {
    if (tripStatus == "on") {
      if(geoGate == 0){
        initTrip();
        //print('inittrip');
      }
      return FutureBuilder<DocumentSnapshot>(
        future:
            FirebaseFirestore.instance.collection('trips').doc('$tripID').get(),
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
                      TextField(
                        controller: myController,
                      ),
                      /*TextField(
                        controller: myController2,
                      ),*/
                    ],
                  ),
                ),
              ),
            );
          }

          return Text("loading");
        },
      );
    }
    else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Select Trip'),
          centerTitle: true,
          backgroundColor: Colors.black87,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('trips').where('bus', isEqualTo: busNo).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: new ListView(
                children: snapshot.data.docs.map((DocumentSnapshot document) {
                  return Container(
                    color: Colors.white70,
                    margin: const EdgeInsets.only(top: 5.0,bottom: 5.0),
                    child: new OutlinedButton(
                      onPressed: () {
                        tripID = document.data()['tripID'];
                        //print(tripID);
                        showAlertDialog(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Text(
                              '${document.data()['startTime'] ?? 'default'}' + ' ' + '-' + ' ' '${document.data()['endTime']??'default'}',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.black87
                              ),
                            ),
                            Text(
                              document.data()['name']??'default',
                              style: TextStyle(
                                  color: Colors.black87
                              ),
                            ),


                          ],
                        ),
                      ),
                    ),
                  );
                    //Card(child: Text(document.data()['name']??'default'),);
                }).toList(),
              ),
            );
          },
        ),
      );
    }
  }

  Future initTrip() async {

    print(tripID);

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

    FirebaseFirestore.instance.collection('trips').doc('$tripID').get().then((DocumentSnapshot tripDoc) {
      if (tripDoc.exists) {
        print('Document exists on the database');
        //lastStopPassed = tripDoc.data()['lastStopPassed'];
        stopCount = tripDoc.data()['stopCount'];
      }
    });

    geoGate = 1;
    print(geoGate);
    //streamLiveLocation();

  }

  void streamLiveLocation() async{
    positionStream = Geolocator.getPositionStream().listen((Position position) {
      print(position == null ? 'Unknown' : position.latitude.toString() + ', ' + position.longitude.toString());

      FirebaseFirestore.instance.collection('testscoll').doc('123').set({
        'lat': position.latitude.toString(),
        'lng': position.longitude.toString(),
        'status': test
      });
      print(test);

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
    int passed = int.parse(geofence.toMap()['id']);
    //print(passed);

    if (geoStatus == 'GeofenceStatus.ENTER') {
      FirebaseFirestore.instance.collection('trips').doc('$tripID').update({
        'lastStopPassed' : passed
      });
    }

  }


  void onActivityChanged(Activity prevActivity, Activity currActivity) {
    //print('prevActivity: ${prevActivity.toMap()}');
    print('currActivity: ${currActivity.toMap()}\n');
    myController.text = currActivity.type.toString() + currActivity.confidence.toString();
    myController2.text = currActivity.type.toString() + currActivity.confidence.toString();

    if(currActivity.type.toString() != 'ActivityType.STILL'){
      if(positionStream.runtimeType != null){
        positionStream.resume();
      }
      else{
        streamLiveLocation();
      }
    }
    else{
      positionStream.pause();
    }
  }

  void onError(dynamic error) {
    final errorCode = getErrorCodesFromError(error);
    if (errorCode == null) {
      print('Undefined error: $error');
      return;
    }
    print('ErrorCode: $errorCode');
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(
        "Start",
        style: TextStyle(
            fontSize: 20.0,
            color: Colors.red
        ),
      ),
      onPressed:  () {
        tripStatus = 'on';
        setState(() {});
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text(
        "Close",
        style: TextStyle(
            fontSize: 20.0,
            color: Colors.grey
        ),
      ),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Confirm Start Trip"),
      content: Text("Are you sure you want to start this trip?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}



