/*import 'package:cloud_firestore/cloud_firestore.dart';
   import 'package:flutter/material.dart';
   import 'package:flutter/widgets.dart';

    class LoadDataFromFirestore extends StatefulWidget {
      @override
      _LoadDataFromFirestoreState createState() => _LoadDataFromFirestoreState();
    }

    class _LoadDataFromFirestoreState extends State<LoadDataFromFirestore> {
      @override
      void initState() {
        super.initState();
        getDriversList().then((results) {
          setState(() {
            querySnapshot = results;
          });
        });
      }

      QuerySnapshot querySnapshot;
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          body: _showDrivers(),
        );
      }

    //build widget as prefered
    //i'll be using a listview.builder
      Widget _showDrivers() {
        //check if querysnapshot is null
        if (querySnapshot != null) {
          return ListView.builder(
            primary: false,
            itemCount: querySnapshot.docs.length,
            padding: EdgeInsets.all(12),
            itemBuilder: (context, i) {
              return Column(
                children: <Widget>[
//load data into widgets
                  Text("${querySnapshot.docs[i].data()['License Number']}"),
                  Text("${querySnapshot.docs[i].data()['Plate Number']}"),
                  Text("${querySnapshot.docs[i].data()['Driver Name']}"),
                  Text("${querySnapshot.docs[i].data()['Color']}"),
                  Text("${querySnapshot.docs[i].data()['Public or Private']}"),
                  Text("${querySnapshot.docs[i].data()['Luxery Level']}"),
                  Text("${querySnapshot.docs[i].data()['Seat Count']}"),
                ],
              );
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      }

      //get firestore instance
      getDriversList() async {
        return await FirebaseFirestore.instance.collection('NewBus').get();
      }
    }*/ 


