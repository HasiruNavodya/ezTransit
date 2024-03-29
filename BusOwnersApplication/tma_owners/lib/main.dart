import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tma_owners/auth/login.dart';
import 'package:tma_owners/home/home.dart';


int appState = 3;
StreamController<int> streamController = StreamController<int>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(OwnerApp());
}

class OwnerApp extends StatelessWidget {

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

    FirebaseAuth.instance.authStateChanges().listen((User user) {
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

  @override
  Widget build(BuildContext context) {

    if(appState == 0){
      return HomeView();
    }
    else{
      return LoginPage();
    }

  }
}

