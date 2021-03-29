import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tma_bus/screens/home/account.dart';
import 'package:tma_bus/screens/home/home.dart';
import 'package:tma_bus/screens/home/map.dart';
import 'package:tma_bus/screens/home/report.dart';
import 'package:tma_bus/screens/trip/trip.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:location/location.dart';

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

  int tripStatus = 0;

  @override
  void initState() {
    super.initState();
    widget.stream.listen((tripStatusValue) {
      mySetState(tripStatusValue);
    });
  }

  void mySetState(int tripStatusValue) {
    setState(() {
      tripStatus = tripStatusValue;
    });
  }

  @override
  Widget build(BuildContext context) {

    if(tripStatus == 0){
      print(tripStatus);
      return HomeView();
    }
    else{
      print('tripStatus');
      return TripView();
    }

  }
}
