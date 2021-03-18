import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:tma_bus/screens/trip/starttrip.dart';
import 'package:location/location.dart';


class TripControlView extends StatefulWidget {
  @override
  _TripControlViewState createState() => _TripControlViewState();
}

class _TripControlViewState extends State<TripControlView> {

  String tripStatus = "off";

  @override
  void initState() {
    super.initState();
    storeUserLocation();
  }

  @override
  Widget build(BuildContext context) {

    if (tripStatus == "off"){
      return Scaffold(
        appBar: AppBar(
          title: Text("Trip"),
          backgroundColor: Colors.black,
          centerTitle: true,
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {},
            child: Text('Share Location'),
          ),
        ),
      );
    }

    else{
      return Scaffold(
        appBar: AppBar(
          title: Text("Trip"),
          backgroundColor: Colors.black,
          centerTitle: true,
        ),
        //backgroundColor: Colors.red,
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            color: Colors.amber,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}

storeUserLocation()
{

  Location location = new Location();

  location.onLocationChanged.listen((LocationData currentLocation) {

    FirebaseFirestore.instance.collection('buses').doc('eg2345').set({
      'location' : GeoPoint(currentLocation.latitude, currentLocation.longitude)
    });

  });
}
