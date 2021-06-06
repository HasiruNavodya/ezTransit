import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:mywebsite/SideBar.dart';
import 'package:mywebsite/mapnew.dart';

class InitializeTrip extends StatefulWidget {
  static const String id = 'initializeTrip';

  static String tid;

  static String tripID;
  @override
  _InitializeTripState createState() => _InitializeTripState();
}

class _InitializeTripState extends State<InitializeTrip> {
// reference for the form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _tripID;
  String _bus;
  String _startCity;
  String _startTime;
  String _endCity;
  String _endTime;
  String _stopCount;

//get data from textformfield
  TextEditingController tripID = new TextEditingController();
  TextEditingController bus = new TextEditingController();
  TextEditingController startCity = new TextEditingController();
  TextEditingController startTime = new TextEditingController();
  TextEditingController endCity = new TextEditingController();
  TextEditingController endTime = new TextEditingController();
  TextEditingController stopCount = new TextEditingController();

  Widget _buildtripID() {
    return TextFormField(
      controller: tripID,
      decoration: InputDecoration(
          labelText: 'Trip ID',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black),
          border: OutlineInputBorder()),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Trip ID is required';
        }
      },
      onSaved: (String value) {
        _tripID = value;
      },
    );
  }

  Widget _buildbusName() {
    return TextFormField(
      controller: bus,
      // maxLength: 30,
      decoration: InputDecoration(
          labelText: 'Bus',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black),
          border: OutlineInputBorder()),

      validator: (String value) {
        if (value.isEmpty) {
          return 'Bus Name is required';
        }
      },
      onSaved: (String value) {
        _bus = value;
      },
    );
  }

  Widget _buildstartCity() {
    return TextFormField(
      controller: startCity,
      decoration: InputDecoration(
          labelText: 'Start City',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black),
          border: OutlineInputBorder()),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Start City is required';
        }
      },
      onSaved: (String value) {
        _startCity = value;
      },
    );
  }

  Widget _buildstartTime() {
    return TextFormField(
      controller: startTime,
      decoration: InputDecoration(
          labelText: 'Start Time',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black),
          border: OutlineInputBorder()),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Start Time is required';
        }
      },
      onSaved: (String value) {
        _startTime = value;
      },
    );
  }

  Widget _buildendCity() {
    return TextFormField(
      controller: endCity,
      decoration: InputDecoration(
          labelText: 'End City',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black),
          border: OutlineInputBorder()),
      validator: (String value) {
        if (value.isEmpty) {
          return ('End City is required');
        }
      },
      onSaved: (String value) {
        _endCity = value;
      },
    );
  }

  Widget _buildendTime() {
    return TextFormField(
      controller: endTime,
      decoration: InputDecoration(
          labelText: 'End Time',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black),
          border: OutlineInputBorder()),
      validator: (String value) {
        if (value.isEmpty) {
          return ('End Time is required');
        }
      },
      onSaved: (String value) {
        _endTime = value;
      },
    );
  }

  Widget _buildstopCount() {
    return TextFormField(
      controller: stopCount,
      decoration: InputDecoration(
          labelText: 'Stop Count',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black),
          border: OutlineInputBorder()),
      validator: (String value) {
        if (value.isEmpty) {
          return ('Stop Count is required');
        }
      },
      onSaved: (String value) {
        _stopCount = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SideBarWidget _sideBar = SideBarWidget();

    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Initialize Trip'),
        backgroundColor: Colors.black,
      ),
      sideBar: _sideBar.sideBarMenus(context, InitializeTrip.id),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 1.1 * MediaQuery.of(context).size.height,
            decoration: BoxDecoration(),
            padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 350.0),
            child: Card(
              color: Colors.white,
              elevation: 20.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(35),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  //because of this global key we can acess build in validations
                  key: _formKey,

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      _buildtripID(),
                      SizedBox(height: 10.0),
                      _buildbusName(),
                      SizedBox(height: 10.0),
                      _buildstartCity(),
                      SizedBox(height: 10.0),
                      _buildstartTime(),
                      SizedBox(height: 10.0),
                      _buildendCity(),
                      SizedBox(height: 30.0),
                      _buildendTime(),
                      SizedBox(height: 30.0),
                      _buildstopCount(),
                      SizedBox(height: 30.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 175,
                            child: ElevatedButton(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12.0, horizontal: 20),
                                  child: Text(
                                    'Submit',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.black87, // background
                                  onPrimary: Colors.white, // foreground
                                ),
                                onPressed: () async {
                                  // validate the form based on it's current state
                                  if (_formKey.currentState.validate()) {
                                    Map<String, dynamic> data = {
                                      "tripID": tripID.text,
                                      "bus": bus.text,
                                      "startCity": startCity.text,
                                      "startTime": startTime.text,
                                      "endCity": endCity.text,
                                      "endTime": endTime.text,
                                      "stopCount": stopCount.text,
                                      'ticketCount': 0,
                                    };
                                    String tid = tripID.text;
                                    FirebaseFirestore.instance
                                        .collection("trips")
                                        .doc("$tid")
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
                                            builder: (BuildContext context) =>
                                                MapClickPageNew(tripID.text)));

                                    ;
                                  }
                                }),
                          ),
                          SizedBox(width: 90.0),
                          SizedBox(
                            width: 175,
                            child: ElevatedButton(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12.0, horizontal: 20.0),
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.black87, // background
                                  onPrimary: Colors.white, // foreground
                                ),
                                onPressed: () {
                                  _formKey.currentState.reset();
                                }),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
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
