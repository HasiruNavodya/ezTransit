
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tma_passenger/screens/home/ride.dart';

import 'home.dart';




class Complaints extends StatefulWidget {

  Complaints(this.plateno);

  final String plateno;

  @override
  _ComplaintsState createState() => _ComplaintsState();
}

class _ComplaintsState extends State<Complaints> {

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
  void initState() {
    super.initState();

    ComplaintBusNo.text = widget.plateno;

  }

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
        centerTitle: true,
        title: Text('SUBMIT COMPLAINT'),
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          key: formkey,
          child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 18.0),
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 30.0,),
                    Text('Bus Plate Number', style: TextStyle(fontSize: 20),textAlign: TextAlign.left,),
                    SizedBox(height: 20.0,),
                  ],
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty){
                      return 'Enter Plate No of the Bus';
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
                    labelText: "Bus Plate No",
                    labelStyle: TextStyle(fontSize: 15),
                    filled: true,
                    border: OutlineInputBorder(),
                    fillColor: Colors.white,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 40.0,),
                    Text('Complaint', style: TextStyle(fontSize: 20),textAlign: TextAlign.left,),
                    SizedBox(height: 20.0,),
                  ],
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty){
                      return 'Please Describe';
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
                    labelText: "Complaint",
                    labelStyle: TextStyle(fontSize: 15),
                    filled: true,
                    border: OutlineInputBorder(),
                    fillColor: Colors.white,
                  ),
                  maxLines: 10,
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

                          if(formkey.currentState.validate())
                          {
                            // Map<String,dynamic> data = {"Plate Number": ComplaintBusNo.text,"Complaint":ComplaintDescription.text,"time":'12.00'};
                            FirebaseFirestore.instance.collection("complaints").add({"Plate Number": ComplaintBusNo.text,"Complaint":ComplaintDescription.text,"time":dateToday.toString()})
                                .then((value) => print("Complain Reported Successfully!"))
                                .catchError((error) => print("Failed to add user: $error"));
                            showAlertDialog(context);
                            print("successfull");
                          }else
                          {
                            showAlertDialogTwo(context);
                            print("unsuccessfull");

                          }









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


  showAlertDialogTwo(BuildContext context) {

    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Alert"),
      content: Text("Please Fill All The Fields"),
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