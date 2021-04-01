import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mywebsite/Home%20View.dart';
import 'package:mywebsite/SideBar.dart';

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

class Partial extends StatelessWidget {
  static const String id = 'partial routes';
  String _startIn;
  String _endIn;
  String _partNoF;
  String _fare;
  String _tripID = 'T3500';
  String _partNoS;
  String _name;

//get data from textformfield
  TextEditingController startIn = new TextEditingController();
  TextEditingController endIn = new TextEditingController();
  TextEditingController partNoF = new TextEditingController();
  TextEditingController fare = new TextEditingController();
  TextEditingController tripID = new TextEditingController();
  TextEditingController partNoS = new TextEditingController();
  TextEditingController name = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    SideBarWidget _sideBar = SideBarWidget();
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Transport Management System'),
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
                  color: Colors.blue[300],
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 40.0,
                        width: 30.0,
                      ),
                      SizedBox(
                        child: Text(
                          'Create Partial Routes',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      SizedBox(height: 45.0),
                      TextFormField(
                        controller: startIn,
                        decoration: InputDecoration(
                            labelText: 'Start In',
                            labelStyle:
                                TextStyle(fontSize: 16, color: Colors.black),
                            border: OutlineInputBorder()),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Start In is required';
                          }
                        },
                        onSaved: (String value) {
                          _startIn = value;
                        },
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        //key: ValueKey('arrivingTime'),
                        controller: endIn,
                        decoration: InputDecoration(
                            labelText: 'End In',
                            labelStyle:
                                TextStyle(fontSize: 16, color: Colors.black),
                            border: OutlineInputBorder()),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'End In is required';
                            //validator: (val) =>val.isEmpty?'This field is required':null,
                          }
                        },
                        onSaved: (String value) {
                          _endIn = value;
                        },
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        //  key: ValueKey('timeDu'),
                        controller: partNoF,
                        decoration: InputDecoration(
                            labelText: 'Part No',
                            labelStyle:
                                TextStyle(fontSize: 16, color: Colors.black),
                            border: OutlineInputBorder()),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Part No is required';
                          }
                        },
                        onSaved: (String value) {
                          _partNoF = value;
                        },
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        //    key: ValueKey('cnlatitude'),
                        controller: fare,
                        decoration: InputDecoration(
                            labelText: 'Fare',
                            labelStyle:
                                TextStyle(fontSize: 16, color: Colors.black),
                            border: OutlineInputBorder()),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return ('Fare is required');
                          }
                        },
                        onSaved: (String value) {
                          _fare = value;
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
                                    'Create',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.black87, // background
                                  onPrimary: Colors.white, // foreground
                                ),
                                onPressed: () async {
                                  // validate the form based on it's current state

                                  Map<String, dynamic> data = {
                                    "endin": endIn.text,
                                    "fare": fare.text,
                                    "partNo ": partNoF.text,
                                    "startin": startIn.text,
                                    "name": startIn.text + ' - ' + endIn.text,
                                  };

                                  String startinendin=startIn.text+'-'+endIn.text;

                                  FirebaseFirestore.instance
                                      .collection("partialroutes").doc('$startinendin')
                                      .set(data);
                                }),
                          ),
                          SizedBox(width: 50.0),
                        ],
                      )
                    ],
                  ),
                ),
              ),

              // ***********************right side

              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.only(
                      top: 60.0, bottom: 60.0, left: 300.0, right: 300.0),
                  color: Colors.blue[300],
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 30.0),
                      SizedBox(
                        child: Text(
                          'Add Partial Routes to Trips',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        controller: tripID,
                        decoration: InputDecoration(
                            labelText: 'Trip Id',
                            labelStyle:
                                TextStyle(fontSize: 16, color: Colors.black),
                            border: OutlineInputBorder()),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Trip Id is required';
                          }
                        },
                        onSaved: (String value) {
                          _tripID = value;
                        },
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        //key: ValueKey('arrivingTime'),
                        controller: partNoS,
                        decoration: InputDecoration(
                            labelText: 'Part No',
                            labelStyle:
                                TextStyle(fontSize: 16, color: Colors.black),
                            border: OutlineInputBorder()),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Part No is required';
                            //validator: (val) =>val.isEmpty?'This field is required':null,
                          }
                        },
                        onSaved: (String value) {
                          _endIn = value;
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
                                  // validate the form based on it's current state
                            /*      Map<String, dynamic> data = {
                                    "Trip Id": tripID.text,
                                    "Part No ": partNoS.text, 
                                  };*/

                                  FirebaseFirestore.instance
                                      .collection('trips')
                                      .doc('$tripID')
                                      .collection('stops')
                                      .doc('stop.id')
                                      .update({
                                    "Trip Id": tripID.text,
                                    "Part No ": partNoS.text,
                                  });

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
                                              Partial()));
                                }),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
