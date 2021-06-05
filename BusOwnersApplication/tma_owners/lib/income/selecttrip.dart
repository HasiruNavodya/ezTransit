import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:tma_owners/income/result.dart';


class SelectTrip extends StatefulWidget {

  SelectTrip(this.bus);
  //final DateTime date;
  final String bus;

  @override
  _SelectTripState createState() => _SelectTripState();
}

class _SelectTripState extends State<SelectTrip> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SELECT TRIP'),
        backgroundColor: Colors.black,
        //centerTitle: true,
      ),
      body: Container(
        color: Colors.grey.shade300,
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('triprecords').where('busNo',isEqualTo: widget.bus).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: new ListView(
                  children: snapshot.data.docs.map((DocumentSnapshot document) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom:8.0),
                      child: new ElevatedButton(
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)),
                        onPressed: () {
                          print(document.id);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => TripResults(document.id)));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(DateFormat.yMMMd().format(document.data()['date'].toDate()).toString(),
                                  style: TextStyle(
                                      fontSize: 19.0,
                                      color: Colors.black87,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),

                              Text('${document.data()['tripName']}',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black87
                                ),
                              ),
                              Text('${document.data()['turnTime']}',
                                style: TextStyle(
                                    fontSize: 16.0,
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
        ),
      ),
    );
  }
}
