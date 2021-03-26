
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mywebsite/auth.dart';
import 'package:mywebsite/map.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Transport Management Application',
     
      //home: MapClickPage(),
      home: AuthService().handleAuth(),
    );
  }
}
