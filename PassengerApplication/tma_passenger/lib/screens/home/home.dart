import 'package:flutter/material.dart';

import 'package:tma_passenger/screens/home/bus_map.dart';
import 'package:tma_passenger/screens/home/ride.dart';
import 'package:tma_passenger/screens/home/user.dart';
import 'package:tma_passenger/screens/home/add_ride.dart';


class HomeView extends StatefulWidget {
  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[MapView(), AddRide(), UserDetails()],
        controller: controller,
      ),

      bottomNavigationBar: Material(
        color: Colors.black,
        child: TabBar(
          tabs: <Tab>[
            Tab(
              icon: Icon(Icons.map),
            ),
            Tab(
              icon: Icon(Icons.directions_bus),
            ),
            Tab(
              icon: Icon(Icons.person),
            ),
          ],
          controller: controller,
        ),
      ),
    );
  }
}