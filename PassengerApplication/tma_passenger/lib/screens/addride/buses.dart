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
  _SelectBusState(pickuLocation,destinationLocation)
  {
    this.pickuLocation=pickuLocation;
    this.destinationLocation=destinationLocation;
    partName='$destinationLocation'+'-'+'$pickuLocation';
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
          print(partName);

    FirebaseFirestore.instance
        .collection('partialroutes')
        .doc('$partName')
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print(documentSnapshot.data()['partNo']);
       pno=documentSnapshot.data()['partNo'];
       print(pno);


      }
    });

  }
  @override
  Widget build(BuildContext context) {
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
                  initialCameraPosition: CameraPosition(target: LatLng(6.844688,80.015283), zoom: 15.0,),
                  myLocationEnabled: true, // Add little blue dot for device location, requires permission from user
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
            child: TripInfo(pickuLocation,destinationLocation,pno),
          )
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ConfirmTicket(destinationLocation,pickuLocation)),
          );
        },
        child: Icon(Icons.arrow_forward_ios),
        backgroundColor: Colors.black87,
      ),

    );
  }
}

class TripInfo extends StatefulWidget {
  String pickuLocation;
  String destinationLocation;
  String pno;
  TripInfo(pickuLocation,destinationLocation,pno)
  {
    this.pickuLocation=pickuLocation;
    this.destinationLocation=destinationLocation;
    this.pno=pno;
  }

  @override
  _TripInfoState createState() => _TripInfoState(pno);
}

class _TripInfoState extends State<TripInfo> {
  String pno;
  _TripInfoState(pno)
  {
    this.pno=pno;
    print("hy "+pno);

  }
  @override
  Widget build(BuildContext context) {


    return StreamBuilder<QuerySnapshot>(

      stream: FirebaseFirestore.instance.collection("trips").where('parts', arrayContains: pno ).snapshots(),

      builder: (context,snapshot) {
        if(snapshot.data == null) return CircularProgressIndicator();
        if(snapshot.hasError){
          return Text("Error ${snapshot.error}");
        }
        switch(snapshot.connectionState) {
          case ConnectionState.none:
            return Text("Not date Present");

          case ConnectionState.done:
            return Text("Done!");

          default :
            final List<DocumentSnapshot> documents = snapshot.data.docs;
            return new ListView(
                children: documents
                    .map((doc) => Card(
                  child: ListTile(
                      title: Text(doc['name']),
                      subtitle: Text(doc['startTime']),
                      //
                      // onTap: () {
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(builder: (context) => SelectPickup((doc['location'])), //need to pass parameters here (doc['location'])
                      //     ),
                      //   );
                      // }

                  ),
                ))
                    .toList());


        }
      },
    );
  }
}





/*
ListView(Text(document.data()['desc'])
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            return ListTile(
              title: new Text(document.data()['desc']),
              subtitle: new Text(document.data()['start'] + document.data()['end']),
            );
          }).toList(),
        );
 */






/*
ListView(Text(document.data()['desc'])
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            return ListTile(
              title: new Text(document.data()['desc']),
              subtitle: new Text(document.data()['start'] + document.data()['end']),
            );
          }).toList(),
        );
 */
