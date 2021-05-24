import 'package:flutter/material.dart';
import 'package:tma_passenger/screens/addride/pickup.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tma_passenger/screens/home/add_ride.dart';
import 'package:tma_passenger/screens/home/home.dart';

class SelectDestination extends StatefulWidget {
  SelectDestination({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SelectDestinationState createState() => _SelectDestinationState();
}

class _SelectDestinationState extends State<SelectDestination> {
  final geo = Geoflutterfire();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  TextEditingController textEditingController = TextEditingController();
  String searchString;
  String destiLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
/*        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            }),*/
        title: Text("Select Destination"),
        backgroundColor: Colors.black87,
        centerTitle: true,
      ),
      body: Container(
        //color: Colors.grey.shade50,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Column(
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
                            labelText: 'Search Destination City',
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
                        stream: FirebaseFirestore.instance
                            .collection("cities")
                            .where('searchIndex', arrayContains: searchString)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.data == null)
                            return CircularProgressIndicator();
                          if (snapshot.hasError) {
                            return Text("Error ${snapshot.error}");
                          }
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                              return Text("Not date Present");

                            case ConnectionState.done:
                              return Text("Done!");

                            default:
                              final List<DocumentSnapshot> documents =
                                  snapshot.data.docs;
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
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                SelectPickup((doc[
                                                                    'location'])), //need to pass parameters here (doc['location'])
                                                          ),
                                                        );
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
