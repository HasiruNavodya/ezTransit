import 'package:flutter/material.dart';
import 'package:tma_passenger/screens/home/busmap.dart';
import 'package:tma_passenger/screens/home/ride.dart';
import 'package:tma_passenger/screens/home/user.dart';

void main() {
  runApp(MaterialApp(
    // Title
      title: "Using Tabs",
      // Home
      home: MyHome()));
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
    controller = TabController(length: 3, vsync: this);
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
        children: <Widget>[BusMapView(), RideDetails(), UserDetails()],
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