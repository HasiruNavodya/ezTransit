import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:mywebsite/SideBar.dart';
import 'package:mywebsite/mapnew.dart';

class InitializeTrip extends StatefulWidget {
  static const String id = 'initializeTrip';
  @override
  _InitializeTripState createState() => _InitializeTripState();
}

class _InitializeTripState extends State<InitializeTrip> {
  

// reference for the form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _tripID;
  String _busName;
  String _startCity;
  String _endCity;

//get data from textformfield
  TextEditingController tripID = new TextEditingController();
  TextEditingController busName = new TextEditingController();
  TextEditingController startCity = new TextEditingController();
  TextEditingController endCity = new TextEditingController();

  Widget _buildtripID() {
    return TextFormField(
      controller: tripID,
      decoration:
          InputDecoration(labelText: 'Trip ID', border: OutlineInputBorder()),
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
      controller: busName,
      // maxLength: 30,
      decoration:
          InputDecoration(labelText: 'Bus Name', border: OutlineInputBorder()),

      validator: (String value) {
        if (value.isEmpty) {
          return 'Bus Name is required';
        }
      },
      onSaved: (String value) {
        _busName = value;
      },
    );
  }

  Widget _buildstartCity() {
    return TextFormField(
      controller: startCity,
      decoration: InputDecoration(
          labelText: 'Start City', border: OutlineInputBorder()),
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

  Widget _buildendCity() {
    return TextFormField(
      controller: endCity,
      decoration:
          InputDecoration(labelText: 'End City', border: OutlineInputBorder()),
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

  @override
  Widget build(BuildContext context) {
 SideBarWidget _sideBar = SideBarWidget();
    
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Initialize Trip'),
        

      ),
      sideBar: _sideBar.sideBarMenus(context, InitializeTrip.id),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 1.3*MediaQuery.of(context).size.width,
            height: 0.9*MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
             /* gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.blue[400],
                    Colors.blue[600],
                    Colors.blue[900],
                    Colors.indigo[900],
                    Colors.deepPurple[900],
                  ]),*/
            ),
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 350.0),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 25.0),
              width: 0.4 * MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40.0),
                  bottomRight: Radius.circular(40.0),
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Colors.blue[400],
                      Colors.blue[100],
                    ]),
              ),
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
                    _buildendCity(),
                    SizedBox(height: 10.0),
                    SizedBox(height: 5.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            child: Text(
                              'Submit',
                              style: TextStyle(fontSize: 20),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.pink[400], // background
                              onPrimary: Colors.white, // foreground
                            ),
                            onPressed: () async {
                              // validate the form based on it's current state
                              if (_formKey.currentState.validate()) {
                                Map<String, dynamic> data = {
                                  "Trip ID": tripID.text,
                                  "Bus Name": busName.text,
                                  "Start City": startCity.text,
                                  "End City": endCity.text,
                                };

                                FirebaseFirestore.instance
                                    .collection("trips")
                                    .doc("initializeTrip")
                                    .set(data);

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

                                ;
                              }
                            }),
                        SizedBox(width: 50.0),
                        ElevatedButton(
                            child: Text(
                              'Cancel',
                              style: TextStyle(fontSize: 20),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.pink[400], // background
                              onPrimary: Colors.white, // foreground
                            ),
                            onPressed: () {
                              _formKey.currentState.reset();
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
      ), );}}
    /*return Scaffold(
      appBar: AppBar(
        title: Text('Initialize Trip'),
        centerTitle: true,
        backgroundColor: Colors.pink[400],
        elevation: 0.0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 1.3 * MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.blue[400],
                    Colors.blue[600],
                    Colors.blue[900],
                    Colors.indigo[900],
                    Colors.deepPurple[900],
                  ]),
            ),
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 400.0),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 25.0),
              width: 0.4 * MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40.0),
                  bottomRight: Radius.circular(40.0),
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Colors.blue[400],
                      Colors.blue[100],
                    ]),
              ),
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
                    _buildendCity(),
                    SizedBox(height: 10.0),
                    SizedBox(height: 5.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            child: Text(
                              'Submit',
                              style: TextStyle(fontSize: 20),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.pink[400], // background
                              onPrimary: Colors.white, // foreground
                            ),
                            onPressed: () async {
                              // validate the form based on it's current state
                              if (_formKey.currentState.validate()) {
                                Map<String, dynamic> data = {
                                  "Trip ID": tripID.text,
                                  "Bus Name": busName.text,
                                  "Start City": startCity.text,
                                  "End City": endCity.text,
                                };

                                FirebaseFirestore.instance
                                    .collection("trips")
                                    .doc("initializeTrip")
                                    .set(data);

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

                                ;
                              }
                            }),
                        SizedBox(width: 50.0),
                        ElevatedButton(
                            child: Text(
                              'Cancel',
                              style: TextStyle(fontSize: 20),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.pink[400], // background
                              onPrimary: Colors.white, // foreground
                            ),
                            onPressed: () {
                              _formKey.currentState.reset();
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
      ),
    );
  }
}*/

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