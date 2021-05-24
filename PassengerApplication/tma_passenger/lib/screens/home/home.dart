import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tma_passenger/screens/addride/destination.dart';

import 'package:tma_passenger/screens/home/bus_map.dart';
import 'package:tma_passenger/screens/home/ride.dart';
import 'package:tma_passenger/screens/home/user.dart';
import 'package:tma_passenger/screens/home/add_ride.dart';

import 'complains.dart';


class HomeView extends StatefulWidget {
  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this, initialIndex: 1);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return scaff();
  }

  Widget scaff(){
    return Scaffold(

      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[MapView(), AddRide(), /*Complaints(),*/UserDetails()],
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
/*            Tab(
              icon: Icon(Icons.person),
            ),*/
          ],
          controller: controller,
        ),
      ),
    );
  }

  Widget newui(){
    return Scaffold(
      //appBar: AppBar(
        //title: Text(''),
      //),
      body: Container(
        color: Colors.white70,
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Welcome to ezTransit!",
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(78.0),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(minWidth: double.infinity, minHeight: double.infinity),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.blueGrey.shade500),
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                      ),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Icon(Icons.add_circle),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text("New Ride"),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      onPressed: (){},
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(minWidth: double.infinity, minHeight: double.infinity),
                          child: ElevatedButton(
                            onPressed: (){},
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(minWidth: double.infinity, minHeight: double.infinity),
                          child: ElevatedButton(
                            onPressed: (){},
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(minWidth: double.infinity, minHeight: double.infinity),
                          child: ElevatedButton(
                            onPressed: (){},
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
              ),
            ),
          ],
        ),
      ),
    );
  }
}

