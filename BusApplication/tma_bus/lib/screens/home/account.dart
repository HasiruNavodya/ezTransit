import 'package:cloud_firestore/cloud_firestore.dart';
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
      backgroundColor: Colors.white70,
      body:StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("NewBus")
            .where('Plate Number', isEqualTo: 'EG-2234').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return Padding(
            padding: const EdgeInsets.all(0.0),
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
                          subtitle: Text('${document.data()['Driver Name']}',
                            style: TextStyle(
                              fontSize: 14,
                              //fontWeight: FontWeight.bold,
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
                         color: Colors.white,
                         margin:
                         EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                         child: ListTile(
                           leading: Icon(
                             Icons.email,
                             color: Colors.teal[900],
                           ),
                           title: Text(
                             'Bus Number Plate',
                             style: TextStyle(fontSize: 15.0,
                                 fontFamily: 'Neucha',
                                 fontWeight: FontWeight.bold),
                           ),
                           subtitle: Text('${document.data()['Plate Number']}',
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

                   ),


                    Expanded(
                      flex: 1,
                        child:Card(
                          color: Colors.white,
                          margin:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                          child: ListTile(
                            leading: Icon(
                              Icons.perm_identity,
                              color: Colors.teal[900],
                            ),
                            title: Text(
                              'Bus Color',
                              style: TextStyle(fontSize: 15.0,
                                  fontFamily: 'Neucha',
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text('${document.data()['Color']}',
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

                    ),

                    Expanded(
                      flex: 1,
                        child: Card(
                          color: Colors.white,
                          margin:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                          child: ListTile(
                            leading: Icon(
                              Icons.perm_identity,
                              color: Colors.teal[900],
                            ),
                            title: Text(
                              'License Number',
                              style: TextStyle(fontSize: 15.0,
                                  fontFamily: 'Neucha',
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text('${document.data()['License Number']}',
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
                    ),

                    Expanded(
                      flex: 1,
                      child: Card(
                        color: Colors.white,
                        margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                        child: ListTile(
                          leading: Icon(
                            Icons.perm_identity,
                            color: Colors.teal[900],
                          ),
                          title: Text(
                            'Luxury Level',
                            style: TextStyle(fontSize: 15.0,
                                fontFamily: 'Neucha',
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text('${document.data()['Luxury Level']}',
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
                    ),

                    Expanded(
                      flex: 1,
                      child: Card(
                        color: Colors.white,
                        margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                        child: ListTile(
                          leading: Icon(
                            Icons.perm_identity,
                            color: Colors.teal[900],
                          ),
                          title: Text(
                            'Bus Type',
                            style: TextStyle(fontSize: 15.0,
                                fontFamily: 'Neucha',
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text('${document.data()['Public or Private']}',
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
                    ),




                    ElevatedButton(

                      onPressed: () {
                        // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                        //     LoginPage()), (Route<dynamic> route) => false);
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