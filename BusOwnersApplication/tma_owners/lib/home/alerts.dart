import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:tma_owners/locate/map.dart';

class Alerts extends StatefulWidget {
  @override
  _AlertsState createState() => _AlertsState();
}

class _AlertsState extends State<Alerts> {

  String bus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ALERTS'),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Container(
        color: Colors.grey.shade300,
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('emergencies').snapshots(),
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
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 6,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text('BUS: ',
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black87,
                                            ),
                                          ),
                                          Text('${document.data()['busNo']}',
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 3.0,),
                                      Row(
                                        children: [
                                          Text('TYPE: ',
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black87,
                                            ),
                                          ),
                                          Text('${document.data()['type']}',
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.black87,),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 3.0,),
                                      Row(
                                        children: [
                                          Text('TIME: ',
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black87,
                                            ),
                                          ),
                                          Text(DateFormat.yMMMd().add_Hm().format(document.data()['time'].toDate()).toString(),
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.black87,),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 3.0,),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          OutlinedButton(
                                            onPressed: () {
                                              bus = document.data()['busNo'];
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => BusMap(bus)));
                                            },
                                            child: Text('Show Location',
                                              style: TextStyle(
                                                //fontSize: 20.0,document.data()['location']
                                                color: Colors.black87,),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Divider(),
                            Row(
                              children: [
                                Flexible(
                                  child: Text('Description: '+'${document.data()['text']}',
                                    style: TextStyle(
                                      //fontSize: 20.0,
                                      color: Colors.black87,),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
