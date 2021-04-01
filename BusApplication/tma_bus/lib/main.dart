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
String tripID;
StreamController<int> streamController = StreamController<int>();
StreamController<String> tripIdStream = StreamController<String>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(TmaBusApp());
}

class TmaBusApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TMA',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ViewController(streamController.stream, tripIdStream.stream),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ViewController extends StatefulWidget {

  ViewController(this.stream1,this.stream2);
  final Stream<int> stream1;
  final Stream<String> stream2;

  @override
  _ViewControllerState createState() => _ViewControllerState();
}

class _ViewControllerState extends State<ViewController> {

  @override
  void initState() {
    super.initState();

    widget.stream1.listen((appStateValue) {
      setAppState(appStateValue);
    });

    widget.stream2.listen((trid) {
      setTripID(trid);
    });

    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
        setAppState(2);
        print('User is currently signed out!');
      } else {
        setAppState(0);
        print('User is signed in!');
      }
    });

  }

  void setAppState(int appStateValue) {
    setState(() {
      appState = appStateValue;
    });
  }

  void setTripID(String trid) {
      tripID = trid;
  }

  @override
  Widget build(BuildContext context) {

    if(appState == 0){
      return HomeView();
    }
    else if(appState == 1){
      return TripView(tripID);
    }
    else{
      return LoginPage();
    }

  }
}
