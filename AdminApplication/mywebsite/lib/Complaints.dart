import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:mywebsite/SideBar.dart';

class Complaints extends StatefulWidget {
  static const String id = 'complaints';
  @override
  _ComplaintsState createState() => _ComplaintsState();
}

class _ComplaintsState extends State<Complaints> {
  @override
  Widget build(BuildContext context) {
    SideBarWidget _sideBar = SideBarWidget();
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Complaints'),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          )
        ],
      ),
      sideBar: _sideBar.sideBarMenus(context, Complaints.id),
      body: StreamBuilder(
          //  DateTime myDateTime = (snapshots.data.documents[index].data['timestamp']).toDate();
          // final Timestamp timestamp = snapshot.data['timestamp'] as Timestamp;
//final DateTime dateTime = timestamp.toDate();
//final dateString = DateFormat('K:mm:ss').format(dateTime);
          stream:
              FirebaseFirestore.instance.collection('complaints').snapshots(),
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
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.blue[300],
                          borderRadius: BorderRadius.only(),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Bus Plate Number : ',
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  document.data()['Plate Number'].toString(),
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
                            /* Row(
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
                            ),*/

                            SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                  'Complaint : ',
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  document.data()['Complaint'].toString(),
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
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
