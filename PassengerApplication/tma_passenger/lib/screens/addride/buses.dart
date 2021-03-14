import 'package:flutter/material.dart';
import 'package:tma_passenger/screens/addride/confirm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SelectBus extends StatefulWidget {
  @override
  _SelectBusState createState() => _SelectBusState();
}

class _SelectBusState extends State<SelectBus> {
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
            child: TripInfo(),
          )
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ConfirmTicket()),
          );
        },
        child: Icon(Icons.arrow_forward_ios),
        backgroundColor: Colors.black87,
      ),

    );
  }
}

class TripInfo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Query buses = FirebaseFirestore.instance.collection('trips').where('route', isEqualTo: '1000');

    return StreamBuilder<QuerySnapshot>(
      stream: buses.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return new ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            return Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Padding(
                  padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Center(child: Text(document.data()['desc']))
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Center(child: Text(document.data()['times']))
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Center(child: Text(_getStops())),
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Center(child: Text(_getStops())),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

String _getStops(){
  return 'stop1';
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
