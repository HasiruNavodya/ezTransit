import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

String busNumber = 'eg2345';
String tripStatus = '';
String bnum = '';
dynamic tripData = '';

class RideDetails extends StatefulWidget {
  @override
  _RideDetailsState createState() => _RideDetailsState();
}
class _RideDetailsState extends State<RideDetails> {

  @override
  void initState() {
    super.initState();
    test();
  }

  GoogleMapController mapController;
  static const _initialPosition = LatLng(7.2906, 80.6337);
  LatLng _lastPostion = _initialPosition;
  final Set<Marker> _markers = {};

  dynamic data;

  
  @override
  Widget build(BuildContext context) {

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
                    initialCameraPosition: CameraPosition(target: LatLng(6.844688, 80.015283), zoom: 15.0,),
                    myLocationEnabled: true,
                    mapType: MapType.normal,
                    compassEnabled: true,
                    onCameraMove: _onCameraMove,
                    markers: _markers,
                  ),
                ],
              ),
            ),

            Expanded(
              flex: 10,
              child: Container(
                child: Column(
                  children: [
                    Expanded(
                      flex: 6,
                      child: Container(
                        //color: Colors.red,
                        constraints: BoxConstraints.tightForFinite(height: 300),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text("Pettah" + " - " + "Kollupitiya",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              Text("08:00"+" - "+"08:20",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Text("",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Text("Bus: Pettah - Kollupitiya",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Text("Plate No: EG-2345",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Text("Color: Red",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Text("",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Text("Distance: 2 km",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Text("ETA: 6 minutes",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _initMarker();
    setState(() {
      mapController = controller;
    });
  }

  void _onCameraMove(CameraPosition position) {
    setState(() {
      _lastPostion = position.target;
    });
  }

  void _initMarker() {

    setState(() {
      FirebaseFirestore.instance.collection('buses').doc('eg2345').snapshots().listen((DocumentSnapshot documentSnapshot) {

          print("location updated");

        _markers.add(
          Marker(
            markerId: MarkerId('bus'),
            position: LatLng(documentSnapshot.data()['location'].latitude,documentSnapshot.data()['location'].longitude),
            infoWindow: InfoWindow(
              title: 'name',
              snippet: "",
            ),
          icon: BitmapDescriptor.defaultMarker,
        ));

        mapController?.animateCamera(
          CameraUpdate.newLatLng(
            LatLng(documentSnapshot.data()['location'].latitude,documentSnapshot.data()['location'].longitude),
          ),
        );

      });
    });
  }

  void test() async{
    FirebaseFirestore.instance.collection('buses').doc('$busNumber').get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document data: ${documentSnapshot.data()}');
        tripData = documentSnapshot.data();
        print(tripData);
        String bnum = documentSnapshot.data()['number'];
        print(bnum);
      } else {
        print('Document does not exist on the database');
      }
    });
  }
}