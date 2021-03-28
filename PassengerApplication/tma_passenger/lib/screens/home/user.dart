import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tma_passenger/screens/auth/login.dart';

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
      body:StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("passengers")
            .where('Email', isEqualTo: 'hasiru@gmail.com').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                return Column(

                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 60,
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
                                TextStyle(fontFamily: 'BalooBhai',
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text('${document.data()['FullName']}',
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
                              style: TextStyle(fontSize: 15.0,
                                  fontFamily: 'Neucha',
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text('${document.data()['Email']}',
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
                              Icons.account_circle,
                              color: Colors.teal[900],
                            ),
                            title: Text(
                              'NIC',
                              style: TextStyle(fontSize: 15.0,
                                  fontFamily: 'Neucha',
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text('${document.data()['NIC']}',
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
                        ElevatedButton(

                          onPressed: () {
                            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                            LoginPage()), (Route<dynamic> route) => false);
                          },
                          child: Text('Logout'),
                        ),




                  ],



                );

                //Card(child: Text(document.data()['name']??'default'),);
              }).toList(),

            ),

          );
        },
        
      ),
    );
  }
}