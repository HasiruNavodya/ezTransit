import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tma_passenger/main.dart';
import 'package:tma_passenger/screens/auth/signup.dart';

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email, _password;
  final auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Form(
          key: _formkey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 18.0),
            children: <Widget>[
              Column(
                  children: <Widget>[
                    SizedBox(height: 180.0,),
                    Image.asset('assets/Square_Logo.jpg'),
                    Text('LOGIN', style: TextStyle(fontSize: 20),),
                  ]
              ),
              SizedBox(height: 40.0,),
              TextFormField(
                validator: (input) {
                  if(input.isEmpty){
                    return 'Please Enter Email';
                  }
                  if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(input))
                  {
                    return "Please Enter Valid Email";
                  }
                  return null;
                },
                onSaved: (input) => _email = input,
                decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle: TextStyle(fontSize: 15),
                  filled: true,
                ),
              ),
              SizedBox(height: 20.0,),
              TextFormField(
                validator: (input) {
                  if (input.isEmpty){
                    return 'Please Enter Password';
                  }
                  else{
                    return null;
                  }
                },
                onSaved: (input) => _password = input,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  labelStyle: TextStyle(fontSize: 15.0),
                  filled: true,
                ),
              ),
              SizedBox(height: 60.0,),
              Column(
                children: <Widget>[
                  ButtonTheme(
                    height: 40,
                    disabledColor: Colors.grey,
                    child: RaisedButton(
                      disabledElevation: 4.0,
                      onPressed: signIn,
                      child: Text('Sign In', style: TextStyle(fontSize: 18.0),),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.0,),
              GestureDetector(
                child: Text("Sign Up Here", style: TextStyle(decoration: TextDecoration.underline, color: Colors.blueAccent,letterSpacing: 2, fontSize: 17.0),textAlign: TextAlign.center,),
                onTap: (){
                  //streamController.add(0);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> signIn() async{

    final formState = _formkey.currentState;
    if(formState.validate()){
      formState.save();
      try {
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _email,
            password: _password,);
        print("alks;fjlkjd");
        streamController.add(0);
      }catch(e) {
        print("e.message");
      }
      }

  }


}
