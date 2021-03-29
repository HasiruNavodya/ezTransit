import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
//import 'package:location/location.dart';
import 'package:geofence_service/geofence_service.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tma_bus/main.dart';
import 'package:permission_handler/permission_handler.dart';

String tripID;
String busNo;
int sval = 1;

class AddTripView extends StatefulWidget {

  @override
  _AddTripViewState createState() => _AddTripViewState();
}

class _AddTripViewState extends State<AddTripView> {

  @override
  void initState() {
    super.initState();
    activityPermission();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Start Trip'),
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
            return Scaffold(
              body: Container(
                child: SpinKitDualRing(color: Colors.black87),
              ),
            );
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
        print(sval);
        streamController.add(sval);
        //Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => TmaMainApp()));
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

  void activityPermission() async{
    if (await Permission.activityRecognition.request().isGranted) {
    }

    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.activityRecognition,
    ].request();
    print(statuses[Permission.activityRecognition]);
  }

}
