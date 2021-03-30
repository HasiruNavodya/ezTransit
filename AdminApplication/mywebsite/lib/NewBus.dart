import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:mywebsite/SideBar.dart';

class NewBus extends StatefulWidget {
  static const String id = 'newbus';
  @override
  _NewBusState createState() => _NewBusState();
}

class _NewBusState extends State<NewBus> {
// reference for the form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _plateNumber;
  String _driverName;
  String _licenseNumber;
  String _color;
  String _publicPrivate;
  String _luxeryLevel;
  String _seat;

//get data from textformfield
  TextEditingController plateNumber = new TextEditingController();
  TextEditingController driverName = new TextEditingController();
  TextEditingController licenseNumber = new TextEditingController();
  TextEditingController color = new TextEditingController();
  TextEditingController publicPrivate = new TextEditingController();
  TextEditingController luxeryLevel = new TextEditingController();
  TextEditingController seat = new TextEditingController();

  Widget _buildPlateNumber() {
    return TextFormField(
      controller: plateNumber,
      decoration: InputDecoration(
          labelText: 'Plate Number',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black),
          border: OutlineInputBorder()),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Plate Number is required';
        }
      },
      onSaved: (String value) {
        _plateNumber = value;
      },
    );
  }

  Widget _buildDriverName() {
    return TextFormField(
      controller: driverName,
      maxLength: 30,
      decoration: InputDecoration(
          labelText: 'Driver Name',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black),
          border: OutlineInputBorder()),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Driver Name is required';
        }
      },
      onSaved: (String value) {
        _driverName = value;
      },
    );
  }

  Widget _buildLicenseNumber() {
    return TextFormField(
      controller: licenseNumber,
      decoration: InputDecoration(
          labelText: 'Driver License Number',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black),
          border: OutlineInputBorder()),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Driver License Number is required';
        }
      },
      onSaved: (String value) {
        _licenseNumber = value;
      },
    );
  }

  Widget _buildColor() {
    return TextFormField(
      controller: color,
      decoration: InputDecoration(
          labelText: 'Color',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black),
          border: OutlineInputBorder()),
      validator: (String value) {
        if (value.isEmpty) {
          return ('Color is required');
        }
      },
      onSaved: (String value) {
        _color = value;
      },
    );
  }

  Widget _buildPublicPrivate() {
    return TextFormField(
      controller: publicPrivate,
      decoration: InputDecoration(
          labelText: 'Public / Private',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black),
          border: OutlineInputBorder()),
      maxLength: 7,
      validator: (String value) {
        if (value.isEmpty) {
          return ('This field is required');
        }
      },
      onSaved: (String value) {
        _publicPrivate = value;
      },
    );
  }

  Widget _buildLuxeryLevel() {
    return TextFormField(
      controller: luxeryLevel,
      decoration: InputDecoration(
          labelText: 'Luxery Level',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black),
          border: OutlineInputBorder()),
      maxLength: 15,
      validator: (String value) {
        if (value.isEmpty) {
          return ('This field is required');
        }
      },
      onSaved: (String value) {
        _luxeryLevel = value;
      },
    );
  }

  Widget _buildSeat() {
    return TextFormField(
      controller: seat,
      decoration: InputDecoration(
        // fillColor: Colors.white,
        //filled: true,
        labelText: 'Seat Count',
        labelStyle: TextStyle(fontSize: 16, color: Colors.black),
        border: OutlineInputBorder(),
      ),
      maxLength: 3,
      validator: (String value) {
        if (value.isEmpty) {
          return ('Seat count is required');
        }
      },
      onSaved: (String value) {
        _seat = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SideBarWidget _sideBar = SideBarWidget();
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Add New Bus'),
      ),
      sideBar: _sideBar.sideBarMenus(context, NewBus.id),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 1.2 * MediaQuery.of(context).size.height,
            decoration: BoxDecoration(),
            padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 350.0),
            child: Center(
              child: Card(
                color: Colors.blue[200],
                elevation: 20.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(35),
                  ),
                ),
                // padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),

                /*decoration: BoxDecoration(
               // color:Colors.blue[300],
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
                      Colors.blue[400],
                    ]),
              ),*/
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    //because of this global key we can acess build in validations
                    key: _formKey,

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        _buildPlateNumber(),
                        SizedBox(height: 10.0),
                        _buildDriverName(),
                        SizedBox(height: 10.0),
                        _buildLicenseNumber(),
                        SizedBox(height: 10.0),
                        _buildColor(),
                        SizedBox(height: 10.0),
                        _buildPublicPrivate(),
                        SizedBox(height: 10.0),
                        _buildLuxeryLevel(),
                        SizedBox(height: 10.0),
                        _buildSeat(),
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
                                      "Plate Number": plateNumber.text,
                                      "Driver Name": driverName.text,
                                      "License Number": licenseNumber.text,
                                      "Color": color.text,
                                      "Public or Private": publicPrivate.text,
                                      "Luxury Level": luxeryLevel.text,
                                      "Seat Count": seat.text,
                                    };

                                    FirebaseFirestore.instance
                                        .collection('NewBus')
                                        .add(data);

                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertBox(
                                              'Successfully Inserted!');
                                        });
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
                                onPressed: () async {
                                  _formKey.currentState.reset();
                                }),
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
