import 'package:flutter/material.dart';
import 'package:tma_passenger/screens/addride/confirm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';

String pnoSet = 'no';
String partNameGlobal;
String pno;
String numPlate;
String luxaryLevel;
String privatePub;
String noplate;
int seatcount;
int ticketcount;
int newseatcount;
int standingcount;
String ticketprice;

class SelectBus extends StatefulWidget {
  String pickuLocation;
  String destinationLocation;
  SelectBus(pickuploc,destinationloc)
  {
    this.pickuLocation=pickuploc;
    this.destinationLocation=destinationloc;
  }
  @override
  _SelectBusState createState() => _SelectBusState(pickuLocation,destinationLocation); //need to pass parameters here pickuLocation,destinationLocation
}


class _SelectBusState extends State<SelectBus> {
  String pickuLocation;
  String pno;
  String destinationLocation;
  String partName;

  _SelectBusState(pickuLocation, destinationLocation) {
    this.pickuLocation = pickuLocation;
    this.destinationLocation = destinationLocation;
    partName = '$destinationLocation' + '-' + '$pickuLocation';
    partNameGlobal = partName;
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(partName);

    if(pnoSet == 'no'){
      getpno();
    }
  }

  void getpno(){
    FirebaseFirestore.instance.collection('partialroutes').doc('$partNameGlobal').get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print(documentSnapshot.data()['partNo']);
        pno = documentSnapshot.data()['partNo'];
        ticketprice = documentSnapshot.data()['fare'];
        print(ticketprice);
        print(pno);
        setState(() {
          pnoSet = 'yes';
        });
      }
    });
  }



  final spinkit = SpinKitFadingCircle(
    itemBuilder: (BuildContext context, int index) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: index.isEven ? Colors.red : Colors.green,
        ),
      );
    },
  );

  @override
  Widget build(BuildContext context) {

    //Query buses = FirebaseFirestore.instance.collection('trips').where('parts', arrayContainsAny: [pno]);

    if(pnoSet == 'yes'){
      return Scaffold(
        appBar: AppBar(
          title: Text("Select Bus"),
          backgroundColor: Colors.black,
          centerTitle: true,
        ),

        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  GoogleMap(
                    //onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(6.844688, 80.015283), zoom: 15.0,),
                    myLocationEnabled: true,
                    // Add little blue dot for device location, requires permission from user
                    mapType: MapType.normal,
                    compassEnabled: true,
                    //onCameraMove: _onCameraMove,
                    //markers: _markers,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: StreamBuilder<QuerySnapshot>(

                stream:FirebaseFirestore.instance.collection('trips').where('parts', arrayContains: pno).snapshots(),
                builder: (context,snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading");
                  }

                  return new ListView(
                    children: snapshot.data.docs.map((DocumentSnapshot document) {

                      CollectionReference users = FirebaseFirestore.instance.collection('NewBus');

                      return FutureBuilder<DocumentSnapshot>(
                        future: users.doc(document.data()['bus']).get(),
                        builder:
                            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

                          if (snapshot.hasError) {
                            return Text("Something went wrong");
                          }

                          if (snapshot.connectionState == ConnectionState.done) {
                            Map<String, dynamic> data = snapshot.data.data();
                            ticketcount=document.data()['ticket count'];
                            seatcount=data['Seat Count'];
                            print('$seatcount'+'-'+'$ticketcount');
                            newseatcount=seatcount-ticketcount;
                            print(newseatcount);
                            if (ticketcount>=seatcount)
                              {
                                newseatcount=0;

                              }

                            if (ticketcount>seatcount)
                            {
                              standingcount=ticketcount-seatcount;
                              print(standingcount);
                            }
                            else{
                              standingcount=0;
                            }


                            return Container(

                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Card(
                                  color: Colors.white38,
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        Expanded(
                                          flex: 3,
                                          child:Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [

                                            Text('Pickup At: '+document.data()['startTime'],
                                                style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.bold)),
                                            Text(''),


                                            Text(document.data()['name'],
                                                style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.bold
                                                )),
                                            Text(''),


                                            Text(document.data()['startTime']+' - '+document.data()['endTime'],
                                                style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.bold
                                                )),
                                            Text(''),


                                            Text('Km'+'          Min ',
                                                style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.bold
                                                )),
                                            Text(''),



                                            ButtonTheme(child:
                                            FlatButton(color:Colors.black87, onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) => ConfirmTicket(destinationLocation,pickuLocation,document.data()['bus'],ticketprice)),
                                              );
                                            }, child: Text("Select Bus",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            ),

                                            ),



                                          ],


                                        ),
                                        ),




                                        Column(
                                          children: [
                                            Text('Free Seats:'+newseatcount.toString(),
                                                style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.bold)),
                                            Text(''),


                                            Text( 'Standing:'+standingcount.toString(),
                                                style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.bold
                                                )),
                                            Text(''),


                                            Text(data['Luxury Level'],
                                                style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.bold
                                                )),
                                            Text(''),


                                            Text(data['Public or Private'],
                                                style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.bold
                                                )),
                                            Text(''),


                                            ButtonTheme(child:
                                            RaisedButton(color:Colors.black87, onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(),
                                              );
                                            }, child: Text("Locate Bus",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            ),
                                            ),


                                          ],

                                        ),

                                      ],


                                    ),
                                  ),

                                ),
                              ),
                            );
                          }

                          return Text("loading");
                        },
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ],
        ),
    // floatingActionButton: FloatingActionButton(
    // onPressed: () {
    //   Navigator.push(
    //       context,
    //       MaterialPageRoute(builder: (context) => ConfirmTicket(destinationLocation,pickuLocation)),
    //   );
    //
    // },
    // child: Icon(Icons.arrow_forward_ios),
    // backgroundColor: Colors.black87,
    // ),
    );

    }


    else{
      return Scaffold(
        appBar: AppBar(
          title: Text("Loading"),
          backgroundColor: Colors.black,
          centerTitle: true,
        ),

        body: spinkit,
      );

    }

  }

  // String getLux(){
  //   FirebaseFirestore.instance.collection('NewBus').doc('$numPlate').get().then((DocumentSnapshot documentSnapshot) {
  //     // print('gg '+numPlate);
  //     if (documentSnapshot.exists) {
  //       // print(documentSnapshot.data()['Luxury Level']);
  //       luxaryLevel = documentSnapshot.data()['Luxury Level'];
  //       // print('sfdf'+luxaryLevel);
  //       return luxaryLevel;
  //
  //
  //
  //     }
  //   });
  // }
}

// String gg()
// {
//   String dfs='rakshi';
//   return dfs;
// }

// void noPlate()
// {
//   FirebaseFirestore.instance.collection('NewBus').doc('$partNameGlobal').get().then((DocumentSnapshot documentSnapshot) {
//     if (documentSnapshot.exists) {
//       print(documentSnapshot.data()['partNo']);
//       pno = documentSnapshot.data()['partNo'];
//       print(pno);
//     }

