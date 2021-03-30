import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mywebsite/AddTrip.dart';
import 'package:mywebsite/Home%20View.dart';
import 'package:mywebsite/initializeTrip.dart';
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
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 25.0),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 40.0),
                  TextFormField(
                    //   key: ValueKey('stopName'),
                    controller: stopName,
                    decoration: InputDecoration(
                        labelText: 'Stop Name', border: OutlineInputBorder()),
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
                    //  key: ValueKey('timeDu'),
                    controller: timeDu,
                    decoration: InputDecoration(
                        labelText: 'Time Duration From Last Stop',
                        border: OutlineInputBorder()),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Time Duration From Last Stop is required';
                      }
                    },
                    onSaved: (String value) {
                      _timeDu = value;
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    //    key: ValueKey('cnlatitude'),
                    controller: cnlatitude,
                    decoration: InputDecoration(
                        labelText: 'Latitude', border: OutlineInputBorder()),
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
                        labelText: 'Longitude', border: OutlineInputBorder()),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return ('longitude is required');
                      }
                    },
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
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
                                  .collection("trips")
                                  .doc("initializeTrip")
                                  .collection("stop")
                                  .add(data);

                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertBox('Successfully Inserted!');
                                  });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          MapClickPageNew()));
                            
                          }),
                      SizedBox(width: 50.0),
                      ElevatedButton(
                          child: Text(
                            'Finish',
                            style: TextStyle(fontSize: 20),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.pink[400], // background
                            onPrimary: Colors.white, // foreground
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) => Home()));
                          }),
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
