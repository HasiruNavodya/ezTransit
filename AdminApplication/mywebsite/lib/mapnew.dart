import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:mywebsite/Home%20View.dart';
import 'package:mywebsite/SideBar.dart';
import 'package:mywebsite/initializeTrip.dart';

double lat;
double long;

const CameraPosition _kInitialPosition =
    CameraPosition(target: LatLng(6.8412, 79.9654), zoom: 11.0);

class MapClickPageNew extends StatefulWidget {
  String tripid;
  MapClickPageNew(tripid) {
    this.tripid = tripid;
  }

  @override
  _MapClickPageNewState createState() => _MapClickPageNewState(tripid);
}

class _MapClickPageNewState extends State<MapClickPageNew> {
  String tripid;
  _MapClickPageNewState(tripid) {
    this.tripid = tripid;
  }
  @override
  Widget build(BuildContext context) {
    return _MapClickBody(tripid);
  }
}

class _MapClickBody extends StatefulWidget {
  String tripid;
  _MapClickBody(tripid) {
    this.tripid = tripid;
  }

  @override
  State<StatefulWidget> createState() => _MapClickBodyState(tripid);
}

class AlertBox extends StatelessWidget {
  final title;
  AlertBox(this.title);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      //Round rectangle border

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),

      title: Text('Alert'),
      content: Text(title),
      actions: <Widget>[
        new TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Okay'))
      ],
    );
  }
}

class _MapClickBodyState extends State<_MapClickBody> {
  String tripid;
  _MapClickBodyState(tripid) {
    this.tripid = tripid;
  }
//take last tapped latlon into this variable
  GoogleMapController mapController;
  LatLng _lastTap;
  LatLng _lastLongPress;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _latitude;
  String _longitude;
  String _stopName;
  String _arrivingTime;

  String tid = InitializeTrip.tid;

//get data from textformfield
  TextEditingController stopName = new TextEditingController();
  TextEditingController arrivingTime = new TextEditingController();

  TextEditingController cnlatitude = new TextEditingController();
  TextEditingController cnlongitude = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    SideBarWidget _sideBar = SideBarWidget();
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Transport Management System'),
        backgroundColor: Colors.black,
      ),
      sideBar: _sideBar.sideBarMenus(context, Home.id),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          elevation: 20.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(35),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 50.0, horizontal: 25.0),
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 40.0),
                      TextFormField(
                        //   key: ValueKey('stopName'),
                        controller: stopName,
                        decoration: InputDecoration(
                            labelText: 'Stop Name',
                            labelStyle:
                                TextStyle(fontSize: 16, color: Colors.black),
                            border: OutlineInputBorder()),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Stop Name is required';
                          }
                        },
                        onSaved: (String value) {
                          _stopName = value;
                        },
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        //key: ValueKey('arrivingTime'),
                        controller: arrivingTime,
                        decoration: InputDecoration(
                            labelText: 'Arriving Time',
                            labelStyle:
                                TextStyle(fontSize: 16, color: Colors.black),
                            border: OutlineInputBorder()),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Arriving Time is required';
                            //validator: (val) =>val.isEmpty?'This field is required':null,
                          }
                        },
                        onSaved: (String value) {
                          _arrivingTime = value;
                        },
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        //    key: ValueKey('cnlatitude'),
                        controller: cnlatitude,
                        decoration: InputDecoration(
                            labelText: 'Latitude',
                            labelStyle:
                                TextStyle(fontSize: 16, color: Colors.black),
                            border: OutlineInputBorder()),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return ('latitude is required');
                          }
                        },
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        //   key: ValueKey('cnlongitude'),
                        controller: cnlongitude,
                        decoration: InputDecoration(
                            labelText: 'Longitude',
                            labelStyle:
                                TextStyle(fontSize: 16, color: Colors.black),
                            border: OutlineInputBorder()),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return ('longitude is required');
                          }
                        },
                      ),
                      SizedBox(height: 30.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 130,
                            child: ElevatedButton(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                    horizontal: 20,
                                  ),
                                  child: Text(
                                    'Add',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.black87, // background
                                  onPrimary: Colors.white, // foreground
                                ),
                                onPressed: () async {
                                  String stname = stopName.text;

                                  // validate the form based on it's current state

                                  Map<String, dynamic> data = {
                                    "name": stopName.text,
                                    "time": arrivingTime.text,
                                    'order': FieldValue.serverTimestamp(),
                                    'passed': 'false',
                                    'dropCount': 0,
                                    'pickupCount': 0,
                                    "location": GeoPoint(lat, long),
                                    // "Latitude": cnlatitude.text,
                                    // "Longitude": cnlongitude.text,
                                  };
                                  //  String a = InitializeTrip.tid;
                                  print("fdssssss" + tripid);
                                  FirebaseFirestore.instance
                                      .collection("trips")
                                      .doc("$tripid")
                                      .collection("stops")
                                      .doc('$stname')
                                      .set(data);

                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertBox(
                                            'Successfully Inserted!');
                                      });
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            MapClickPageNew(tripid)),
                                  );
                                }),
                          ),
                          SizedBox(width: 50.0),
                          SizedBox(
                            width: 130,
                            child: ElevatedButton(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 20),
                                  child: Text(
                                    'Finish',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.black87, // background
                                  onPrimary: Colors.white, // foreground
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              Home()));
                                }),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    GoogleMap(
                      onMapCreated: onMapCreated,
                      initialCameraPosition: _kInitialPosition,
                      onTap: (LatLng pos) {
                        cnlatitude.text = pos.latitude.toString();
                        cnlongitude.text = pos.longitude.toString();
                        lat = pos.latitude;
                        long = pos.longitude;
                        setState(() {
                          _lastTap = pos;
                        });
                      },
                      onLongPress: (LatLng pos) {
                        setState(() {
                          _lastLongPress = pos;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onMapCreated(GoogleMapController controller) async {
    setState(() {
      mapController = controller;
    });
  }
}
