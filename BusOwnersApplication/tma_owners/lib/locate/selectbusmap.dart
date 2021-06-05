import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tma_owners/income/selecttrip.dart';
import 'map.dart';

String bus;
DateTime dateG;

class SelectBusMap extends StatefulWidget {

  @override
  _SelectBusMapState createState() => _SelectBusMapState();
}

class _SelectBusMapState extends State<SelectBusMap> {

  String user;

  @override
  void initState() {
    super.initState();

    FirebaseAuth auth = FirebaseAuth.instance;

    if (auth.currentUser != null) {
      print(auth.currentUser.email);
      user = auth.currentUser.email;
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SELECT BUS'),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: buses(),
    );
  }


  Widget buses(){
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('buses').where('Owner',isEqualTo: user).snapshots(),
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

        return Container(
          color: Colors.grey.shade300,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: new ListView(
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                return Container(
                  color: Colors.white,
                  margin: const EdgeInsets.only(top: 5.0,bottom: 5.0),
                  child: new ElevatedButton(
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)),
                    onPressed: () {
                      bus = document.data()['Plate Number'];
                      Navigator.push(context, MaterialPageRoute(builder: (context) => BusMap(bus)));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        children: [
                          Text(
                            '${document.data()['Plate Number']}',
                            style: TextStyle(
                                fontSize: 20.0,
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
          ),
        );
      },
    );
  }
}

