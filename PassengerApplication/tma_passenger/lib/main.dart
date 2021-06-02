import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:async';
import 'package:tma_passenger/screens/home/home.dart';
import 'package:tma_passenger/screens/ride/ride.dart';
import 'package:tma_passenger/screens/auth/login.dart';
import 'package:tma_passenger/screens/auth/signup.dart';

String appState = '1';
StreamController<String> streamController = StreamController<String>();

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
      /*theme: ThemeData(
        primarySwatch: Colors.blue,
        //fontFamily: 'Nexa',
      ),*/
      home: ViewController(streamController.stream),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ViewController extends StatefulWidget {
  ViewController(this.stream);
  final Stream<String> stream;

  @override
  _ViewControllerState createState() => _ViewControllerState();
}

class _ViewControllerState extends State<ViewController> {

  void setAppState(String appStateValue) {
    setState(() {
      appState = appStateValue;
    });
  }

  @override
  void initState() {
    super.initState();



    widget.stream.listen((appStateValue) {
      setAppState(appStateValue);
    });

    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
        print('User is currently signed out!');
        setAppState('2');
      } else {
        print('User is signed in!');

        setAppState('0');

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (appState == '0') {
      print(appState);
      return HomeView();
    }
    else if (appState == '1') {
      return Scaffold(
        body: Container(
          child: SpinKitDualRing(color: Colors.black87),
        ),
      );
    }
    else if (appState == '2') {
      print(appState);
      return LoginPage();
    }
    else {
      print(appState);
      return RideView(appState);
    }
  }
}
