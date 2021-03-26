import 'package:flutter/material.dart';
import 'package:mywebsite/NavBar.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Colors.blue[400],
                Colors.blue[600],
                Colors.blue[900],
                Colors.indigo[900],
                Colors.deepPurple[900],
               
              ]),
        ),
        child: Column(
          children: [Navigation()],
        ),
      ),
    );
  }
}
