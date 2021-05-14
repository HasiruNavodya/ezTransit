import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../main.dart';
import '../auth/login.dart';

String busEmail;
String bus;

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {

  @override
  void initState() {
    super.initState();

    FirebaseAuth auth = FirebaseAuth.instance;

    if (auth.currentUser != null) {
      print(auth.currentUser.email);
      busEmail = auth.currentUser.email;
      List list = busEmail.split('@');
      bus = list[0].toString().toUpperCase();
      print(bus);
    }
    //logout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bus Account"),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      backgroundColor: Colors.white70,
      body:StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("NewBus")
            .where('Plate Number', isEqualTo: bus).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return Padding(
            padding: const EdgeInsets.all(1.0),
            child: Stack(
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // CircleAvatar(
                    //   radius: 60,
                    //   backgroundImage: AssetImage('assets/images.png'),
                    //
                    // ),

                    SizedBox(
                      height: 0.0,
                      width: 200,
                      child: Divider(
                        color: Colors.teal[100],
                      ),
                    ),

                  Expanded(
                    flex: 1,
                    child:
                    Card(
                        color: Colors.white60,
                        margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                        child: ListTile(
                          leading: Icon(
                            Icons.account_box,
                            color: Colors.black87,
                          ),
                          title: Text(
                            'Name',
                            style:
                            TextStyle(fontFamily: 'BalooBhai',
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text('${document.data()['Driver Name']}',
                            style: TextStyle(
                              fontSize: 17,
                              // fontWeight: FontWeight.w900,
                              //fontFamily: 'SourceSansPro',
                              color: Colors.black87,
                              //letterSpacing: 2.5,
                            ),
                          ),
                        )),

                  ),
                   Expanded(
                     flex: 1,
                       child:
                       Card(
                         color: Colors.white60,
                         margin:
                         EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                         child: ListTile(
                           leading: Icon(
                             Icons.directions_bus_sharp,
                             color: Colors.black87,
                           ),
                           title: Text(
                             'Bus Number Plate',
                             style: TextStyle(fontSize: 17.0,
                                 fontFamily: 'Neucha',
                                 fontWeight: FontWeight.bold),
                           ),
                           subtitle: Text('${document.data()['Plate Number']}',
                             style: TextStyle(
                               fontSize: 17,
                               //fontWeight: FontWeight.bold,
                               //fontFamily: 'SourceSansPro',
                               color: Colors.black87,
                               //letterSpacing: 2.5,
                             ),
                           ),
                         ),
                       ),

                   ),


                    Expanded(
                      flex: 1,
                        child:Card(
                          color: Colors.white60,
                          margin:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                          child: ListTile(
                            leading: Icon(
                              Icons.directions_bus_sharp,
                              color: Colors.black87,
                            ),
                            title: Text(
                              'Bus Color',
                              style: TextStyle(fontSize: 17.0,
                                  fontFamily: 'Neucha',
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text('${document.data()['Color']}',
                              style: TextStyle(
                                fontSize: 17,
                                //fontWeight: FontWeight.bold,
                                //fontFamily: 'SourceSansPro',
                                color: Colors.black87,
                                //letterSpacing: 2.5,
                              ),

                            ),

                          ),
                        ),

                    ),

                    Expanded(
                      flex: 1,
                        child: Card(
                          color: Colors.white60,
                          margin:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                          child: ListTile(
                            leading: Icon(
                              Icons.credit_card_rounded,
                              color: Colors.black87,
                            ),
                            title: Text(
                              'License Number',
                              style: TextStyle(fontSize: 17.0,
                                  fontFamily: 'Neucha',
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text('${document.data()['License Number']}',
                              style: TextStyle(
                                fontSize: 17,
                                //fontWeight: FontWeight.bold,
                                //fontFamily: 'SourceSansPro',
                                color: Colors.black87,
                                //letterSpacing: 2.5,
                              ),

                            ),

                          ),
                        ),
                    ),

                    Expanded(
                      flex: 1,
                      child: Card(
                        color: Colors.white60,
                        margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                        child: ListTile(
                          leading: Icon(
                            Icons.adjust_rounded,
                            color: Colors.black87,
                          ),
                          title: Text(
                            'Luxury Level',
                            style: TextStyle(fontSize: 17.0,
                                fontFamily: 'Neucha',
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text('${document.data()['Luxury Level']}',
                            style: TextStyle(
                              fontSize: 17,
                              //fontWeight: FontWeight.bold,
                              //fontFamily: 'SourceSansPro',
                              color: Colors.black87,
                              //letterSpacing: 2.5,
                            ),

                          ),

                        ),
                      ),
                    ),

                    Expanded(
                      flex: 1,
                      child: Card(
                        color: Colors.white60,
                        margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                        child: ListTile(
                          leading: Icon(
                            Icons.directions_bus_outlined,
                            color: Colors.black87,
                          ),
                          title: Text(
                            'Bus Type',
                            style: TextStyle(fontSize: 17.0,
                                fontFamily: 'Neucha',
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text('${document.data()['Public or Private']}',
                            style: TextStyle(
                              fontSize: 17,
                              //fontWeight: FontWeight.bold,
                              //fontFamily: 'SourceSansPro',
                              color: Colors.black87,
                              //letterSpacing: 2.5,
                            ),

                          ),

                        ),
                      ),
                    ),



                    ButtonTheme(
                      minWidth: 100.0,
                      height: 40.0,
                      child: RaisedButton(color:Colors.black87,

                        onPressed: () {
                          logout();
                        },
                        child: Text('Log Out',
                          style: TextStyle(fontSize:15,fontWeight: FontWeight.bold,color:Colors.white,
                          ),
                        ),
                      ),

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
  void logout() async{
    await FirebaseAuth.instance.signOut();
    streamController.add(2);
  }
}