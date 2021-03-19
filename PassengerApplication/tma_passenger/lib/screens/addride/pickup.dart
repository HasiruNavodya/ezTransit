
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

  TextEditingController textEditingController = TextEditingController();
  String searchString;

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
          Expanded(
            child:Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15.0) ,
                  child: Container(
                    child: TextField(
                      onChanged: (val){
                        setState(() {
                          searchString = val.toLowerCase();
                        });
                      },
                      controller: textEditingController,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(Icons.search),


                          ),
                          hintText:'Search Your Pickup Location',
                          hintStyle: TextStyle(
                              fontFamily: 'Antra',color: Colors.blueGrey)),
                    ),
                  ),
                ),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(



                    stream: (searchString == null || searchString.trim()== '')
                        ?FirebaseFirestore.instance.collection("cities").snapshots()
                        :FirebaseFirestore.instance.collection("cities").where('searchIndex', arrayContains: searchString).snapshots(),
                    builder: (context,snapshot){
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
                                    title: Text(doc['location']),
                                    subtitle: Text(doc['name']),

                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => SelectBus()),
                                      );
                                    }

                                ),
                              ))
                                  .toList());


                      }
                    },
                  ),
                ),


              ],

            ),
          ),
        ],
      ),
    );
  }

}


