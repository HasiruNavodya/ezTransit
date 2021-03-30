import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

double lat;
double lng;
String rideState = 'fetching';
String ticketID = 'tck1000';
Map ticketData;
Map tripData;
Map busData;

class RideView extends StatefulWidget {
  @override
  _RideViewState createState() => _RideViewState();
}

class _RideViewState extends State<RideView> {

  TextEditingController distance = TextEditingController();

  @override
  void initState() {
    super.initState();

    Future<Position> _determinePosition() async {
      bool serviceEnabled;
      LocationPermission permission;

      // Test if location services are enabled.
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Location services are not enabled don't continue
        // accessing the position and request users of the
        // App to enable the location services.
        return Future.error('Location services are disabled.');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.deniedForever) {
          // Permissions are denied forever, handle appropriately.
          return Future.error(
              'Location permissions are permanently denied, we cannot request permissions.');
        }

        if (permission == LocationPermission.denied) {
          // Permissions are denied, next time you could try
          // requesting permissions again (this is also where
          // Android's shouldShowRequestPermissionRationale
          // returned true. According to Android guidelines
          // your App should show an explanatory UI now.
          return Future.error(
              'Location permissions are denied');
        }
      }
      Position position = await Geolocator.getCurrentPosition();
      lat = position.latitude;
      lng = position.longitude;

      // When we reach here, permissions are granted and we can
      // continue accessing the position of the device.
      return await Geolocator.getCurrentPosition();

    }

  }

  GoogleMapController mapController;
  static const _initialPosition = LatLng(7.2906, 80.6337);
  LatLng _lastPostion = _initialPosition;
  final Set<Marker> _markers = {};

  dynamic data;

  @override
  Widget build(BuildContext context) {

    if(rideState == 'waiting'){

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
                                            Text("  -  ",
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
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 400,
                                    child: Column(
                                      children: [
                                        Text("Bus: "+tripData['startCity'] + ' to ' +tripData['endCity'],
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
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 400,
                                    child: Column(
                                      children: [
                                        Text("Distance: 2 km",
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
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
                              /*Text("",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),*/
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
                              /*Text("",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),*/
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
                              TextField(
                                controller: distance,
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
    print('Ride Ended..........................');
  }

  void getRideData(){

    FirebaseFirestore.instance.collection('tickets').doc(ticketID).get().then((DocumentSnapshot ticket) {
      if (ticket.exists) {
        ticketData = ticket.data();
        print(ticketData);

        //if(ticketData['tripID'] != null){
          FirebaseFirestore.instance.collection('trips').doc(ticketData['tripID']).get().then((DocumentSnapshot trip) {
            if (trip.exists) {
              tripData = trip.data();
              print(tripData);
            }
          });
        //}

        //if(ticketData['bus'] != null){
          FirebaseFirestore.instance.collection('buses').doc(ticketData['bus']).get().then((DocumentSnapshot bus) {
            if (bus.exists) {
              busData = bus.data();
              print(busData);
              setState(() {
                rideState = 'waiting';
              });
            }
          });
        //}

      }
    });
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

  void _initMarker() async {

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

  void listenToTripEnd(){
    FirebaseFirestore.instance.collection('trips').doc('T3000').collection('stops').doc('3').snapshots().listen((DocumentSnapshot tripEndDoc) {
      if(tripEndDoc.data()['passed'] == 'passed'){
        print('Your Ride has ended');
      }
    });
  }

  void getDistance() async{

    double distanceInMeters;

    //distanceInMeters = Geolocator.distanceBetween(52.2165157, 6.9437819, 52.3546274, 4.8285838);
    //distance.text = distanceInMeters.toString();
    print(lat);
    print(lng);

    FirebaseFirestore.instance.collection('buses').doc('eg2345').snapshots().listen((DocumentSnapshot busDistance) {
      //distanceInMeters = Geolocator.distanceBetween(lat, lng, busDistance.data()['location'].latitude, busDistance.data()['location'].longitude);
      //distanceInMeters = Geolocator.distanceBetween(52.2165157, 6.9437819, 52.3546274, 4.8285838);
      //print(distanceInMeters);
      //distance.text = distanceInMeters.toString();
    });
  }


}