import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:tma_passenger/screens/home/bus_map.dart';
import 'package:tma_passenger/screens/home/ride.dart';
import 'package:tma_passenger/screens/home/user.dart';
import 'package:tma_passenger/screens/home/add_ride.dart';
import 'package:tma_passenger/screens/auth/signup.dart';
import 'package:tma_passenger/screens/auth/login.dart';


void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
<<<<<<< HEAD
    debugShowCheckedModeBanner: false,
    home: LoginPage()
    ),
=======
      debugShowCheckedModeBanner: false,
      home: MyHome()
  )
>>>>>>> dd8f0caa1adef6af65c5316e699ef36933b59924
  );
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
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        Navigator.push(context, MaterialPageRoute(builder: (context) => MyHome()));
      }
    });
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
        physics: NeverScrollableScrollPhysics(),
        // Add tabs as widgets
        children: <Widget>[MapView(), AddRide(), RideDetails(), UserDetails()],
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
              icon: Icon(Icons.add),
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