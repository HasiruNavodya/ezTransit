import 'package:flutter/material.dart';

class Account extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bus Account"),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {},
          child: Text('Logout'),
        ),
      ),
    );
  }
}