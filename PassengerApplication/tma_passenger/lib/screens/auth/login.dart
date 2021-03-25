import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
            TextField(
              decoration: InputDecoration(
                labelText: "Email",
                labelStyle: TextStyle(fontSize: 15),
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
            SizedBox(height: 60.0,),
            Column(
              children: <Widget>[
                ButtonTheme(
                  height: 40,
                  disabledColor: Colors.grey,
                  child: RaisedButton(
                    disabledElevation: 4.0,
                    onPressed: null,
                    child: Text('Login', style: TextStyle(fontSize: 18.0),),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.0,),
            GestureDetector(
              child: Text("Sign Up Here", style: TextStyle(decoration: TextDecoration.underline, color: Colors.blueAccent,letterSpacing: 2, fontSize: 17.0),textAlign: TextAlign.center,),
              onTap: (){ },
            ),
          ],
        ),
      ),
    );
  }
}
