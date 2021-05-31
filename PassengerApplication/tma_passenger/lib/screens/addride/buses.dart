import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
String tripid;
String startcity;
String endcity;
String ptime;
String dtime;

class SelectBus extends StatefulWidget {
  SelectBus(this.pickuLocation, this.destinationLocation);
  final String pickuLocation;
  final String destinationLocation;

  @override
  _SelectBusState createState() =>
      _SelectBusState(); //need to pass parameters here pickuLocation,destinationLocation
}

class _SelectBusState extends State<SelectBus> {
  TextEditingController infoC = new TextEditingController();

  BitmapDescriptor busicon;

  @override
  void initState() {
    super.initState();
    setMapMarker();

    if (pnoSet == 'no') {
      getpno();
    }

    //print(widget.partName);
  }

  GoogleMapController mapController;
  static const _initialPosition = LatLng(7.2906, 80.6337);
  LatLng _lastPostion = _initialPosition;
  final Set<Marker> _markers = {};

  void getpno() {
    partNameGlobal =
        '${widget.destinationLocation}' + '-' + '${widget.pickuLocation}';

    FirebaseFirestore.instance
        .collection('partialroutes')
        .doc('$partNameGlobal')
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print(documentSnapshot.data()['partNo']);
        pno = documentSnapshot.data()['partNo'];
        startcity = documentSnapshot.data()['startin'];
        endcity = documentSnapshot.data()['endin'];
        ticketprice = documentSnapshot.data()['fare'];
        print(ticketprice);
        print('mmmmmm $startcity');
        print('lllllll $endcity');
        print("QPQPQPQPQPQPQQPQQ" + '$pno');
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

    if (pnoSet == 'yes') {
      return Scaffold(
        appBar: AppBar(
          title: Text("SELECT BUS"),
          backgroundColor: Colors.black,
          centerTitle: true,
        ),

        body: Container(
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    GoogleMap(
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(6.844688, 80.015283),
                        zoom: 15.0,
                      ),
                      myLocationEnabled: true,
                      mapType: MapType.normal,
                      compassEnabled: true,
                      markers: _markers,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  color: Colors.grey.shade200,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('trips').where('parts', arrayContains: pno).snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Something went wrong');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return SpinKitDualRing(color: Colors.black87);
                      }

                      return new ListView(
                        children: snapshot.data.docs.map((DocumentSnapshot document) {

                          FirebaseFirestore.instance.collection("trips").doc(document.data()['tripID'].toString()).collection("stops").doc(widget.pickuLocation).get().then((documentSnapshot) {
                            if (documentSnapshot.exists) {
                              ptime = documentSnapshot.data()['time'].toString();
                              print(ptime);
                            } else {
                              ptime = '';
                            }
                          });

                          FirebaseFirestore.instance.collection("trips").doc(document.data()['tripID'].toString()).collection("stops").doc(widget.destinationLocation).get().then((documentSnapshot) {
                            if (documentSnapshot.exists) {
                              dtime = documentSnapshot.data()['time'].toString();
                              print(dtime);
                            } else {
                              dtime = '';
                            }
                          });

                          CollectionReference users = FirebaseFirestore.instance.collection('buses');

                          return FutureBuilder<DocumentSnapshot>(

                            future: users.doc(document.data()['bus']).get(),
                            builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

                              if (snapshot.hasError) {
                                return Text("Something went wrong");
                              }

                              if (snapshot.connectionState == ConnectionState.done) {Map<String, dynamic> data = snapshot.data.data();

                                tripid = document.data()['tripID'];
                                print(tripid);
                                ticketcount = document.data()['ticketCount'];
                                seatcount = data['Seat Count'];
                                print('$seatcount' + '-' + '$ticketcount');
                                newseatcount = seatcount - ticketcount;
                                print(newseatcount);
                                if (ticketcount >= seatcount) {
                                  newseatcount = 0;
                                }

                                if (ticketcount > seatcount) {
                                  standingcount = ticketcount - seatcount;
                                  print(standingcount);
                                } else {
                                  standingcount = 0;
                                }

                                return Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Card(
                                      color: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Column(
                                          children: [
                                            Container(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text(
                                                        document.data()['name'],
                                                        style: TextStyle(
                                                          fontSize: 15.0,
                                                          //fontWeight: FontWeight.bold
                                                        ),
                                                      ),
                                                      //Text(''),
                                                      Text(
                                                        document.data()['startTime'] + ' - ' + document.data()['endTime'],
                                                        style: TextStyle(
                                                          fontSize: 15.0,
                                                          //fontWeight: FontWeight.bold
                                                        ),
                                                      ),
                                                      Text(''),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  flex: 3,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                          'Pickup At: ' + ptime.toString(),
                                                          style: TextStyle(
                                                            fontSize: 16.0,
                                                            //fontWeight: FontWeight.bold
                                                          )),
                                                      Text(
                                                          'Dropping At: ' + dtime.toString(),
                                                          style: TextStyle(
                                                            fontSize: 16.0,
                                                            //fontWeight: FontWeight.bold
                                                          )),
                                                      Text(''),
                                                      Text(
                                                          'Comfort Level: ' +
                                                              data[
                                                                  'Luxury Level'],
                                                          style: TextStyle(
                                                            fontSize: 15.0,
                                                            //fontWeight: FontWeight.bold
                                                          )),
                                                      //Text(''),
                                                      Text(
                                                          data['Public or Private'] +
                                                              ' Bus',
                                                          style: TextStyle(
                                                            fontSize: 15.0,
                                                            //fontWeight: FontWeight.bold
                                                          )),
                                                      Text(''),
                                                    ],
                                                  ),
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                        'Free Seats: ' +
                                                            newseatcount
                                                                .toString(),
                                                        style: TextStyle(
                                                          fontSize: 15.0,
                                                          //fontWeight: FontWeight.bold
                                                        )),
                                                    //Text(''),
                                                    Text(
                                                      'Standing: ' +
                                                          standingcount
                                                              .toString(),
                                                      style: TextStyle(
                                                        fontSize: 15.0,
                                                        //fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text(''),
                                                    ButtonTheme(
                                                      child: OutlinedButton(
                                                        //color: Colors.black87,
                                                        onPressed: () {
                                                          showBusLocation(
                                                              document.data()[
                                                                  'bus']);
                                                          //Navigator.push(context, MaterialPageRoute(),);
                                                          /*_markers.add(
                                                          Marker(
                                                            markerId: MarkerId('bus'),
                                                            position: LatLng(6.823821869777691, 80.03039345308913),
                                                            icon: BitmapDescriptor.defaultMarker,
                                                          ));*/
                                                        },
                                                        child: Text(
                                                          "Show Location",
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    OutlinedButton(
                                                      style: ButtonStyle(
                                                        foregroundColor:
                                                            MaterialStateProperty
                                                                .all<Color>(Colors
                                                                    .black54),
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all<Color>(Colors
                                                                    .black87),
                                                      ),
                                                      //color: Colors.black87,
                                                      onPressed: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) => ConfirmTicket(
                                                                  widget
                                                                      .destinationLocation,
                                                                  widget
                                                                      .pickuLocation,
                                                                  document.data()[
                                                                      'bus'],
                                                                  ticketprice,
                                                                  tripid,
                                                                  startcity,
                                                                  endcity)),
                                                        );
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            "Select This Bus ",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                          Icon(
                                                            Icons.done,
                                                            color:
                                                                Colors.white60,
                                                            size: 18,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }
                              return Text("");
                            },
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
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
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text("SELECT BUS"),
          backgroundColor: Colors.black,
          centerTitle: true,
        ),
        body: SpinKitDualRing(color: Colors.black87),
      );
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    //showBusLocation();
    setState(() {
      mapController = controller;
    });
  }

  void _onCameraMove(CameraPosition position) {
    setState(() {
      _lastPostion = position.target;
    });
  }

  void showBusLocation(String busPN) async {

setState(() {
  FirebaseFirestore.instance
      .collection('buses')
      .doc(busPN)
      .snapshots()
      .listen((DocumentSnapshot busLocation) {
    print("location updated");

    _markers.add(Marker(
        markerId: MarkerId(busPN),
        position: LatLng(busLocation.data()['location'].latitude,
            busLocation.data()['location'].longitude),
        icon: busicon));

    mapController?.animateCamera(CameraUpdate.newLatLng(LatLng(
        busLocation.data()['location'].latitude,
        busLocation.data()['location'].longitude)));
  });
    });
  }

  void setMapMarker() async {
    busicon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(60, 60)), 'assets/bus.png');
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
