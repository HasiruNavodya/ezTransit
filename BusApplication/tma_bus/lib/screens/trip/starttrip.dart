import 'package:flutter/material.dart';
import 'package:tma_bus/screens/home/trip.dart';

class TripNav extends StatefulWidget {
  @override
  _TripNavState createState() => _TripNavState();
}

class _TripNavState extends State<TripNav> {

  String trip = '1';

  @override
  Widget build(BuildContext context) {

    if(trip=='1'){
      return Scaffold(
        appBar: AppBar(
          title: Text("screen1"),
        ),
        body: Container(
          child: Center(
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  trip = '2';
                });
              },
              child: Text('screen2'),
            ),
          ),
        ),
      );
    }

    else{
      return Scaffold(
        appBar: AppBar(
          title: Text("screen2"),
        ),
        body: Container(
          child: Center(
            child: ElevatedButton(
              onPressed: () {
                staetrfv();
                setState(() {
                  trip = '1';
                });
              },
              child: Text('screen1'),
            ),
          ),
        ),
      );
    }

  }
}

void staetrfv(){
  print("asd");
}
