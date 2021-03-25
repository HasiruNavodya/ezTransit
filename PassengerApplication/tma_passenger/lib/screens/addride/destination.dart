import 'package:flutter/material.dart';
import 'package:tma_passenger/screens/addride/pickup.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';




class SelectDestination extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Select Destination',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final geo = Geoflutterfire();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  TextEditingController textEditingController = TextEditingController();
  String searchString;
  String destiLocation;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Destination"),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),

      body: Column(
      children: <Widget>[
        Expanded(
    child:Column(
    children: <Widget>[
      Padding(
          padding: const EdgeInsets.all(15.0) ,
      child: Container(
        child: TextField(
          onChanged: (val){
            setState(() {
              searchString = val.toLowerCase();
            });
          },
            controller: textEditingController,
            decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),


                ),
                hintText:'Search Your Destination',
                hintStyle: TextStyle(
                    fontFamily: 'Antra',color: Colors.blueGrey)),
      ),
       ),
      ),
      Expanded(
        child: StreamBuilder<QuerySnapshot>(



          stream:
              FirebaseFirestore.instance.collection("cities").where('searchIndex', arrayContains: searchString).snapshots(),
          builder: (context,snapshot){
            if(snapshot.data == null) return CircularProgressIndicator();
            if(snapshot.hasError){
              return Text("Error ${snapshot.error}");
            }
            switch(snapshot.connectionState) {
              case ConnectionState.none:
                return Text("Not date Present");

              case ConnectionState.done:
                return Text("Done!");

              default :
                 final List<DocumentSnapshot> documents = snapshot.data.docs;
                return new ListView(
                    children: documents
                        .map((doc) => Card(
                      child: ListTile(
                        title: Text(doc['location']),
                          subtitle: Text(doc['name']),

                         onTap: () {
                          Navigator.push(
                              context,
                           MaterialPageRoute(builder: (context) => SelectPickup((doc['location'])), //need to pass parameters here (doc['location'])
                           ),
                        );
                       }

                      ),
                    ))
                        .toList());


            }
          },
        ),
      ),


    ],

    ),
    ),
    ],
    ),
    );
  }

}


