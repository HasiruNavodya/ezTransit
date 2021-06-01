import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tma_passenger/main.dart';
import 'package:tma_passenger/screens/auth/login.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserDetails extends StatefulWidget {

  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {

  String userEmail;

  @override
  void initState() {
    super.initState();

    FirebaseAuth auth = FirebaseAuth.instance;

    if (auth.currentUser != null) {
      userEmail = auth.currentUser.email;
      print(auth.currentUser.email);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PROFILE"),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      //backgroundColor: Colors.red,
      backgroundColor: Colors.white70,
      body: Container(
        color: Colors.grey.shade200,
        child: ListView(
          //mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
/*            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.directions_bus,
                color: Colors.black87,
                size: 30,
              ),
            ),*/
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("passengers").where('Email', isEqualTo: userEmail).snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SpinKitDualRing(color: Colors.black87);
                }

                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Stack(
                    children: snapshot.data.docs.map((DocumentSnapshot document) {
                      return Column(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundImage: AssetImage('assets/profile.png'),

                            ),
                          ),
                          Text(
                            'Account Details',
                            style: TextStyle(
                              fontSize: 20,
                              //fontWeight: FontWeight.bold,
                              fontFamily: 'SourceSansPro',
                              color: Colors.black87,
                              //letterSpacing: 2.5,
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
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.account_box,
                                          color: Colors.black87,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Text('NAME',
                                            style:TextStyle(fontSize: 18.0, /*fontWeight: FontWeight.bold,*/),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Text('${document.data()['FullName']}',
                                            style: TextStyle(
                                              fontSize: 19,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.account_box,
                                          color: Colors.black87,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Text('EMAIL',
                                            style:TextStyle(fontSize: 18.0, /*fontWeight: FontWeight.bold,*/),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Text('${document.data()['Email']}',
                                            style: TextStyle(
                                              fontSize: 19,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.account_box,
                                          color: Colors.black87,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Text('NIC NUMBER',
                                            style:TextStyle(fontSize: 18.0, /*fontWeight: FontWeight.bold,*/),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Text('${document.data()['NIC']}',
                                            style: TextStyle(
                                              fontSize: 19,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.account_box,
                                          color: Colors.black87,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Text('PHONE NUMBER',
                                            style:TextStyle(fontSize: 18.0, /*fontWeight: FontWeight.bold,*/),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Text('${document.data()['PhoneNum']}',
                                            style: TextStyle(
                                              fontSize: 19,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
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
            Padding(
              padding: const EdgeInsets.only(left:150.0,right:150.0,top:15.0,bottom:15.0),
              child: ElevatedButton(
                onPressed: (){showAlertDialog(context);},
                child: Text("LOGOUT"),
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.black87)),
              ),
            )
          ],
        ),
      ),
    );
  }

  void logout() async{
    await FirebaseAuth.instance.signOut();
    streamController.add('2');
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(
        "YES",
        style: TextStyle(
            fontSize: 16.0,
            color: Colors.red,
        ),
      ),
      onPressed:  () {
        Navigator.pop(context);
        logout();
      },
    );
    Widget continueButton = TextButton(
      child: Text(
        "NO",
        style: TextStyle(
            fontSize: 16.0,
            color: Colors.black,
        ),
      ),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text("Log Out"),
      content: Text("Are you sure you want to log out?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}

