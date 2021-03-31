import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:mywebsite/SideBar.dart';


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
      body:   
      
      StreamBuilder(
      
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
                        height: 300,
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
                                  'Time : ',
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  document.data()['time'].toDate().toString(),
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
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                  'Description : ',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            Text(
                              document.data()['text'].toString(),
                              style: TextStyle(fontSize: 16),
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
