
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tma_passenger/screens/addride/buses.dart';
import 'package:flutter/material.dart';
import 'package:tma_passenger/screens/addride/pickup.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:async/async.dart';

import 'destination.dart';


class SelectPickup extends StatefulWidget {
  String destinationLocation;
  SelectPickup(sk)
  {
    this.destinationLocation=sk;
  }

  @override
  _SelectPickupState createState() => _SelectPickupState(destinationLocation); //need to pass parameters here destinationLocation
}

class _SelectPickupState extends State<SelectPickup> {
  String destinationLocation;
  _SelectPickupState(destinationLocation)
  {
    this.destinationLocation=destinationLocation;
  }

  TextEditingController textEditingController = TextEditingController();
  String searchString;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SELECT DESTINATION"),
        backgroundColor: Colors.black87,
        centerTitle: true,
      ),
      //backgroundColor: Colors.red,
      body: Container(
        color: Colors.white,
        child: Column(

          children: <Widget>[
            Expanded(
              child:Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Card(
                      shadowColor: Colors.grey,
                      child: TextField(
                        onChanged: (val) {
                          setState(() {
                            searchString = val.toLowerCase();
                          });
                        },
                        controller: textEditingController,
                        decoration: InputDecoration(
                            labelText: 'Search for Destination',
                            border: OutlineInputBorder(),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.search),
                            ),
                            //hintText: 'Search Your Destination',
                            hintStyle: TextStyle(
                                fontFamily: 'Antra', color: Colors.blueGrey)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: StreamBuilder<QuerySnapshot>(



                        stream: (searchString == null || searchString.trim()== '')
                            ?FirebaseFirestore.instance.collection("cities").snapshots()
                            :FirebaseFirestore.instance.collection("cities").where('searchIndex', arrayContains: searchString).snapshots(),

                        builder: (context,snapshot){
                          if(snapshot.data == null) return SpinKitDualRing(color: Colors.black87);

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
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 7,
                                          child: ListTile(
                                              title: Text(doc['location'],
                                                style: TextStyle(
                                                  fontSize: 19,
                                                ),
                                              ),
                                              subtitle: Text(doc['name']),
                                              onTap: () {
                                                Navigator.push(context,MaterialPageRoute(builder: (context) => SelectBus((doc['location']),destinationLocation)));
                                              }),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            color: Colors.blueGrey.shade700,
                                            size: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ))
                                      .toList());


                          }
                        },
                      ),
                    ),
                  ),
//Navigator.push(context,MaterialPageRoute(builder: (context) => SelectBus((doc['location']),destinationLocation)));

                ],

              ),
            ),
          ],
        ),
      ),
    );
  }

}


