import 'package:flutter/material.dart';
import 'package:mywebsite/NavBar.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       

      body: Container(
         
      decoration:BoxDecoration(
        gradient: LinearGradient(
          begin:Alignment.centerLeft,
          end: Alignment.centerRight,
          colors:[
            Colors.blue[400],
            Colors.blue[600],
            Colors.blue[900],
            Colors.indigo[900],
            Colors.deepPurple[900],
         //  Color.fromRGBO(195,20,50,1.0),
       // Color.fromRGBO(36,11,54,1.0),
        ]),
      ),
      child:Column(
        children:[
Navigation()
        ],
      ),
      
        
      ),
    );
  }
}

