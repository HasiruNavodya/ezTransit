import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tma_bus/screens/home/account.dart';
import 'package:tma_bus/screens/home/map.dart';
import 'package:tma_bus/screens/home/report.dart';
import 'package:tma_bus/screens/home/addtrip.dart';
import 'package:tma_bus/screens/trip/trip.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:location/location.dart';
//import 'package:permission_handler/permission_handler.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 4, vsync: this);
    locationPermission();
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
        children: <Widget>[MapView(), AddTripView(), ReportEmergencyView(), Account()],
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
              icon: Icon(Icons.report_problem),
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

  void locationPermission() async{
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
  }



}
