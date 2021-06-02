import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tma_passenger/main.dart';
import 'package:tma_passenger/screens/home/complains.dart';


double pickupLat;
double pickupLng;
double distanceInMeters;
double distanceInMeters2;
double distancenew;
double speed;
double time;
String rideState = 'fetching';
String userEmail;
var payColor;
String ticketID;
Map ticketData;
Map tripData;
Map busData;
int s=1;

class RideView extends StatefulWidget {

  RideView(this.ticketIDRV);
  final ticketIDRV;

  @override
  _RideViewState createState() => _RideViewState();
}

class _RideViewState extends State<RideView> {


  BitmapDescriptor busicon;

  @override
  void initState() {
    super.initState();

    getUserInfo();
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

  void getUserInfo(){
    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      userEmail = auth.currentUser.email;
      print(auth.currentUser.email);
    }
  }

  GoogleMapController mapController;
  static const _initialPosition = LatLng(7.2906, 80.6337);
  LatLng _lastPostion = _initialPosition;
  final Set<Marker> _markers = {};


  dynamic data;

  final ValueNotifier<String> distance = ValueNotifier<String>('Calculating..');

  @override
  Widget build(BuildContext context) {

    if(rideState == 'waiting'){
      listenToRideStart();
      listenToRidepEnd();
      return Scaffold(
        appBar: AppBar(
          title: Text("WAIT FOR BUS"),
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
              flex: 12,
              child: Container(
                child: Column(
                  children: [
                    Expanded(
                      flex: 6,
                      child: Container(
                        color: Colors.grey.shade300,
                        constraints: BoxConstraints.tightForFinite(height: 300),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex:2,
                                child: Card(
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 400,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text("Bus: "+tripData['startCity'] + ' - ' +tripData['endCity'],
                                            style: TextStyle(
                                              fontSize: 17,
                                            ),
                                          ),
                                          Text("Plate No: "+tripData['bus'],
                                            style: TextStyle(
                                              fontSize: 17,
                                            ),
                                          ),
                                          Text("Color: " +busData['Color'],
                                            style: TextStyle(
                                              fontSize: 17,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex:1,
                                child: Card(
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 400,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text("Distance [Approx] : ",
                                                style: TextStyle(
                                                  fontSize: 17,
                                                ),
                                              ),
                                              ValueListenableBuilder<String>(
                                                  valueListenable: distance,
                                                  builder: (BuildContext context, distance, Widget child) {
                                                    return Text("$distance",
                                                      style: TextStyle(
                                                        fontSize: 17,
                                                      ),
                                                    );
                                                  }
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),


                              Expanded(
                                flex:2,
                                child: Card(
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 400,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text('Ticket ID: '+ticketData['ticketID'],
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [

                                              Text(ticketData['pickup'],
                                                style: TextStyle(
                                                  fontSize: 18,
                                                ),
                                              ),
                                              Text(" to ",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                ),
                                              ),
                                              Text(ticketData['drop'],
                                                style: TextStyle(
                                                  fontSize: 18,
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
                              ),

                              Expanded(
                                flex: 1,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    OutlinedButton(
                                      onPressed: (){
                                        showAlertDialog(context);
                                      },
                                      child: Text(
                                        'Canel Ride',
                                        style: TextStyle(color: Colors.black87),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    OutlinedButton(
                                      onPressed: (){
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => Complaints(tripData['bus'])),
                                        );
                                      },
                                      child: Text(
                                        'Report Complaint',
                                        style: TextStyle(color: Colors.black87),
                                      ),
                                    ),
                                  ],
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
          title: Text("RIDE INFO"),
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
              flex: 9,
              child: Container(
                child: Column(
                  children: [
                    Expanded(
                      flex: 6,
                      child: Container(
                        color: Colors.grey.shade300,
                        constraints: BoxConstraints.tightForFinite(height: 300),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Card(
                                  color: Colors.white,
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
                              ),
                              Expanded(
                                flex: 2,
                                child: Card(
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 400,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
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
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Card(
                                  color: Colors.white,
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
                                              Row(
                                                children: [
                                                  Text("Fare: Rs. " + ticketData['fare'] + "  |  ",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.bold
                                                    ),
                                                  ),
                                                  Text(ticketData['payment'],
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.bold,
                                                      color: payColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              Expanded(
                                flex: 1,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    OutlinedButton(
                                      onPressed: (){
                                        showAlertDialog(context);
                                      },
                                      child: Text(
                                        'Exit Ride Mode',
                                        style: TextStyle(color: Colors.black87),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    OutlinedButton(
                                      onPressed: (){
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => Complaints(tripData['bus'])),
                                        );
                                      },
                                      child: Text(
                                        'Report Complaint',
                                        style: TextStyle(color: Colors.black87),
                                      ),
                                    ),
                                  ],
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

    else if(rideState == 'ending'){
      endRide();
      return Scaffold(
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Your Ride Has Ended\n\n\n',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                SpinKitDualRing(color: Colors.black87),
              ],
            ),
          ),
        ),
      );
    }

    else {
      getRideData();
      return Scaffold(
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Loading Ride Data\n\n\n',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                SpinKitDualRing(color: Colors.black87),
              ],
            ),
          ),
        ),
      );
    }

  }

  void endRide() {
    print('Ride Ended>>>>>>>>>>>>>>>>>>>>>>>');
    FirebaseFirestore.instance.collection("passengers").doc(userEmail).update({"onRide": "False"})
        .then((value) => print("Records Added Successfully!"))
        .catchError((error) => print("Failed: $error"));

    Future.delayed(const Duration(seconds: 1), () {
      streamController.add('0');
    });

  }

  void getRideData(){

    FirebaseFirestore.instance.collection('passengers').doc(userEmail).get().then((DocumentSnapshot user) {
      if (user.exists) {
        print("qweqweqweqweqweqwe");
        ticketID = user.data()['currentTicketNo'];
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

                  Future.delayed(const Duration(seconds: 2), () {
                    setState(() {
                      rideState = 'waiting';
                    });
                  });

                }
              });
            }

            if(ticketData['payment'] == 'Payed'){
              payColor = Colors.indigo;
            }else{
              payColor = Colors.red;
            }
          }
        });
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
            position: LatLng(busLocation.data()['location'].latitude, busLocation.data()['location'].longitude),
            icon: busicon,
          ));

        mapController?.animateCamera(
          CameraUpdate.newLatLng(
            LatLng(busLocation.data()['location'].latitude, busLocation.data()['location'].longitude),
          ),
        );



          distanceInMeters = Geolocator.distanceBetween(pickupLat, pickupLng, busLocation.data()['location'].latitude, busLocation.data()['location'].longitude);
          distance.value = distanceInMeters.round().toString() + ' m';
/*          Future.delayed(const Duration(seconds: 15), () {
            distanceInMeters2 = Geolocator.distanceBetween(pickupLat, pickupLng, busLocation.data()['location'].latitude, busLocation.data()['location'].longitude);
            speed = (distanceInMeters - distanceInMeters2)/15.0;
            distancenew = Geolocator.distanceBetween(pickupLat, pickupLng, busLocation.data()['location'].latitude, busLocation.data()['location'].longitude);
            time = (distancenew/speed);
            time = time/60.0;
            distance.value = time.toString() + ' min';
          });*/


      });
    });
  }

  void getPickupCord(){
    FirebaseFirestore.instance.collection('trips').doc(ticketData['tripID']).collection('stops').doc(ticketData['pickup']).get().then((DocumentSnapshot pickupcord) {
      if (pickupcord.exists) {

      }
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

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(
        "NO",
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.black87,
        ),
      ),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text(
        "YES",
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.red,
        ),
      ),
      onPressed:  () {
        Navigator.pop(context);
        endRide();
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text("Confirm"),
      content: Text("Exit Ride Mode?"),
      actions: [
        continueButton,
        cancelButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  startAlert(BuildContext context) {
    // set up the buttons
    Widget continueButton = TextButton(
      child: Text(
        "OK",
        style: TextStyle(
          fontSize: 18.0,
          color: Colors.black87,
        ),
      ),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text("Alert!"),
      content: Text("Bus is arriving the pickup location"),
      actions: [
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}