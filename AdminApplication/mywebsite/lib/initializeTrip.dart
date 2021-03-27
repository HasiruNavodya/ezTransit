import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mywebsite/AddTrip.dart';
import 'package:mywebsite/mapnew.dart';

class InitializeTrip extends StatefulWidget {
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
          InputDecoration(labelText: 'trip ID', border: OutlineInputBorder()),
      validator: (String value) {
        if (value.isEmpty) {
          return 'trip ID is required';
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
    return Scaffold(
        appBar: AppBar(
          title: Text('Initialize Trip'),
          elevation: 0.0,
        ),
        body: //Column(

            // children:[
            Container(

                // height: MediaQuery.of(context).size.height*6,
                //width:0.4 * MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 400.0),
                child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Colors.blue[100],
                    elevation: 6.0,
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
                                          'Next',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.red, // background
                                          onPrimary: Colors.white, // foreground
                                        ),
                                        onPressed: () async {
                                          // validate the form based on it's current state
                                          if (_formKey.currentState
                                              .validate()) {
                                            Map<String, dynamic> data = {
                                              "Trip ID": tripID.text,
                                              "Bus Name": busName.text,
                                              "Start City": startCity.text,
                                              "End City": endCity.text,
                                            };

                                            FirebaseFirestore.instance
                                                .collection('initialize trip')
                                                .add(data);

                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertBox(
                                                      'Successfully Inserted!');
                                                });
                                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context )=>MapClickPageNew()));
                                                
                                                ;
                                          }
                                        }),
                                   
                                  ])
                            ])))));
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
