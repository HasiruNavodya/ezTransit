import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tma_owners/auth/account.dart';
import 'package:tma_owners/income/incomehome.dart';
import 'package:tma_owners/income/selectdate.dart';
import 'package:tma_owners/locate/selectBus.dart';

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
        children: <Widget>[SelectDate(), SelectBusToLocate(), Account()],
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
}

