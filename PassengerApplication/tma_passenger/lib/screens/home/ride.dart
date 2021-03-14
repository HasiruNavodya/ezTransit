import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

// Init firestore and geoFlutterFire
final geo = Geoflutterfire();
final _firestore = FirebaseFirestore.instance;



class RideDetails extends StatefulWidget {
  @override
  _RideDetailsState createState() => _RideDetailsState();
}

class _RideDetailsState extends State<RideDetails> {

  GoogleMapController mapController;
  static const _initialPosition = LatLng(7.2906, 80.6337);
  LatLng _lastPostion = _initialPosition;
  final Set<Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    Query users = FirebaseFirestore.instance.collection('trips').where('bus', isEqualTo: 'EG-2234');
    return Scaffold(
      appBar: AppBar(
        title: Text("Current Ride"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      //backgroundColor: Colors.red,
      body: Column(
        children: [
          Expanded(
            flex: 15,
            child: Stack(
              children: [
                GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(target: LatLng(6.844688,80.015283), zoom: 15.0,),
                  myLocationEnabled: true, // Add little blue dot for device location, requires permission from user
                  mapType: MapType.normal,
                  compassEnabled: true,
                  onCameraMove: _onCameraMove,
                  markers: _markers,
                  ),
                ],
              ),
            ),
          Expanded(
            flex: 1,
            child: Container(
              child: ElevatedButton(
                onPressed: () {
                  _onAddMarkerPressed();
                },
                child: Text('Get Location'),
              )
            ),
          ),
          Expanded(
            flex: 7,
            child: StreamBuilder<QuerySnapshot>(
              stream: users.snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }

                return new ListView(
                  children: snapshot.data.docs.map((DocumentSnapshot document) {
                    return new ListTile(
                      title: new Text(document.data()['desc']),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      )
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  void _onCameraMove(CameraPosition position) {
    setState(() {
      _lastPostion = position.target;
    });
  }

  void _onAddMarkerPressed() {
    setState(() {

      FirebaseFirestore.instance
          .collection('trips')
          .doc('test')
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          print(documentSnapshot.data()['name']);
        }

        _markers.add(Marker(markerId: MarkerId(_lastPostion.toString()),
            position: _lastPostion,
            infoWindow: InfoWindow(
              title: documentSnapshot.data()['name'],
              snippet: "",
            ),
            icon: BitmapDescriptor.defaultMarker
        ));
      });
    });
  }






}

