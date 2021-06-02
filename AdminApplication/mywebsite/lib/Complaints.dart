import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:mywebsite/SearchService.dart';
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
          IconButton(onPressed:(){}, icon: Icon(Icons.search),)
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

/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:mywebsite/SearchService.dart';
import 'package:mywebsite/SideBar.dart';

class Complaints extends StatefulWidget {
  static const String id = 'complaints';
  @override
  _ComplaintsState createState() => _ComplaintsState();
}

class _ComplaintsState extends State<Complaints> {
   Stream<QuerySnapshot> getUsersPastTripsStreamSnapshots(
      BuildContext context) async* {
        final uid = await  FirebaseFirestore.instance.collection('complaints')

       
       
        .where("time", isLessThanOrEqualTo: DateTime.now())
        .orderBy('time')
        .snapshots();
  @override
  Widget build(BuildContext context) {
    SideBarWidget _sideBar = SideBarWidget();
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Complaints'),
    ),
    sideBar: _sideBar.sideBarMenus(context, Complaints.id),
   body: Container(
      child: Column(
        children: <Widget>[
          Text("Past Trips", style: TextStyle(fontSize: 20)),
          Expanded(
            child: StreamBuilder(
                stream: getUsersPastTripsStreamSnapshots(context),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const Text("Loading...");
                  return new ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (BuildContext context, int index) =>
                          buildTripCard(context, snapshot.data.documents[index]));
                }),
          ),
        ],
      ),
    );
    
    );
  }
}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
Widget buildTripCard(BuildContext context, DocumentSnapshot document) {
  final trip = Trip.fromSnapshot(document);
  final tripType = trip.types();

  return new Container(
    child: Card(
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                child: Row(children: <Widget>[
                  Text(
                    trip.title,
                   
                  ),
                  Spacer(),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 80.0),
                child: Row(children: <Widget>[
                  Text(
                      "${DateFormat('MM/dd/yyyy').format(trip.startDate).toString()} - ${DateFormat('MM/dd/yyyy').format(trip.endDate).toString()}"),
                  Spacer(),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      "\$${(trip.budget == null) ? "n/a" : trip.budget.toStringAsFixed(2)}",
                      style: new TextStyle(fontSize: 35.0),
                    ),
                    Spacer(),
                    (tripType.containsKey(trip.travelType))
                        ? tripType[trip.travelType]
                        : tripType["other"],
                  ],
                ),
              )
            ],
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailTripView(trip: trip)),
          );
        },
      ),
    ),
  );
}*/
/*
class Complaints extends StatefulWidget {
  @override
  static const String id = 'complaints';
  _ComplaintsState createState() => _ComplaintsState();
}

class _ComplaintsState extends State<Complaints> {
  var queryResultSet = [];
  var tempSearchStore = [];

  initiateSearch(value) {
    if (value.length == 0) {
      setState(() {
        queryResultSet = [];
        tempSearchStore = [];
      });
    }

    var capitalizedValue =
        value.substring(0, 1).toUpperCase() + value.substring(1);

    if (queryResultSet.length == 0 && value.length == 1) {
      SearchService().searchByName(value).then((QuerySnapshot docs) {
        for (int i = 0; i < docs.docs.length ; ++i) {
          queryResultSet.add(docs.docs[i].data);
        }
      });
    } else {
      tempSearchStore = [];
      queryResultSet.forEach((element) {
        if (element['Plate Number'].startsWith(capitalizedValue)) {
          setState(() {
            tempSearchStore.add(element);
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: Text('Firestore search'),
        ),
        body: ListView(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              onChanged: (val) {
                initiateSearch(val);
              },
              decoration: InputDecoration(
                  prefixIcon: IconButton(
                    color: Colors.black,
                    icon: Icon(Icons.arrow_back),
                    iconSize: 20.0,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  contentPadding: EdgeInsets.only(left: 25.0),
                  hintText: 'Search by name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0))),
            ),
          ),
          SizedBox(height: 10.0),
          GridView.count(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              crossAxisCount: 2,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0,
              primary: false,
              shrinkWrap: true,
              children: tempSearchStore.map((element) {
                return buildResultCard(element);
              }).toList())
        ]));
  }
}

Widget buildResultCard(data) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    elevation: 2.0,
    child: Container(
      child: Center(
        child: Text(data['Plate Number'],
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
        ),
        )
      )
    )
  );


}
*/