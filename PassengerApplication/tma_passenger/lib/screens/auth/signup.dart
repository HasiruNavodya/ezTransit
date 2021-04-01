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

  String _name,_email,_nic,_password,_confirmPassword;

  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  TextEditingController fullName= new TextEditingController();
  TextEditingController email= new TextEditingController();
  TextEditingController nIC= new TextEditingController();
/*  TextEditingController password= new TextEditingController();
  TextEditingController confirmPassword= new TextEditingController();*/
  @override
  Widget build(BuildContext context)  {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
          key: _formkey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            children: <Widget>[
              SizedBox(height: 10.0,),
              Icon(
                Icons.account_circle,
                color: Colors.black,
                size:150.0,
              ),


              SizedBox(height:10.0,),
              Column(
                children: <Widget>[

                  Text('Create Account', style: TextStyle(fontSize:22,fontWeight: FontWeight.bold,color:Colors.black,),),
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
                ),
              ),
              SizedBox(height: 20.0,),
              TextFormField(

                validator: (String value){
                  if(value.isEmpty)
                  {
                    return "Please Enter NIC";
                  }
                  if(!RegExp(r"^([0-9]{9}[x|X|v|V]|[0-9]{12})$").hasMatch(value))
                  {
                    return "Please Enter Valid NIC";
                  }
                  return null;
                },
                onSaved: (String nIC){
                  _nic = nIC;
                },

                controller: nIC,
                decoration: InputDecoration(
                  labelText: "NIC",
                  labelStyle: TextStyle(fontSize: 15.0),
                  filled: true,
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

                ),
              ),
              SizedBox(height: 30.0,),
              Column(
                children: <Widget>[
                  ButtonTheme(
                    height: 50,
                    disabledColor: Colors.grey,
                    child: RaisedButton(color:Colors.black87,
                      onPressed:(){

                        if(_formkey.currentState.validate())
                          {
                            Map <String,dynamic> data= {"FullName": fullName.text,"Email": email.text, "NIC": nIC.text, "Password": password.text, "ConfirmPassword": confirmPassword.text};
                            FirebaseFirestore.instance.collection("passengers").doc(email.text).set(data);
                            signUp();
                          }else
                            {
                              print("unsuccessfull");
                            }


                      },
                      child: Text('Sign Up',style: TextStyle(fontSize: 15, color: Colors.white)),
                    ),
                  ),
                  SizedBox(height: 20.0,),

                ],
              )
            ],
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
          password: _password,);
        var future = Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
        print("alks;fjlkjd");
      }catch(e) {
        print("e.message");
      }
    }

  }

}

