import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tma_owners/income/result.dart';


class SelectTrip extends StatefulWidget {

  SelectTrip(this.date,this.bus);
  final DateTime date;
  final String bus;

  @override
  _SelectTripState createState() => _SelectTripState();
}

class _SelectTripState extends State<SelectTrip> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Trip'),
      ),
      body: Container(
          child: trips()
      ),
    );
  }
}

Widget trips(){
  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance.collection('triprecords').snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

      if (snapshot.hasError) {
        return Text('Something went wrong');
      }

      if (snapshot.connectionState == ConnectionState.waiting) {
        return Scaffold(
          body: Container(
            child: SpinKitDualRing(color: Colors.black87),
          ),
        );
      }

      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: new ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            return Container(
              color: Colors.white70,
              margin: const EdgeInsets.only(top: 5.0,bottom: 5.0),
              child: new OutlinedButton(
                onPressed: () {
                  print(document.id);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => TripResults(document.id)));
                },
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text(
                        '${document.data()['turnTime']}',
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black87
                        ),
                      ),
                      Text(
                        '${document.data()['tripName']}',
                        style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.black87
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
            //Card(child: Text(document.data()['name']??'default'),);
          }).toList(),
        ),
      );
    },
  );
}