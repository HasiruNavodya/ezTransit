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
      appBar: AppBar(
        title: Text("Welcome"),
        backgroundColor: Colors.black,
        centerTitle: true,

      ),
      body: SafeArea(
        child: Form(
          key: _formkey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20.0,),
            children: <Widget>[
              Column(
                  children: <Widget>[
                    SizedBox(height: 40.0,),
                    CircleAvatar(
                      radius: 70,
                      backgroundImage: AssetImage('assets/login1.png'),


                    ),
                    SizedBox(height: 40.0,),
                    Text('LOG IN',  style: TextStyle(fontSize:20,fontWeight: FontWeight.bold,color:Colors.black,
                    ),),
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
                    child: RaisedButton(color:Colors.black87,

                      disabledElevation: 4.0,
                      onPressed: signIn,
                      child: Text('Sign In',  style: TextStyle(fontSize:15,fontWeight: FontWeight.bold,color:Colors.white,
                      ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.0,),

              TextButton(
                child: Text("Sign Up",
                  style: TextStyle(fontSize:15,fontWeight: FontWeight.bold,color:Colors.lightBlue,
                  ),

                ),

                onPressed: (){
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
        print("Logged In");
        streamController.add(0);
      }catch(e) {
        print("e.message");
        showAlertDialogTwo(context);
      }
      }

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
      content: Text("Email or Password Incorrect!"),
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
