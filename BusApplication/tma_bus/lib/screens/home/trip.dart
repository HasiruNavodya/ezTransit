import 'package:flutter/material.dart';
import 'package:tma_bus/screens/trip/starttrip.dart';


class TripControlView extends StatefulWidget {
  @override
  _TripControlViewState createState() => _TripControlViewState();
}

class _TripControlViewState extends State<TripControlView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trip"),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      //backgroundColor: Colors.red,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          color: Colors.amber,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

