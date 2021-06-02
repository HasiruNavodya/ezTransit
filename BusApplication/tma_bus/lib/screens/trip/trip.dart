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
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

import 'package:tma_bus/screens/home/report.dart';

int lastStopPassed = 0;
int nextStop = 1;
int stopCount;
String tripID;
String tripName;
double stopLat;
double stopLng;
String stopID;
int geoGate = 0;
String tripState = "on";
String busNo = '';
LocationData lastLocation;
String test;
String startCity;
String endCity;
String nextStopName;
String busEmail;
String bus;
DatabaseReference pCount;

StreamController<String> getTripID = StreamController<String>();

class TripView extends StatefulWidget {

  void setTripID(String tripid) {
    tripID = tripid;
  }

  @override
  _TripViewState createState() => _TripViewState();
}

class _TripViewState extends State<TripView> {

  Location location = new Location();
  StreamSubscription<Position> positionStream;

  final myController = TextEditingController();
  final myController2 = TextEditingController();

  final ValueNotifier<int> vnBodyCount = ValueNotifier<int>(0);
  final ValueNotifier<int> vnPickupCount = ValueNotifier<int>(0);
  final ValueNotifier<int> vnDropCount = ValueNotifier<int>(0);
  final ValueNotifier<String> vnStopName = ValueNotifier<String>('TRIP START');

  List<String> stopList = [];
  int ns = 0;

/*  var _textStyle = TextStyle(
    color: Colors.red,
    fontSize: 50,
  );*/

