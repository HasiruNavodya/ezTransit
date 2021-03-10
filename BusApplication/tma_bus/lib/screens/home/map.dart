import 'package:flutter/material.dart';

class PassengerMapView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trip Map"),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      //backgroundColor: Colors.red,
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "passenger counts in bus stops shown in map",
                style: TextStyle(),
              )
            ],
          ),
        ),
      ),
    );
  }
}