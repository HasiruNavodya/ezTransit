import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mywebsite/AddTrip.dart';
//import 'page.dart';

const CameraPosition _kInitialPosition =
    CameraPosition(target: LatLng(7.8731, 80.7718), zoom: 11.0);

class MapClickPageNew extends StatelessWidget {
  //MapClickPage() : super(const Icon(icons.mouse), 'Map click');

  @override
  Widget build(BuildContext context) {
    return const _MapClickBody();
  }
}

class _MapClickBody extends StatefulWidget {
  const _MapClickBody();

  @override
  State<StatefulWidget> createState() => _MapClickBodyState();
}

class _MapClickBodyState extends State<_MapClickBody> {
  _MapClickBodyState();

  GoogleMapController mapController;
  LatLng _lastTap;
  LatLng _lastLongPress;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _latitude;
  String _longitude;
  String _stopName;
  String _arrivingTime;
  String _timeDu;

//get data from textformfield
  TextEditingController stopName = new TextEditingController();
  TextEditingController arrivingTime = new TextEditingController();
  TextEditingController timeDu = new TextEditingController();
  TextEditingController cnlatitude = new TextEditingController();
  TextEditingController cnlongitude = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Stops'),
      ),
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Stop Name', border: OutlineInputBorder()),
                    onSaved: (String value) {
                      _stopName = value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Arriving Time',
                        border: OutlineInputBorder()),
                    onSaved: (String value) {
                      _arrivingTime = value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Time Duration From Last Stop',
                        border: OutlineInputBorder()),
                    onSaved: (String value) {
                      _timeDu = value;
                    },
                  ),
                  TextFormField(
                    controller: cnlatitude,
                    decoration: InputDecoration(
                        labelText: 'Latitude', border: OutlineInputBorder()),
                    /*onSaved: (String value) {
                    _publicPrivate = value;
                  },*/
                  ),
                  TextFormField(
                    controller: cnlongitude,
                    decoration: InputDecoration(
                        labelText: 'Longitude', border: OutlineInputBorder()),
                    /*onSaved: (String value) {
                      _publicPrivate = value;
                    },*/
                  ),
                  ElevatedButton(
                      child: Text(
                        'Add',
                        style: TextStyle(fontSize: 20),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.pink[400], // background
                        onPrimary: Colors.white, // foreground
                      ),
                      onPressed: () async {
                        // validate the form based on it's current state
                        
                          Map<String, dynamic> data = {
                            "Stop Name": stopName.text,
                            "Ariving Time": arrivingTime.text,
                            "Time Duration ": timeDu.text,
                            "Latitude": cnlatitude.text,
                            "Longitude": cnlongitude.text,
                          };

                          FirebaseFirestore.instance
                              .collection('Map data')
                              .add(data);

                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertBox('Successfully Inserted!');
                              });
                        
                      }),
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
    );
  }

  void onMapCreated(GoogleMapController controller) async {
    setState(() {
      mapController = controller;
    });
  }
}
