import 'package:firebase_auth/firebase_auth.dart';
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
import 'package:intl/intl.dart';



String busNo;
int sval = 1;
String busEmail;
String bus;
String startcity;
String endcity;
String endtime;
String starttime;
String tripname;
int ticketcount;
String currentdate;

void getCurrentDate() {
  currentdate=DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now());
}

// ignore: must_be_immutable
class AddTripView extends StatefulWidget {

  String tripID;

  @override
  _AddTripViewState createState() => _AddTripViewState();
}

class _AddTripViewState extends State<AddTripView> {

  @override
  void initState() {
    super.initState();

    FirebaseAuth auth = FirebaseAuth.instance;

    if (auth.currentUser != null) {
      print(auth.currentUser.email);
      busEmail = auth.currentUser.email;
      List list = busEmail.split('@');
      bus = list[0].toString().toUpperCase();
      print(bus);


    }


    activityPermission();


  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('SELECT TRIP'),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('trips').where('bus', isEqualTo: bus).snapshots(),
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

          return Container(
            color: Colors.grey.shade300,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: new ListView(
                children: snapshot.data.docs.map((DocumentSnapshot document) {
                  starttime= document.data()['startTime'];
                  endtime= document.data()['endTime'];
                  startcity= document.data()['startCity'];
                  endcity= document.data()['endCity'];
                  tripname= document.data()['name'];
                  ticketcount= document.data()['ticketCount'];
                  return Container(
                    //color: Colors.white,
                    margin: const EdgeInsets.only(top: 5.0,bottom: 5.0),
                    child: new ElevatedButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)),
                      onPressed: () {
                        tripID = document.data()['tripID'];
                        print(tripID);
                        print(busNo);
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
                                  fontSize: 17.0,
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
        getCurrentDate();


        Map<String, dynamic> data = {
          "IRCount":'0',
          "busNo": bus,
          "busOwner": busEmail,
          "date": FieldValue.serverTimestamp(),
          "endCity": endcity,
          "endTime": endtime,
          "income":0,
          "startCity": startcity,
          "startTime": starttime,
          "started": currentdate,
          "stopped":'',
          "tripID": tripID,
          "tripName": tripname,
          "ticketCount": ticketcount,
          "turnTime": '0',
          //"Owner": owneremail.text,
        };


        FirebaseFirestore.instance
            .collection('triprecords')
            .doc('$tripID')
            .set(data);


        print(sval);
        streamController.add(sval);
        tripIDStream.add(tripID);
        Navigator.pop(context);
        Navigator.of(context).popUntil((route) => route.isFirst);
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
