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

int appState = 3;
StreamController<int> streamController = StreamController<int>();

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
      home: ViewController(streamController.stream),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ViewController extends StatefulWidget {

  ViewController(this.stream);
  final Stream<int> stream;

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
  }

  void mySetState(int appStateValue) {
    setState(() {
      appState = appStateValue;
    });
  }

  @override
  Widget build(BuildContext context) {

    if(appState == 0){
      return HomeView();
    }
    else if(appState == 1){
      return TripView();
    }
    else{
      return LoginPage();
    }

  }
}
