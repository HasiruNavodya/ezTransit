import 'package:flutter/material.dart';
//import 'package:mywebsite/auth.dart';
import 'package:mywebsite/map.dart';

import 'map.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text('You are logged in'),
      ElevatedButton(
          onPressed: () {
            //AuthService().signOut();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MapSample()),
              );
          },
          child: Center(child: Text('LOG OUT')))
          
    ]));
  }
}