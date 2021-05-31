import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tma_bus/screens/auth/login.dart';
import 'package:tma_bus/screens/home/account.dart';
import 'package:tma_bus/screens/home/home.dart';
import 'package:tma_bus/screens/home/map.dart';
import 'package:tma_bus/screens/home/report.dart';
import 'package:tma_bus/screens/trip/trip.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:location/location.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'screens/home/addtrip.dart';

int appState = 3;
StreamController<int> streamController = StreamController<int>();
StreamController<String> tripIDStream = StreamController<String>();
String tripID;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(TmaMainApp());
}

class TmaMainApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TMA',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ViewController(streamController.stream,tripIDStream.stream),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ViewController extends StatefulWidget {

  ViewController(this.stream,this.tripstream);
  final Stream<int> stream;
  final Stream<String> tripstream;

  @override
  _ViewControllerState createState() => _ViewControllerState();
}

class _ViewControllerState extends State<ViewController> {

  @override
  void initState() {
    super.initState();

    widget.stream.listen((appStateValue) {
      mySetState(appStateValue);
    });

    widget.tripstream.listen((tripidval) {
      setTrip(tripidval);
    });

    FirebaseAuth.instance
        .authStateChanges()
        .listen((User user) {
      if (user == null) {
        mySetState(2);
        print('User is currently signed out!');
      } else {
        mySetState(0);
        print('User is signed in!');
      }
    });

  }

  void mySetState(int appStateValue) {
    setState(() {
      appState = appStateValue;
    });
  }

  void setTrip(String tripidval) {
      tripID = tripidval;
  }

  @override
  Widget build(BuildContext context) {

    if(appState == 0){
      return HomeView();
    }
    else if(appState == 1){
      TripView().setTripID(tripID);
      return TripView();
    }
    else{
      return LoginPage();
    }

  }

}
