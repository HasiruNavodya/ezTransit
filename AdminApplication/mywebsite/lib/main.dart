import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mywebsite/AddBusOwner.dart';
import 'package:mywebsite/AllBus.dart';
import 'package:mywebsite/Complaints.dart';
import 'package:mywebsite/Emergency.dart';
import 'package:mywebsite/Home%20View.dart';
import 'package:mywebsite/NewBus.dart';
import 'package:mywebsite/auth.dart';
import 'package:mywebsite/initializeTrip.dart';
import 'package:mywebsite/partial.dart';
import 'package:mywebsite/AddBusOwner.dart';

void main() async {
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
        theme: ThemeData(
          textTheme: GoogleFonts.latoTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        home: AuthService().handleAuth(),
        routes: {
          Home.id: (context) => Home(),
          NewBus.id: (context) => NewBus(),
          Emergency.id: (context) => Emergency(),
          Complaints.id: (context) => Complaints(),
          InitializeTrip.id: (context) => InitializeTrip(),
          Partial.id: (context) => Partial(),
          AddBusOwner.id: (context) => AddBusOwner(),
        });
  }
}
