import 'package:flutter/material.dart';

class UserDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      //backgroundColor: Colors.red,
      backgroundColor: Colors.white70,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage('assets/images.png'),

              ),
              Text(
                '',
                style: TextStyle(
                  fontFamily: 'SourceSansPro',
                  fontSize: 25,
                ),
              ),
              Text(
                'Welcome',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'SourceSansPro',
                  color: Colors.black87,
                  letterSpacing: 2.5,
                ),
              ),
              SizedBox(
                height: 20.0,
                width: 200,
                child: Divider(
                  color: Colors.teal[100],
                ),
              ),

              Card(
                  color: Colors.white,
                  margin:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.account_box,
                      color: Colors.teal[900],
                    ),
                    title: Text(
                      'Name',
                      style:
                      TextStyle(fontFamily: 'BalooBhai', fontSize: 15.0,fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('Rakshitha Dilshan',
                      style: TextStyle(
                      fontSize: 14,
                      //fontWeight: FontWeight.bold,
                      //fontFamily: 'SourceSansPro',
                      color: Colors.black87,
                      //letterSpacing: 2.5,
                    ),
                    ),
                  )),
              Card(
                color: Colors.white,
                margin:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.email,
                    color: Colors.teal[900],
                  ),
                  title: Text(
                    'Email',
                    style: TextStyle(fontSize: 15.0, fontFamily: 'Neucha',fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('rakshihtadilshna1@gmail.com',
                    style: TextStyle(
                      fontSize: 14,
                      //fontWeight: FontWeight.bold,
                      //fontFamily: 'SourceSansPro',
                      color: Colors.black87,
                      //letterSpacing: 2.5,
                    ),
                  ),
                ),
              ),

              Card(
                color: Colors.white,
                margin:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.perm_identity,
                    color: Colors.teal[900],
                  ),
                  title: Text(
                    'NIC',
                    style: TextStyle(fontSize: 15.0, fontFamily: 'Neucha',fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('34242532534',
                    style: TextStyle(
                      fontSize: 14,
                      //fontWeight: FontWeight.bold,
                      //fontFamily: 'SourceSansPro',
                      color: Colors.black87,
                      //letterSpacing: 2.5,
                    ),

                  ),
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}