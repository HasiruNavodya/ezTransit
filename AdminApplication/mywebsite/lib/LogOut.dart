

import 'package:flutter/material.dart';
import 'package:mywebsite/auth.dart';
import 'package:mywebsite/login.dart';

class LogOut extends StatefulWidget {
  static const String id = 'logout';
  @override
  _LogOutState createState() => _LogOutState();
}

class _LogOutState extends State<LogOut> {
  
  @override
  Widget build(BuildContext context) {
  
return Column( 
 children:[
   
   AuthService().signOut(),
  // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context )=>LoginPage())),

 ],
      
 // AuthService().signOut(), 
     
  
//AuthService().signOut(),

     
);
      
  }} 
    
      
