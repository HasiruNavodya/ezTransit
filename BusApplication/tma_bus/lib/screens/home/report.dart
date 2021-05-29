import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tma_bus/screens/home/home.dart';



class ReportEmergencyView extends StatefulWidget {
  @override
  _EmergencyState createState() => _EmergencyState();
}

class _EmergencyState extends State<ReportEmergencyView> {

  String _complaintDescription,_emergencyType;

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  void validate(){
    if(formkey.currentState.validate()){
      print("not validated");
    }else {
      print("validated");
    }
  }

  TextEditingController EmergencyType= new TextEditingController();
  TextEditingController ComplaintDescription= new TextEditingController();

  DateTime dateToday = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day) ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        centerTitle: true,
        title: Text('Emergency Report'),
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
                    Text('Emergency Type', style: TextStyle(fontSize: 20),textAlign: TextAlign.left,),
                    SizedBox(height: 20.0,),
                  ],
                ),
                TextFormField(
                  validator: (String value) {
                    if (value.isEmpty){
                      return 'Enter Type';
                    }
                    else{
                      return null;
                    }
                  },
                  onSaved: (String EmergencyType){
                    _emergencyType = EmergencyType ;
                  },
                  controller: EmergencyType,
                  decoration: InputDecoration(
                    //labelText: "Title",
                    labelStyle: TextStyle(fontSize: 15),
                    filled: true,
                  ),
                ),
                Column(
                  children: <Widget>[
                    SizedBox(height: 40.0,),
                    Text('Description', style: TextStyle(fontSize: 20),textAlign: TextAlign.left,),
                    SizedBox(height: 20.0,),
                  ],
                ),
                TextFormField(
                  validator: (String value) {
                    if (value.isEmpty){

                      return 'Please Describe ';


                    }
                    else{
                      return null;
                    }
                  },
                  onSaved: (String complaintDescription){
                    _complaintDescription = complaintDescription;
                  },
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
                        onPressed: (){


                          if(formkey.currentState.validate())
                          {
                            FirebaseFirestore.instance.collection("emergencies").add({"Description":ComplaintDescription.text,"time":dateToday.toString(),"type":EmergencyType.text})
                                .then((value) => print("Complain Reported Successfully!"))
                                .catchError((error) => print("Failed to add user: $error"));
                            showAlertDialog(context);
                            print("successfull");
                          }else
                          {
                            showAlertDialogTwo(context);
                            print("unsuccessfull");

                          }

                          // Map<String,dynamic> data = {"Plate Number": ComplaintBusNo.text,"Complaint":ComplaintDescription.text,"time":'12.00'};





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
      title: Text("Emergency Reported Successfully!"),
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
      content: Text("Please Fill All The Records"),
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


