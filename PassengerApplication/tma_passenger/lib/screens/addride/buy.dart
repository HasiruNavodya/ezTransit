import 'package:flutter/material.dart';
import 'package:tma_passenger/main.dart';
import 'package:tma_passenger/screens/addride/buses.dart';
import 'package:tma_passenger/screens/home/ride.dart';

class BuyTicket extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pay"),
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
                "PayHere",
                style: TextStyle(),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => RideDetails()),
                (Route<dynamic> route) => false,
          );
        },
        child: Icon(Icons.arrow_forward_ios),
        backgroundColor: Colors.black87,
      ),
    );
  }
}