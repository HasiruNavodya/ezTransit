
import 'package:tma_passenger/screens/addride/buses.dart';
import 'package:flutter/material.dart';
import 'package:tma_passenger/screens/addride/pickup.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:async/async.dart';


class SelectPickup extends StatefulWidget {


  @override
  _SelectPickupState createState() => _SelectPickupState();
}

class _SelectPickupState extends State<SelectPickup> {

  TextEditingController _searchview = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Pickup Location"),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      //backgroundColor: Colors.red,
      body: Column(
        children: <Widget>[
          TextField(
            controller: _searchview,
            decoration: InputDecoration(
              prefixIcon:Icon(Icons.search),
              hintText: "Search Your Pickup Location",
            ),
          ),
          Expanded(
            child:

            StreamBuilder(


                stream: FirebaseFirestore.instance.collection("cities").snapshots(),

                builder: (context, snapshot) {
                  if(snapshot.data == null) return CircularProgressIndicator();
                  return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {

                      DocumentSnapshot cities = snapshot.data.docs[index];

                      return Card(
                        child:ListTile(
                          title: Text(cities['location']),
                          subtitle:Text(cities['name']),

                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SelectBus()),
                            );
                          },
                        ),
                      );

                    },

                  );
                }
            ),
          ),
        ],
      ) ,

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) => SelectBus()),
      //     );
      //   },
      //   child: Icon(Icons.arrow_forward_ios),
      //   backgroundColor: Colors.black87,
      // ),
    );
  }
}