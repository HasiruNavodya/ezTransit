import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

/*class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'register',
      home: Register(),
    );
  }
}*/
class Register extends StatefulWidget {

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  String _name,_email,_nic;

  TextEditingController _password = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  TextEditingController fullName= new TextEditingController();
  TextEditingController email= new TextEditingController();
  TextEditingController nIC= new TextEditingController();
  TextEditingController password= new TextEditingController();
  TextEditingController confirmPassword= new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formkey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            children: <Widget>[
              Column(
                children: <Widget>[
                  SizedBox(height: 80.0,),
                  Text('REGISTER', style: TextStyle(fontSize: 20),),
                ],
              ),
              SizedBox(height: 60.0,),
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
                    return "Please Enter Name";
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

                controller: _password,

                validator: (String value){
                  if(value.isEmpty)
                  {
                    return "Please Enter Password";
                  }
                  return null;
                },
                onSaved: (String nIC){
                  _nic = nIC;
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
                controller: _confirmPassword,
                validator: (String value){
                  if(value.isEmpty)
                  {
                    return "Please Confirm Password";
                  }
                  if(_password.text != _confirmPassword.text)
                  {
                    return "Password do not Match";
                  }
                  return null;
                },
                onSaved: (String nIC){
                  _nic = nIC;
                },
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Confirm Password",
                  labelStyle: TextStyle(fontSize: 15.0),
                  filled: true,

                ),
              ),
              SizedBox(height: 20.0,),
              Column(
                children: <Widget>[
                  ButtonTheme(
                    height: 50,
                    disabledColor: Colors.grey,
                    child: RaisedButton(
                      onPressed: (){

                        if(_formkey.currentState.validate())
                          {
                            Map <String,dynamic> data= {"FullName": fullName.text,"Email": email.text, "NIC": nIC.text, "Password": password.text, "ConfirmPassword": confirmPassword.text};
                            FirebaseFirestore.instance.collection("passengers").doc(email.text).set(data);
                          }else
                            {
                              print("unsuccessfull");
                            }


                      },
                      child: Text('Register',style: TextStyle(fontSize: 15, color: Colors.black)),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

