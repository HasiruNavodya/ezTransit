import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tma_owners/income/selecttrip.dart';

String bus;
DateTime dateG;

class SelectBus extends StatefulWidget {

  //SelectBus(this.date);
  //final DateTime date;

  @override
  _SelectBusState createState() => _SelectBusState();
}

class _SelectBusState extends State<SelectBus> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SELECT BUS'),
        backgroundColor: Colors.black,
        //centerTitle: true,
      ),
      body: buses(),
    );
  }


  Widget buses(){
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('buses').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.hasData) {
          return Container(
            color: Colors.grey.shade300,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: new ListView(
                children: snapshot.data.docs.map((DocumentSnapshot document) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom:8.0),
                    child: new ElevatedButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)),
                      onPressed: () {
                        bus = document.data()['Plate Number'];
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SelectTrip(bus)));
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
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Container(
              child: SpinKitDualRing(color: Colors.black87),
            ),
          );
        }

        return Text('Something went wrong');
      },
    );
  }
}

