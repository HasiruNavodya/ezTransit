import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../main.dart';

double pickupLat;
double pickupLng;
double distanceInMeters;
String rideState = 'fetching';
String ticketID = 'tck1000';
//String ticketID;
Map ticketData;
Map tripData;
Map busData;

class RideView extends StatefulWidget {

  //String ticketID = 'TCK1000';
/*
  RideView(tid){
    this.ticketID = tid;
  }*/

  @override
  _RideViewState createState() => _RideViewState();
}

class _RideViewState extends State<RideView> {

  BitmapDescriptor busicon;

  @override
  void initState() {
    super.initState();

    //print(widget.ticketID);

    Future<Position> _determinePosition() async {
      bool serviceEnabled;
      LocationPermission permission;
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return Future.error('Location services are disabled.');
      }
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.deniedForever) {
          return Future.error('Location permissions are permanently denied, we cannot request permissions.');
        }
        if (permission == LocationPermission.denied) {
          return Future.error('Location permissions are denied');
        }
      }
      Position position = await Geolocator.getCurrentPosition();
      return await Geolocator.getCurrentPosition();
    }

    setMapMarker();

  }

  GoogleMapController mapController;
  static const _initialPosition = LatLng(7.2906, 80.6337);
  LatLng _lastPostion = _initialPosition;
  final Set<Marker> _markers = {};


  dynamic data;

  final ValueNotifier<int> distance = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {

    if(rideState == 'waiting'){
      listenToRideStart();
      listenToRidepEnd();
      return Scaffold(
        appBar: AppBar(
          title: Text("Wait For Your Bus"),
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Card(
                                color: Colors.white70,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 400,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text(ticketData['pickup'],
                                              style: TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                            Text(" to ",
                                              style: TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                            Text(ticketData['drop'],
                                              style: TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                          ],
                                        ),

                                        Text(ticketData['pickupTime']+" - "+ticketData['dropTime'],
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Card(
                                color: Colors.white70,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 400,
                                    child: Column(
                                      children: [
                                        Text("Bus: "+tripData['startCity'] + ' - ' +tripData['endCity'],
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text("Plate No: "+tripData['bus'],
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text("Color: " +busData['color'],
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Card(
                                color: Colors.white70,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 400,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text("Distance to Pickup Location : ",
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                            ValueListenableBuilder<int>(
                                              valueListenable: distance,
                                              builder: (BuildContext context, distance, Widget child) {
                                                return Text("$distance");
                                              }
                                            ),
                                            Text(" m",
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: (){},
                                child: Text(
                                  'Cancel Ride',
                                  style: TextStyle(color: Colors.red),
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

    else if(rideState == 'onbus'){
      return Scaffold(
        appBar: AppBar(
          title: Text("On the Bus"),
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
              flex: 7,
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Card(
                                color: Colors.white70,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 400,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text("Ticket ID: " + ticketData['ticketID'],
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Card(
                                color: Colors.white70,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 400,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text(ticketData['pickup'],
                                              style: TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                            Text(" to ",
                                              style: TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                            Text(ticketData['drop'],
                                              style: TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                          ],
                                        ),

                                        Text(ticketData['pickupTime']+" - "+ticketData['dropTime'],
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  TextButton(
                                    onPressed: (){},
                                    child: Text(
                                      'Stop Ride Early',
                                      style: TextStyle(color: Colors.indigo[900]),
                                    ),
                                  ),
 /*                                 TextButton(
                                    onPressed: (){},
                                    child: Text(
                                      'Extend Ride',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),*/
                                  TextButton(
                                    onPressed: (){},
                                    child: Text(
                                      'Report Complaint',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ],
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

    else if(rideState == 'ending'){
      endRide();
      return Scaffold(
        body: Container(
          child: SpinKitDualRing(color: Colors.black87),
        ),
      );
    }

    else {
      getRideData();
      return Scaffold(
        body: Container(
          child: SpinKitDualRing(color: Colors.black87),
        ),
      );
    }

  }

  void endRide() {
    print('Ride Ended>>>>>>>>>>>>>>>>>>>>>>>');
    streamController.add(0);
  }

  void getRideData(){

    FirebaseFirestore.instance.collection('tickets').doc(ticketID).get().then((DocumentSnapshot ticket) {
      if (ticket.exists) {
        ticketData = ticket.data();
        print(ticketData);

        if(ticketData['tripID'] != null){
          FirebaseFirestore.instance.collection('trips').doc(ticketData['tripID']).get().then((DocumentSnapshot trip) {
            if (trip.exists) {
              tripData = trip.data();
              print(tripData);
              FirebaseFirestore.instance.collection('trips').doc(ticketData['tripID']).collection('stops').doc(ticketData['pickup']).get().then((DocumentSnapshot pickupLoc) {
                if (trip.exists) {
                  pickupLat = pickupLoc.data()['location'].latitude;
                  pickupLng = pickupLoc.data()['location'].longitude;
                }
              });
            }
          });
        }

        if(ticketData['bus'] != null){
          FirebaseFirestore.instance.collection('buses').doc(ticketData['bus']).get().then((DocumentSnapshot bus) {
            if (bus.exists) {
              busData = bus.data();
              setState(() {
                rideState = 'waiting';
              });
            }
          });
        }

      }
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    showBusLocation();
    setState(() {
      mapController = controller;
    });
  }

  void _onCameraMove(CameraPosition position) {
    setState(() {
      _lastPostion = position.target;
    });
  }

  void showBusLocation() async {

    setState(() {
      FirebaseFirestore.instance.collection('buses').doc(tripData['bus']).snapshots().listen((DocumentSnapshot busLocation) {

        print("location updated");

        _markers.add(
          Marker(
            markerId: MarkerId('bus'),
            position: LatLng(busLocation.data()['location'].latitude,busLocation.data()['location'].longitude),
            icon: busicon,
          ));

        mapController?.animateCamera(
          CameraUpdate.newLatLng(
            LatLng(busLocation.data()['location'].latitude,busLocation.data()['location'].longitude),
          ),
        );

        distanceInMeters = Geolocator.distanceBetween(pickupLat, pickupLng, busLocation.data()['location'].latitude, busLocation.data()['location'].longitude);
        distance.value = distanceInMeters.round();

      });
    });
  }

  void listenToRideStart(){
    FirebaseFirestore.instance.collection('trips').doc(ticketData['tripID']).collection('stops').doc(ticketData['pickup']).snapshots().listen((DocumentSnapshot tripStartDoc) {
      if(tripStartDoc.data()['passed'] == 'true'){
        setState(() {
          rideState = 'onbus';
        });
      }
    });
  }

  void listenToRidepEnd(){
    FirebaseFirestore.instance.collection('trips').doc(ticketData['tripID']).collection('stops').doc(ticketData['drop']).snapshots().listen((DocumentSnapshot tripEndDoc) {
      if(tripEndDoc.data()['passed'] == 'true'){
        setState(() {
          rideState = 'ending';
        });
      }
    });
  }

  void setMapMarker() async{
    busicon = await BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(60,60)), 'assets/bus.png');
  }


}