import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';
import 'package:tma_passenger/screens/home/home.dart';
import 'package:tma_passenger/screens/ride/ride.dart';

int appState = 1;
StreamController<int> streamController = StreamController<int>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(TmaPassengerApp());
}

class TmaPassengerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TMA Passenger',
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
      print(appState);
      return HomeView();
    }
    else{
      print('tripStatus');
      return RideView();
    }

  }
}