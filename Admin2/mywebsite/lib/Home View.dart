import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:mywebsite/SideBar.dart';

class Home extends StatelessWidget {
  static const String id = 'home';
  @override
  Widget build(BuildContext context) {
    SideBarWidget _sideBar = SideBarWidget();

    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Transport Management System'),
        backgroundColor: Colors.black,
      ),
      sideBar: _sideBar.sideBarMenus(context, Home.id),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 600,
            decoration: BoxDecoration(),
            padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 50.0),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40.0),
                  bottomRight: Radius.circular(40.0),
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Colors.black87,
                      Colors.black87,
                      Colors.black87,
                    ]),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 100, horizontal: 20),
                alignment: Alignment.center,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                      child: Text(
                        'Welcome To ezTransit Admin Dashboard',
                        style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white),
                      ),
                    ),
                    SizedBox(width: 50),
                    SizedBox(
                      height: 400,
                      width: 400,
                      child: Image(
                        image: AssetImage('assets/buslogo.png'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
