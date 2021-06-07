import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

DateTime date;

class TripResults extends StatefulWidget {

  TripResults(this.trID);
  final String trID;

  @override
  _TripResultsState createState() => _TripResultsState();
}

class _TripResultsState extends State<TripResults> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TRIP INFORMATION'),
        backgroundColor: Colors.black,
      ),
      body: Container(
          child: trips()
      ),
    );
  }

  Widget trips(){
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection('triprecords').doc(widget.trID).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

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

        if (snapshot.hasData){

          Timestamp t = snapshot.data['date'];
          DateTime d = t.toDate();
          Timestamp st = snapshot.data['started'];
          DateTime s = st.toDate();
          Timestamp et = snapshot.data['stopped'];
          DateTime e = et.toDate();

          return Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black54),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text('BUS: ', style: TextStyle(fontSize: 18.0,)),
                              Text('' + '${snapshot.data['busNo']}', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Text(''),
                          Row(
                            children: [
                              Text('DATE: ', style: TextStyle(fontSize: 18.0,)),
                              Text('${d.year}'+'-${d.month}'+'-${d.day}', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Row(
                            children: [
                              Text('START CITY: ', style: TextStyle(fontSize: 18.0,)),
                              Text('' + '${snapshot.data['startCity']}', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Row(
                            children: [
                              Text('END CITY: ', style: TextStyle(fontSize: 18.0,)),
                              Text('' + '${snapshot.data['endCity']}', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Row(
                            children: [
                              Text('START TIME: ', style: TextStyle(fontSize: 18.0,)),
                              Text('' + '${snapshot.data['startTime']}', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Row(
                            children: [
                              Text('END TIME: ', style: TextStyle(fontSize: 18.0,)),
                              Text('' + '${snapshot.data['endTime']}', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Text(''),
                          Row(
                            children: [
                              Text('BUS STARTED TIME: ', style: TextStyle(fontSize: 18.0,)),
                              Text(DateFormat.Hm().format(snapshot.data['started'].toDate()).toString(), style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Row(
                            children: [
                              Text('BUS STOPPED TIME: ', style: TextStyle(fontSize: 18.0,)),
                              Text(DateFormat.Hm().format(snapshot.data['stopped'].toDate()).toString(), style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Text(''),
                          Row(
                            children: [
                              Text('TICKET COUNT: ', style: TextStyle(fontSize: 18.0,)),
                              Text('${snapshot.data['ticketCount']}', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Row(
                            children: [
                              Text('PEOPLE COUNT: ', style: TextStyle(fontSize: 18.0,)),
                              Text('${snapshot.data['IRCount']}', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Text(''),
                          Row(
                            children: [
                              Text('INCOME: ', style: TextStyle(fontSize: 18.0,)),
                              Text('${snapshot.data['income']}', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Text(''),
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            ),
          );
        }
        return Text('Something went wrong');
      },
    );
  }
}

