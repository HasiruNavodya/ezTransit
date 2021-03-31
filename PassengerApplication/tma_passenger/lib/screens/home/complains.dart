
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home.dart';




class Complaints extends StatefulWidget {



  @override
  _complaintsState createState() => _complaintsState();
}

class _complaintsState extends State<Complaints> {

  GlobalKey<FormState> formkey = GlobalKey<FormState>();


  void validate(){
    if(formkey.currentState.validate()){
      print("not validated");
    }else {
      print("validated");
    }
  }


  DateTime dateToday = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day) ;


  TextEditingController ComplaintBusNo= new TextEditingController();
  TextEditingController ComplaintDescription= new TextEditingController();

  String complaint;
  String plateno;
  String time;



  @override
  Widget build(BuildContext context) {
    print('dsfsdfsdfdsfsdfdsfdsfdsfdsf'+dateToday.toString());


    //
    // Future<void> Complaints() {
    //   // Call the user's CollectionReference to add a new user
    //   return addComplain
    //       .add({
    //     'Complaint': complaint, // John Doe
    //     'Plate Number': plateno, // Stokes and Sons
    //     'time': '1.00' // 42
    //   })
    //       .then((value) => print("Reported Complaint Succesfully"))
    //       .catchError((error) => print("Failed: $error"));
    // }



    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeView()),
              );
            }

        ),
        centerTitle: true,
        title: Text('User Complaints'),
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Form(
          autovalidate: true,
          key: formkey,
          child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 18.0),
              children: <Widget>[
                Column(
                  children: <Widget>[
                    SizedBox(height: 60.0,),
                    Text('Bus Number', style: TextStyle(fontSize: 20),textAlign: TextAlign.left,),
                    SizedBox(height: 20.0,),
                  ],
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty){
                      return 'Enter Title';
                    }
                    else{
                      return null;
                    }
                  },
                  /*onSaved: (String ComplaintTitle){
                    _complaitTitle = ComplaintTitle ;
                  },*/
                  controller: ComplaintBusNo,
                  decoration: InputDecoration(
                    //labelText: "Title",
                    labelStyle: TextStyle(fontSize: 15),
                    filled: true,
                  ),
                ),
                Column(
                  children: <Widget>[
                    SizedBox(height: 40.0,),
                    Text('Complaint', style: TextStyle(fontSize: 20),textAlign: TextAlign.left,),
                    SizedBox(height: 20.0,),
                  ],
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty){
                      return 'Please Describe ';
                    }
                    else{
                      return null;
                    }
                  },
                  /*onSaved: (String ComplaintDescription){
                    _complaintDescription = ComplaintDescription;
                  },*/
                  controller: ComplaintDescription,
                  decoration: InputDecoration(
                    //labelText: "Title",
                    labelStyle: TextStyle(fontSize: 15),
                    filled: true,
                  ),
                  maxLines: 8,
                ),
                SizedBox(height: 30.0,),
                Column(
                  children: <Widget>[
                    ButtonTheme(
                      height: 40,
                      disabledColor: Colors.grey,
                      child: RaisedButton(color:Colors.black87,
                        disabledElevation: 4.0,
                        onPressed: () {
                          // Map<String,dynamic> data = {"Plate Number": ComplaintBusNo.text,"Complaint":ComplaintDescription.text,"time":'12.00'};
                          FirebaseFirestore.instance.collection("complaints").add({"Plate Number": ComplaintBusNo.text,"Complaint":ComplaintDescription.text,"time":dateToday.toString()})
                              .then((value) => print("Complain Reported Successfully!"))
                              .catchError((error) => print("Failed to add user: $error"));
                          showAlertDialog(context);

                        },
                        child: Text('Submit',
                          style: TextStyle(fontSize:15,fontWeight: FontWeight.bold,color:Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ]
          ),
        ),
      ),
    );
  }
  showAlertDialog(BuildContext context) {

    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Complaint Recorded Successfully!"),
      content: Text("Thank You!"),
      actions: [
        okButton,

      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}