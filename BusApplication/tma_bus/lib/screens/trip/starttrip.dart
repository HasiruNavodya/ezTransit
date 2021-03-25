import 'package:flutter/material.dart';
import 'package:tma_bus/screens/home/trip.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TripNav extends StatefulWidget {
  @override
  _TripNavState createState() => _TripNavState();
}

class _TripNavState extends State<TripNav> {

  String trip = '1';
  String pickup = '1';
  Map buses;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('trips');

    return StreamBuilder<QuerySnapshot>(
      stream: users.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return new ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            return new ListTile(
              title: new Text(document.data()['name']),
              subtitle: new Text(document.data()['time']),
            );
          }).toList(),
        );
      },
    );
  }
}

void staetrfv(){
  print("asd");
}
