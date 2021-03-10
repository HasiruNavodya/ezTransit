import 'package:flutter/material.dart';

class ReportEmergencyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Report Emergency"),
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
                "report",
                style: TextStyle(),
              )
            ],
          ),
        ),
      ),
    );
  }
}