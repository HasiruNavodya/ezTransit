import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tma_passenger/main.dart';
import 'package:tma_passenger/screens/auth/login.dart';
import 'package:tma_passenger/screens/auth/signup.dart';


class Register extends StatefulWidget {

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  String _name,_email,_nic,_password,_confirmPassword,_phoneNo;

  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  TextEditingController fullName= new TextEditingController();
  TextEditingController email= new TextEditingController();
  TextEditingController nIC= new TextEditingController();
  TextEditingController phoneNo= new TextEditingController();

/*  TextEditingController password= new TextEditingController();
  TextEditingController confirmPassword= new TextEditingController();*/

  @override
  void initState() {
    super.initState();

    //phoneNo.text = '+94';

  }

  @override
  Widget build(BuildContext context)  {
    return Scaffold(
      appBar: AppBar(
        title: Text("SIGN UP"),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Form(
            key: _formkey,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              children: <Widget>[
                SizedBox(height: 20.0,),
                Icon(
                  Icons.account_circle,
                  color: Colors.black,
                  size:50.0,
                ),


                SizedBox(height:10.0,),
                Column(
                  children: <Widget>[

                    Text('Welcome to ezTransit !', style: TextStyle(fontSize:22,fontWeight: FontWeight.bold,color:Colors.black,),),
                  ],
                ),
                SizedBox(height: 20.0,),
                TextFormField(
                  validator: (String value){
                    if(value.isEmpty)
                    {
                      return "Please Enter Name";
                    }
                    return null;
                  },
                  onSaved: (String name){
                    _name = name;
                  },
                  controller: fullName,
                  decoration: InputDecoration(
                    labelText: "Full Name",
                    labelStyle: TextStyle(fontSize: 15.0),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(
                      Icons.person,
                    ),
                  ),
                ),
                SizedBox(height: 20.0,),
                TextFormField(

                  validator: (String value){
                    if(value.isEmpty)
                    {
                      return "Please Enter Email";
                    }
                    if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value))
                    {
                      return "Please Enter Valid Email";
                    }
                    return null;
                  },
                  onSaved: (String email){
                    _email = email;
                  },

                  controller: email,
                  decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(fontSize: 15.0),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(
                      Icons.email,
                    ),
                  ),
                ),
                SizedBox(height: 20.0,),
                TextFormField(

                  validator: (String value){
                    if(value.isEmpty)
                    {
                      return "Please Enter NIC Number";
                    }
                    if(!RegExp(r"^([0-9]{9}[x|X|v|V]|[0-9]{12})$").hasMatch(value))
                    {
                      return "Please Enter Valid NIC Number";
                    }
                    return null;
                  },
                  onSaved: (String nIC){
                    _nic = nIC;
                  },

                  controller: nIC,
                  decoration: InputDecoration(
                    labelText: "NIC Number",
                    labelStyle: TextStyle(fontSize: 15.0),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(
                      Icons.credit_card,
                    ),
                  ),
                ),
                SizedBox(height: 20.0,),
                TextFormField(

                  controller: phoneNo,

                  validator: (String value){
                    if(value.isEmpty)
                    {
                      return "Please Enter Phone Number";
                    }
                    return null;
                  },
                  onSaved: (String phonenum){
                    _phoneNo = phonenum;
                  },

                  decoration: InputDecoration(
                    labelText: "Phone Number (07XXXXXXXX)",
                    labelStyle: TextStyle(fontSize: 15.0),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(
                      Icons.phone_android,
                    ),
                  ),
                ),
                SizedBox(height: 20.0,),
                TextFormField(

                  controller: password,

                  validator: (String value){
                    if(value.isEmpty)
                    {
                      return "Please Enter Password";
                    }
                    return null;
                  },
                  onSaved: (String password){
                    _password = password;
                  },

                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(fontSize: 15.0),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(
                      Icons.lock,
                    ),
                  ),
                ),
                SizedBox(height: 20.0,),
                TextFormField(
                  controller: confirmPassword,
                  validator: (String value){
                    if(value.isEmpty)
                    {
                      return "Please Confirm Password";
                    }
                    if(password.text != confirmPassword.text)
                    {
                      return "Password do not Match";
                    }
                    return null;
                  },
                  onSaved: (String confirmPassword){
                   _confirmPassword = confirmPassword;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Confirm Password",
                    labelStyle: TextStyle(fontSize: 15.0),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(
                      Icons.lock,
                    ),

                  ),
                ),
                SizedBox(height: 30.0,),
                Column(
                  children: <Widget>[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                      ),
                      onPressed:(){

                        if(_formkey.currentState.validate())
                          {
                            Map <String,dynamic> data= {
                              "FullName": fullName.text,
                              "Email": email.text,
                              "NIC": nIC.text,
                              "PhoneNo": phoneNo.text,
                              "Password": password.text,
                              "ConfirmPassword": confirmPassword.text
                            };
                            FirebaseFirestore.instance.collection("passengers").doc(email.text).set(data);
                            signUp();
                          }else
                            {
                              print("unsuccessfull");
                            }


                      },
                      child: Text('SIGN UP',style: TextStyle(fontSize: 15, color: Colors.white)),
                    ),
                    SizedBox(height: 20.0,),

                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
    }
  Future<void> signUp() async{

    final formState = _formkey.currentState;
    if(formState.validate()){
      formState.save();
      try {
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _email,
          password: _password,
        );
        showAlertDialog(context);
      }catch(e) {
        print(e.message);
      }
    }

  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(
        "YES",
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.red,
        ),
      ),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text(
        "OK",
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.black,
        ),
      ),
      onPressed:  () {
        Navigator.pop(context);
        streamController.add('2');
        Navigator.of(context).popUntil((route) => route.isFirst);
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text("Registration Succesfull"),
      content: Text("Now you can Log In"),
      actions: [
        //cancelButton,
        continueButton,
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

