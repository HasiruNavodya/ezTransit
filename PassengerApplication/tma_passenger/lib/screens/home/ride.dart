import 'package:flutter/material.dart';

class RideDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Current Ride"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      //backgroundColor: Colors.red,
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Ride Details",
                style: TextStyle(),
              )
            ],
          ),
        ),
      ),
    );
  }
}