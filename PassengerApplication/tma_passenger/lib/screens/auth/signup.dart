import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'register',
      home: Register(),
    );
  }
}
class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
            TextField(
              decoration: InputDecoration(
                labelText: "Full Name",
                labelStyle: TextStyle(fontSize: 15.0),
                filled: true,
              ),
            ),
            SizedBox(height: 20.0,),
            TextField(
              decoration: InputDecoration(
                labelText: "Email",
                labelStyle: TextStyle(fontSize: 15.0),
                filled: true,
              ),
            ),
            SizedBox(height: 20.0,),
            TextField(
              decoration: InputDecoration(
                labelText: "NIC",
                labelStyle: TextStyle(fontSize: 15.0),
                filled: true,
              ),
            ),
            SizedBox(height: 20.0,),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
                labelStyle: TextStyle(fontSize: 15.0),
                filled: true,
              ),
            ),
            SizedBox(height: 20.0,),
            TextField(
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
                    onPressed: null,
                    child: Text('Register',style: TextStyle(fontSize: 15, color: Colors.black)),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

