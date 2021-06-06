import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:mywebsite/SideBar.dart';

class AddBusOwner extends StatefulWidget {
  static const String id = 'addbusowner';
  @override
  _AddBusOwnerState createState() => _AddBusOwnerState();
}

class _AddBusOwnerState extends State<AddBusOwner> {
// reference for the form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _regno;
  String _email;
  String _nic;
  String _name;


//get data from textformfield
  TextEditingController regno = new TextEditingController();
  TextEditingController name = new TextEditingController();
  TextEditingController nic = new TextEditingController();
  TextEditingController email = new TextEditingController();




  Widget _buildRegNumber() {
    return TextFormField(
      controller: regno,
      decoration: InputDecoration(
          labelText: 'Registration No',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black),
          border: OutlineInputBorder()),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Registration Number is required';
        }
      },
      onSaved: (String value) {
        _regno = value;
      },
    );
  }

  Widget _buildOwnerName() {
    return TextFormField(
      controller: name,
      decoration: InputDecoration(
          labelText: 'Owner Name',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black),
          border: OutlineInputBorder()),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Owner Name is required';
        }
      },
      onSaved: (String value) {
        _name = value;
      },
    );
  }

  Widget _buildOwnerNic() {
    return TextFormField(
      controller: nic,
      decoration: InputDecoration(
          labelText: 'NIC Number',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black),
          border: OutlineInputBorder()),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Owner NIC Number is required';
        }
      },
      onSaved: (String value) {
        _nic = value;
      },
    );
  }

  Widget _buildOwnerEmail() {
    return TextFormField(
      controller: email,
      decoration: InputDecoration(
          labelText: 'Email',
          labelStyle: TextStyle(fontSize: 16, color: Colors.black),
          border: OutlineInputBorder()),
      validator: (String value) {
        if (value.isEmpty) {
          return ('Owner Email is required');
        }
      },
      onSaved: (String value) {
        _email = value;
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    SideBarWidget _sideBar = SideBarWidget();
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Add Bus Owner'),
        backgroundColor: Colors.black,
      ),
      sideBar: _sideBar.sideBarMenus(context, AddBusOwner.id),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 1.3 * MediaQuery.of(context).size.height,
            decoration: BoxDecoration(),
            padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 350.0),
            child: Center(
              child: Card(
                color: Colors.white,
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
                        _buildRegNumber(),
                        SizedBox(height: 10.0),
                        _buildOwnerName(),
                        SizedBox(height: 10.0),
                        _buildOwnerNic(),
                        SizedBox(height: 10.0),
                        _buildOwnerEmail(),
                        SizedBox(height: 30.0),

                        Row(

                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(

                              child: SizedBox(width: 175,
                                child: ElevatedButton(


                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical:12.0,horizontal: 20),
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
                                          "bizRegNo": regno.text,
                                          "ownerEmail": email.text,
                                          "ownerNIC": nic.text,
                                          "ownerName": name.text,

                                        };

                                        String owname=name.text;

                                        FirebaseFirestore.instance
                                            .collection('owners')
                                            .doc('$owname')
                                            .set(data);

                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertBox(
                                                  'Successfully Inserted!');
                                            });
                                        _formKey.currentState.reset();
                                      }
                                    }),
                              ),
                            ),
                            SizedBox(width: 80.0),
                            SizedBox(width: 175,
                              child: ElevatedButton(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 12.0,horizontal:20.0 ),
                                    child: Text(
                                      'Cancel',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.black87, // background
                                    onPrimary: Colors.white, // foreground
                                  ),
                                  onPressed: () async {
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
