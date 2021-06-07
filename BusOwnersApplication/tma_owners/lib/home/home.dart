import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tma_owners/auth/account.dart';
import 'package:tma_owners/home/complaints.dart';
import 'package:tma_owners/income/incomehome.dart';
import 'package:tma_owners/income/selectbus.dart';
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
        physics: NeverScrollableScrollPhysics(),
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

  final ValueNotifier<String> vnTotalIncome = ValueNotifier<String>('Loading');
  final ValueNotifier<String> vnTodayIncome = ValueNotifier<String>('Rs.0.0');
  final ValueNotifier<String> vnRCount = ValueNotifier<String>('Loading');

  @override
  Widget build(BuildContext context) {
    getIncome();
    return Scaffold(
      appBar: AppBar(
        title: Text("ezTransit"),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Container(
        color: Colors.grey.shade600,
        child: Padding(
          padding: const EdgeInsets.only(right:8,left: 8,top: 8,bottom: 16),
          child: Column(
            children: [
              Expanded(
                flex:5,
                child: Padding(
                  padding: const EdgeInsets.only(right:8,left: 8,top: 8,bottom: 0),
                  child: ElevatedButton(
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)),
                    onPressed: (){},
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("TOTAL INCOME",style: TextStyle(fontSize: 18,color: Colors.black87),),
                                  SizedBox(height: 8,),
                                  ValueListenableBuilder(
                                    builder: (BuildContext context, String value, Widget child) {
                                      return Text('$value', style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold,color: Colors.black87),
                                      );
                                    },
                                    valueListenable: vnTotalIncome,
                                  ),
                                  //Text("Rs. 1222000",style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold,color: Colors.black87),),
                                ],
                              ),
                            ],
                          ),
                          Divider(
                            thickness: 1.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("TODAY INCOME",style: TextStyle(fontSize: 18,color: Colors.black87),),
                                  SizedBox(height: 8,),
                                  ValueListenableBuilder(
                                    builder: (BuildContext context, String value, Widget child) {
                                      return Text('$value', style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold,color: Colors.black87),
                                      );
                                    },
                                    valueListenable: vnTodayIncome,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Divider(
                            thickness: 1.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("BUSES ON TRIPS",style: TextStyle(fontSize: 18,color: Colors.black87),),
                                  SizedBox(height: 8,),
                                  ValueListenableBuilder(
                                    builder: (BuildContext context, String value, Widget child) {
                                      return Text('$value', style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold,color: Colors.black87),
                                      );
                                    },
                                    valueListenable: vnRCount,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex:1,
                child: Padding(
                  padding: const EdgeInsets.only(right:8,left: 8,top: 8,bottom: 0),
                  child: ElevatedButton(
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Alerts()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("EMERGENCIES",style: TextStyle(fontSize: 16,color: Colors.black87),),
                        Icon(Icons.navigate_next,color: Colors.black87,)
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex:1,
                child: Padding(
                  padding: const EdgeInsets.only(right:8,left: 8,top: 8,bottom: 0),
                  child: ElevatedButton(
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Complaints()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("COMPLAINTS",style: TextStyle(fontSize: 16,color: Colors.black87),),
                        Icon(Icons.navigate_next,color: Colors.black87,)
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex:1,
                child: Padding(
                  padding: const EdgeInsets.only(right:8,left: 8,top: 8,bottom: 0),
                  child: ElevatedButton(
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SelectBus()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("SPECIFIC TRIP DETAILS",style: TextStyle(fontSize: 16,color: Colors.black87,),),
                        Icon(Icons.navigate_next,color: Colors.black87,)
                      ],
                    ),
                  ),
                ),//right:30,left: 30,top: 0,bottom: 30)
              ),
              Expanded(
                flex:1,
                child: Padding(
                  padding: const EdgeInsets.only(right:8,left: 8,top: 8,bottom: 0),
                  child: ElevatedButton(
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SelectBusMap()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("BUS LIVE LOCATIONS",style: TextStyle(fontSize: 16,color: Colors.black87),),
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

  void getIncome(){
    double c = 0.0;
    int tc = 0;
    FirebaseFirestore.instance.collection('triprecords').get().then((querySnapshot) {
      querySnapshot.docs.forEach((stopDoc) {
        c = c + stopDoc.data()['income'];
      });
      vnTotalIncome.value = 'Rs. '+c.toString();
    });

    FirebaseFirestore.instance.collection('buses').where('onTrip', isEqualTo: 'yes').get().then((querySnapshot) {
      querySnapshot.docs.forEach((stopDoc) {
        tc = tc+1;
      });
      vnRCount.value = tc.toString();
    });

  }
}

