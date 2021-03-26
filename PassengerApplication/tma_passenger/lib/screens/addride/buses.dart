import 'package:flutter/material.dart';
import 'package:tma_passenger/screens/addride/confirm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';

String pnoSet = 'no';
String partNameGlobal;
String pno;
String numPlate;
String luxaryLevel;
String privatePub;
String noplate;

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
    partNameGlobal = partName;
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(partName);

    if(pnoSet == 'no'){
      getpno();
    }
  }

  void getpno(){
    FirebaseFirestore.instance.collection('partialroutes').doc('$partNameGlobal').get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print(documentSnapshot.data()['partNo']);
        pno = documentSnapshot.data()['partNo'];
        print(pno);
        setState(() {
          pnoSet = 'yes';
        });
      }
    });
  }



  final spinkit = SpinKitFadingCircle(
    itemBuilder: (BuildContext context, int index) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: index.isEven ? Colors.red : Colors.green,
        ),
      );
    },
  );

  @override
  Widget build(BuildContext context) {

    //Query buses = FirebaseFirestore.instance.collection('trips').where('parts', arrayContainsAny: [pno]);

    if(pnoSet == 'yes'){
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

                stream:FirebaseFirestore.instance.collection('trips').where('parts', arrayContains: pno).snapshots(),
                builder: (context,snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading");
                  }

                  return new ListView(
                    children: snapshot.data.docs.map((DocumentSnapshot document) {
                      FirebaseFirestore.instance.collection('NewBus').doc('${document.data()['bus']}').get().then((DocumentSnapshot documentSnapshot) {
                        print('gg ' + document.data()['bus']);
                        if (documentSnapshot.exists) {
                          // print(documentSnapshot.data()['Luxury Level']);
                          luxaryLevel = documentSnapshot.data()['Luxury Level'];
                          privatePub= documentSnapshot.data()['Public or Private'];
                          //print('sfdfvvbvbvb'+documentSnapshot.data()['Luxury Level']);
                          //return luxaryLevel;


                        }
                      }
                      );


                      return Container(

                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text('Pickup At: '+document.data()['startTime']+'                                 Free Seats:',
                                    style: TextStyle(fontWeight: FontWeight.w500)),
                                Text(''),

                                Text(document.data()['name']+'                          Standing:',
                                    style: TextStyle(fontWeight: FontWeight.w500)),
                                Text(''),

                                Text(document.data()['startTime']+'-'+document.data()['endTime']+'                                           '+luxaryLevel,
                                    style: TextStyle(fontWeight: FontWeight.w500)),
                                Text(''),

                                Text('km'+'                     min                                 '+privatePub,
                                    style: TextStyle(fontWeight: FontWeight.w500)),
                                Text(''),


                              ],

                            ),
                          ),
                        ),
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


    else{
      return Scaffold(
        appBar: AppBar(
          title: Text("Loading"),
          backgroundColor: Colors.black,
          centerTitle: true,
        ),

        body: spinkit,
      );

    }

  }

  // String getLux(){
  //   FirebaseFirestore.instance.collection('NewBus').doc('$numPlate').get().then((DocumentSnapshot documentSnapshot) {
  //     // print('gg '+numPlate);
  //     if (documentSnapshot.exists) {
  //       // print(documentSnapshot.data()['Luxury Level']);
  //       luxaryLevel = documentSnapshot.data()['Luxury Level'];
  //       // print('sfdf'+luxaryLevel);
  //       return luxaryLevel;
  //
  //
  //
  //     }
  //   });
  // }
}

// String gg()
// {
//   String dfs='rakshi';
//   return dfs;
// }

// void noPlate()
// {
//   FirebaseFirestore.instance.collection('NewBus').doc('$partNameGlobal').get().then((DocumentSnapshot documentSnapshot) {
//     if (documentSnapshot.exists) {
//       print(documentSnapshot.data()['partNo']);
//       pno = documentSnapshot.data()['partNo'];
//       print(pno);
//     }

