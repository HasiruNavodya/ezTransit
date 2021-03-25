import 'package:flutter/material.dart';
import 'package:tma_passenger/screens/addride/confirm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert';

class SelectBus extends StatefulWidget {
  String pickuLocation;
  String destinationLocation;
  SelectBus(pickuploc,destinationloc)
  {
    this.pickuLocation=pickuploc;
    this.destinationLocation=destinationloc;
  }
  @override
  _SelectBusState createState() => _SelectBusState(pickuLocation,destinationLocation); //need to pass parameters here pickuLocation,destinationLocation
}


class _SelectBusState extends State<SelectBus> {
  String pickuLocation;
  String pno;
  String destinationLocation;
  String partName;

  _SelectBusState(pickuLocation, destinationLocation) {
    this.pickuLocation = pickuLocation;
    this.destinationLocation = destinationLocation;
    partName = '$destinationLocation' + '-' + '$pickuLocation';
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(partName);


  }

  @override
  Widget build(BuildContext context) {

    FirebaseFirestore.instance.collection('partialroutes').doc('$partName').get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print(documentSnapshot.data()['partNo']);
        pno = documentSnapshot.data()['partNo'];
        print(pno);
      }
    });

    Query buses = FirebaseFirestore.instance.collection('trips').where('parts', arrayContainsAny: ['p123']);
    return Scaffold(

      appBar: AppBar(
        title: Text("Select Bus"),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),

      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                GoogleMap(
                  //onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(6.844688, 80.015283), zoom: 15.0,),
                  myLocationEnabled: true,
                  // Add little blue dot for device location, requires permission from user
                  mapType: MapType.normal,
                  compassEnabled: true,
                  //onCameraMove: _onCameraMove,
                  //markers: _markers,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: StreamBuilder<QuerySnapshot>(
              stream: buses.snapshots(),
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
                      title: new Text(document.data()['name']),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