  @override
  void initState() {
    super.initState();

    tripState = 'on';

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



  @override
  Widget build(BuildContext context) {


    if (tripState == 'on') {
      if(geoGate == 0){
        initTrip();
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
                title: Text('TRIP INFO'),
                centerTitle: true,
                backgroundColor: Colors.black,
              ),
              body: Container(
                color: Colors.grey.shade700,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Card(
                          /*elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: BorderSide(
                              color: Colors.black45,
                              width: 1.0,
                            ),
                          ),*/
                          child: StreamBuilder(
                            stream: Stream.periodic(const Duration(seconds: 1)),
                            builder: (context, snapshot) {
                              return Center(
                                child: Text(
                                  DateFormat().add_jms().format(DateTime.now()),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 40,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Card(
                          /*elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: BorderSide(
                              color: Colors.black45,
                              width: 1.0,
                            ),
                          ),*/
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
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
                                  Text(
                                    '${data['startTime']}' + ' - ' + '${data['endTime']}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Card(
                          /*elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: BorderSide(
                              color: Colors.black45,
                              width: 1.0,
                            ),
                          ),*/
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            //crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                //mainAxisAlignment: MainAxisAlignment.center,
                                //crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: ValueListenableBuilder(
                                      builder: (BuildContext context, String value, Widget child) {
                                        return Text('$value',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0,
                                              color: Colors.black87
                                          ),
                                        );
                                      },
                                      valueListenable: vnStopName,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(4.0),
                                                    child: Row(
                                                      children: [
                                                        Icon(Icons.arrow_forward_rounded, size: 25, color: Colors.green.shade800,),
                                                        Icon(Icons.directions_walk, size: 35, color: Colors.black,),
                                                      ],
                                                    ),
                                                  ),
                                                  Text('PICKUP',
                                                    style: TextStyle(
                                                      //fontWeight: FontWeight.bold,
                                                        fontSize: 15.0,
                                                        color: Colors.black87
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                children: [
                                                  ValueListenableBuilder(
                                                    builder: (BuildContext context, int value, Widget child) {
                                                      return Text('$value',
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 40.0,
                                                          color: Colors.green.shade800,
                                                        ),
                                                      );
                                                    },
                                                    valueListenable: vnPickupCount,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 65,
                                      ),
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(4.0),
                                                    child: Row(
                                                      children: [
                                                        Icon(Icons.arrow_back_rounded, size: 25, color: Colors.blue.shade800,),
                                                        Transform(
                                                          alignment: Alignment.center,
                                                          transform: Matrix4.rotationY(math.pi),
                                                          child: Icon(Icons.directions_walk, size: 35, color: Colors.black,),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Text('DROP',
                                                    style: TextStyle(
                                                      //fontWeight: FontWeight.bold,
                                                        fontSize: 15.0,
                                                        color: Colors.black87
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                children: [
                                                  ValueListenableBuilder(
                                                    builder: (BuildContext context, int value, Widget child) {
                                                      return Text('$value',
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 40.0,
                                                          color: Colors.blue.shade800,
                                                        ),
                                                      );
                                                    },
                                                    valueListenable: vnDropCount,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Card(
                          /*elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: BorderSide(
                              color: Colors.black45,
                              width: 1.0,
                            ),
                          ),*/
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('Passengers in Bus: ',
                                  style: TextStyle(
                                    //fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                  ),
                                ),
                                ValueListenableBuilder(
                                  builder: (BuildContext context, int value, Widget child) {
                                    return Text('$value',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22.0,
                                      ),
                                    );
                                  },
                                  valueListenable: vnBodyCount,
                                ),
                              ],
                            ),
                        ),
                      ),

                      Expanded(
                        flex: 2,
                        child: Card(
                          /*elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: BorderSide(
                              color: Colors.white,
                              width: 1.0,
                            ),
                          ),*/
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  OutlinedButton.icon(
                                    onPressed: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => ReportEmergencyView()),);
                                      },
                                    icon: Icon(Icons.bus_alert, size: 18, color: Colors.black,),
                                    label: Text('REPORT EMERGENCY',
                                      style: TextStyle(
                                          color: Colors.black
                                      ),
                                    ),
                                  ),
                                  OutlinedButton.icon(
                                    onPressed: (){showAlertDialog(context);},
                                    icon: Icon(Icons.dangerous, size: 18, color: Colors.black,),
                                    label: Text('STOP TRIP',
                                      style: TextStyle(
                                          color: Colors.red
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
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
                  'Ending Trip\n\n\n',
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

    FirebaseFirestore.instance.collection('trips').doc('$tripID').collection("stops").orderBy("order").get().then((querySnapshot) {
      querySnapshot.docs.forEach((stopDoc) {
        print("XXXXX"+stopDoc.id.toString());

        stopID = stopDoc.id;
        stopList.add(stopID);
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
      getPDCount(stopList.elementAt(0));
      
    }).catchError((onError) {
      print("Database Error!");
      print(onError);
    });

    FirebaseFirestore.instance.collection('trips').doc('$tripID').get().then((DocumentSnapshot tripDoc) {
      if (tripDoc.exists) {
        print('Document exists on the database');
        //lastStopPassed = tripDoc.data()['lastStopPassed'];
        //stopCount = tripDoc.data()['stopCount'];
        startCity = tripDoc.data()['startCity'];
        endCity = tripDoc.data()['endCity'];
      }
    });

    geoGate = 1;
    print(geoGate);
    getIRCount();
    streamLiveLocation();

  }

  void streamLiveLocation() async{
    positionStream = Geolocator.getPositionStream().listen((Position position) {
      print(position.latitude.toString() + ', ' + position.longitude.toString());
      FirebaseFirestore.instance.collection('buses').doc(bus).update({
        'location' : GeoPoint(position.latitude, position.longitude)
      });
    });
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

    if (geoStatus == 'GeofenceStatus.EXIT'){
      ns = ns + 1;
      getPDCount(stopList.elementAt(ns));
    }

  }

  void onActivityChanged(Activity prevActivity, Activity currActivity) {
/*    //print('prevActivity: ${prevActivity.toMap()}');
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
    }*/
  }

  void endTrip(){

    //positionStream.cancel();

    setState(() {
      tripState = 'off';
    });

    FirebaseFirestore.instance.collection('trips').doc('$tripID').collection('stops').get().then((querySnapshot) {
      querySnapshot.docs.forEach((stopDoc) {
        FirebaseFirestore.instance.collection('trips').doc('$tripID').collection('stops').doc(stopDoc.id).update({
          'passed' : 'false',
          'pickupCount' : 0,
          'dropCount' : 0,
        });
      });
    });

    FirebaseFirestore.instance.collection('trips').doc('$tripID').update({
      'lastStopPassed' : 0
    });


    Future.delayed(const Duration(seconds: 2), () {
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

  void getIRCount(){
    /*pCount.onValue.listen((event) {
      var snapshot = event.snapshot;
      String value = snapshot.value['testbus'];
      print('Value is $value');
    });*/

    pCount = FirebaseDatabase.instance.reference();
    pCount.onValue.listen((event){
      var test = event.snapshot;
      print(test.value["PCount"][bus]);
      vnBodyCount.value = test.value["PCount"][bus];
      //var pulse = snapshot.value["PCount"]["testbus"];
      //print(pulse);
      //var temp  = snapshot.value["temperature"];
    });

  }

  void getPDCount(String next){
    FirebaseFirestore.instance.collection('trips').doc('$tripID').collection('stops').doc('$next').get().then((DocumentSnapshot nextdoc) {
      if (nextdoc.exists) {
        print('Next Stop'+nextdoc.id.toString());
        print('Pickup'+nextdoc.data()['pickupCount'].toString());
        print('Pickup'+nextdoc.data()['dropCount'].toString());
        vnPickupCount.value = nextdoc.data()['pickupCount'];
        vnDropCount.value = nextdoc.data()['dropCount'];
      }
    });
    if(ns!=0){
      vnStopName.value = 'NEXT STOP: ' + next;
    }
    if(next==endCity){
      vnStopName.value = 'TRIP END: ' + next;
    }
    if(next==startCity){
      vnStopName.value = 'TRIP START: ' + next;
    }
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("YES",style: TextStyle(fontSize: 18,color: Colors.red,fontWeight: FontWeight.bold),),
      onPressed: () {
        endTrip();
        Navigator.pop(context);
      },
    );

    Widget noButton = TextButton(
      child: Text("CLOSE",style: TextStyle(fontSize: 18,color: Colors.black87),),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Confirm"),
      content: Text("Stop Current Trip?"),
      actions: [
        okButton,
        noButton,
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



