import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tma_bus/screens/home/account.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:location/location.dart';
import 'package:tma_bus/screens/home/income.dart';
import 'package:tma_bus/screens/home/locate.dart';
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
    controller = TabController(length: 3, vsync: this);
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
        //physics: NeverScrollableScrollPhysics(),
        children: <Widget>[Income(), Locate(), Account()],
        controller: controller,
      ),
      bottomNavigationBar: Material(
        color: Colors.black,
        child: TabBar(
          tabs: <Tab>[
            Tab(
              icon: Icon(Icons.money),
            ),
            Tab(
              icon: Icon(Icons.location_on),
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

