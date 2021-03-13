import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Query users = FirebaseFirestore.instance
        .collection("routes")
        .where('stops', arrayContainsAny: ['Colombo']);

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
              title: new Text(
                  document.data()['start'] + ' - ' + document.data()['end']),
            );
          }).toList(),
        );
      },
    );
  }
}
