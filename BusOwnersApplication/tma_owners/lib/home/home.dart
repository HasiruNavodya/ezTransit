import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tma_owners/auth/account.dart';
import 'package:tma_owners/income/incomehome.dart';
import 'package:tma_owners/income/selectdate.dart';
import 'package:tma_owners/locate/selectbusmap.dart';

import 'alerts.dart';

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
        children: <Widget>[Alerts(), HomeScreen(), Account()],
        controller: controller,
      ),
      bottomNavigationBar: Material(
        color: Colors.black,
        child: TabBar(
          tabs: <Tab>[
            Tab(
              icon: Icon(Icons.notification_important),
            ),
            Tab(
              icon: Icon(Icons.home),
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
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Expanded(
                flex:1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("LIFETIME INCOME",style: TextStyle(fontSize: 18),),
                    SizedBox(height: 8,),
                    Text("Rs. 1222000",style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
              Expanded(
                flex:1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("TODAY INCOME",style: TextStyle(fontSize: 18),),
                    SizedBox(height: 8,),
                    Text("Rs. 32000",style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
              Expanded(
                flex:1,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: OutlinedButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SelectDate()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("SPECIFIC TRIP DETAILS",style: TextStyle(fontSize: 16,color: Colors.black87),),
                        Icon(Icons.navigate_next,color: Colors.black87,)
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex:1,
                child: Padding(
                  padding: const EdgeInsets.only(right:30,left: 30,top: 0,bottom: 60),
                  child: OutlinedButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SelectBusMap()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("CHECK BUS LOCATIONS",style: TextStyle(fontSize: 16,color: Colors.black87),),
                        Icon(Icons.navigate_next,color: Colors.black87,)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

