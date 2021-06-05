import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:mywebsite/SideBar.dart';
import 'package:geocoder/geocoder.dart';
import 'package:mywebsite/busmap.dart';

class Emergency extends StatefulWidget {
  static const String id = 'emergency';
  @override
  _EmergencyState createState() => _EmergencyState();
}

class _EmergencyState extends State<Emergency> {
  SideBarWidget _sideBar = SideBarWidget();
  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Emergency'),
      ),
      sideBar: _sideBar.sideBarMenus(context, Emergency.id),
      body: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('emergencies').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Text('No Value');
            }
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 40, horizontal: 50),
              child: ListView(
                children: snapshot.data.docs.map(
                  (DocumentSnapshot document) {
                    return Card(
                      elevation: 10,
                      child: Container(
                        padding: EdgeInsets.all(30),
                        height: 250,
                        decoration: BoxDecoration(
                          color: Colors.blue[300],
                          borderRadius: BorderRadius.only(),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Emergency Type : ',
                                  style: TextStyle(fontSize: 20),
                                ),
                                Text(
                                  document.data()['type'].toString(),
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                  'Bus Plate Number : ',
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  document.data()['busNo'].toString(),
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                  'Date and Time : ',
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  document.data()['time'].toString(),
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                  'Location : ',
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  document
                                      .data()['location']
                                      .latitude
                                      .toString(),
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text('° N'),
                                SizedBox(width: 5),
                                Text(
                                  document
                                      .data()['location']
                                      .longitude
                                      .toString(),
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text('° E'),
                                /* SizedBox(width: 5),
                                TextButton(
                                  onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => BusMap(document.data()['busNo'])));
                                  },*/
                                //child: Text('Show In Map'),
                                SizedBox(
                                  width: 150,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5.0, horizontal: 10.0),
                                    child: ElevatedButton(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10.0, horizontal: 10.0),
                                        child: Text(
                                          'Show In Map',
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.black87, // background
                                        onPrimary: Colors.white, // foreground
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        BusMap(document
                                                            .data()['busNo'])));
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                  'Description : ',
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  document.data()['text'].toString(),
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ).toList(),
              ),
            );
          }),
    );
  }
}
