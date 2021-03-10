import 'package:flutter/material.dart';
import 'package:tma_bus/screens/home/account.dart';
import 'package:tma_bus/screens/home/map.dart';
import 'package:tma_bus/screens/home/report.dart';
import 'package:tma_bus/screens/home/trip.dart';
import 'package:tma_bus/screens/trip/starttrip.dart';
import 'package:tma_bus/database/dbtasks.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {

  runApp(MaterialApp(
    // Title
      title: "Using Tabs",
      // Home
      home: MyHome()));
  await Firebase.initializeApp();
}

class MyHome extends StatefulWidget {
  @override
  MyHomeState createState() => MyHomeState();
}

// SingleTickerProviderStateMixin is used for animation
class MyHomeState extends State<MyHome> with SingleTickerProviderStateMixin {
  // Create a tab controller
  TabController controller;

  @override
  void initState() {
    super.initState();

    // Initialize the Tab Controller
    controller = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    // Dispose of the Tab Controller
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        // Add tabs as widgets
        children: <Widget>[PassengerMapView(), TripControlView(), ReportEmergencyView(), Account()],
        // set the controller
        controller: controller,
      ),
      // Set the bottom navigation bar
      bottomNavigationBar: Material(
        // set the color of the bottom navigation bar
        color: Colors.black,
        // set the tab bar as the child of bottom navigation bar
        child: TabBar(
          tabs: <Tab>[
            Tab(
              // set icon to the tab
              icon: Icon(Icons.map),
            ),
            Tab(
              icon: Icon(Icons.directions_bus),
            ),
            Tab(
              icon: Icon(Icons.report_problem),
            ),
            Tab(
              icon: Icon(Icons.person),
            ),

          ],
          // setup the controller
          controller: controller,
        ),
      ),
    );
  }
}