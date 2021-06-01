import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Alerts extends StatefulWidget {
  @override
  _AlertsState createState() => _AlertsState();
}

class _AlertsState extends State<Alerts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ALERTS'),
        backgroundColor: Colors.black87,
        centerTitle: true,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
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
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text('${document.data()['busNo']}',
                                style: TextStyle(fontSize: 20.0, color: Colors.black87,),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text('${document.data()['type']}',
                                style: TextStyle(fontSize: 20.0, color: Colors.black87,),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text('${document.data()['location']}',
                                style: TextStyle(fontSize: 20.0, color: Colors.black87,),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text('${document.data()['time']}',
                                style: TextStyle(fontSize: 20.0, color: Colors.black87,),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text('${document.data()['text']}',
                                style: TextStyle(fontSize: 20.0, color: Colors.black87,),
                              ),
                            ],
                          ),
                        ],
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
