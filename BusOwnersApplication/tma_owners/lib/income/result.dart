import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
        title: Text('Trip Details'),
      ),
      body: Container(
          child: trips()
      ),
    );
  }
}

Widget trips(){
  return StreamBuilder<DocumentSnapshot>(
    stream: FirebaseFirestore.instance.collection('triprecords').doc('rak2J6sVCJjZTyV8DHZZ').snapshots(),
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

        return Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 200.0,
                    height: 300.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('' + '${snapshot.data['tripName']}', style: TextStyle(fontSize: 18.0,)),
                        Text('' + '${snapshot.data['turnTime']}', style: TextStyle(fontSize: 18.0,)),
                        Text('' + '${snapshot.data['busNo']}', style: TextStyle(fontSize: 18.0,)),
                        Text('' + '${d.year}'+'-${d.month}'+'-${d.day}', style: TextStyle(fontSize: 18.0,)),
                        Text(''),
                        Text('Started Time: ' + '${s.hour}'+':${s.minute}', style: TextStyle(fontSize: 18.0,)),
                        Text('Stopped Time: ' + '${e.hour}'+':${e.minute}', style: TextStyle(fontSize: 18.0,)),
                        Text(''),
                        Text('Ticket Count:' + '${snapshot.data['ticketCount']}', style: TextStyle(fontSize: 18.0,)),
                        Text('People Count: ' + '${snapshot.data['IRCount']}', style: TextStyle(fontSize: 18.0,)),
                        Text(''),
                        Text('Income: Rs.' + '${snapshot.data['income']}', style: TextStyle(fontSize: 18.0,)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }
      return null;
    },
  );
}