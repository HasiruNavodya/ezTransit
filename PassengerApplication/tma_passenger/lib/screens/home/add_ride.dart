import 'package:flutter/material.dart';
import 'package:tma_passenger/screens/addride/destination.dart';

class AddRide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ezTransit"),
        backgroundColor: Colors.black87,
        centerTitle: true,
      ),
      //backgroundColor: Colors.red,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/mapbg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              MaterialButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SelectDestination()),);
                },
                color: Colors.black87,
                textColor: Colors.white,
                child: Icon(
                  Icons.add,
                  size:40,
                ),
                padding: EdgeInsets.all(16),
                shape: CircleBorder(),
              ),
              Text(
                "\nAdd New Ride",
                style: TextStyle(
                  fontSize: 20,
                  //fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}