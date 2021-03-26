import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

 class Emergency extends StatefulWidget {
   @override
   _EmergencyState createState() => _EmergencyState();
 }
 
 class _EmergencyState extends State<Emergency> {
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: Text('All Emergencies'),

       ),
      /* body:StreamBuilder (
         stream: FirebaseFirestore.instance.collection('trips').snapshots(),
         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot ){
          /*if(!snapshot.hasData){
             return Text('No Value');
           }*/
           return ListView(
             children: snapshot.data.docs.map((DocumentSnapshot document){
              
               return Text(document.data()['name']);

             }).toList(),
           );
         },
          ) ,*/
         

   body: StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('NewBus').snapshots(),
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
              title: new Text(document.data()['Color']),
              subtitle: new Text(document.data()['Driver Name']),
            );
          }).toList(),
        );
      },
     ));
     
   }
 }