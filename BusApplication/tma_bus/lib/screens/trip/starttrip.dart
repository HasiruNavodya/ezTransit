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

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc().get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data();
          return Text("Full Name: $data");
        }

        return Text("loading");
      },
    );
  }
}

void staetrfv(){
  print("asd");
}
