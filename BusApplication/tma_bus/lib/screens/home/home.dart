import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tma_bus/screens/home/account.dart';
import 'package:tma_bus/screens/home/map.dart';
import 'package:tma_bus/screens/home/report.dart';
import 'package:tma_bus/screens/home/addtrip.dart';
import 'package:location/location.dart';
import 'package:intl/intl.dart';
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
    controller = TabController(length: 3, vsync: this, initialIndex: 1);
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
        children: <Widget>[MapView(), HomeScreen(), Account()],
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

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ezTransit"),
        backgroundColor: Colors.black87,
        centerTitle: true,
      ),
      //backgroundColor: Colors.red,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/mapbg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Opacity(
                  opacity: 0.8,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: StreamBuilder(
                        stream: Stream.periodic(const Duration(seconds: 1)),
                        builder: (context, snapshot) {
                          return Center(
                            child: Opacity(
                              opacity: 1.0,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  DateFormat().add_jms().format(DateTime.now()),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 40,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //SizedBox(height: 160,),
                    MaterialButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AddTripView()),);
                      },
                      color: Colors.black87,
                      textColor: Colors.white,
                      child: Icon(
                        Icons.play_arrow,
                        size:40,
                        color: Colors.yellow,
                      ),
                      padding: EdgeInsets.all(16),
                      shape: CircleBorder(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "START NEW TRIP",
                        style: TextStyle(
                          fontSize: 20,
                          //fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton.icon(
                      label: Text("REPORT PROBLEM",
                        style: TextStyle(
                          //fontSize: 20,
                          //fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      icon: Icon(Icons.report_problem,color: Colors.red,),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ReportEmergencyView()),);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
