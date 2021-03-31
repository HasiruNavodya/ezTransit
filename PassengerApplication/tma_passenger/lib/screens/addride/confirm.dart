import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tma_passenger/screens/addride/buy.dart';

import 'buses.dart';
import 'destination.dart';
String status='no';

class ConfirmTicket extends StatefulWidget {
  String destinationloc;
  String pickuploc;
  String bus;
  String ticketprice;
  String tripid;
  String startcity;
  String endcity;

  ConfirmTicket(dloc, ploc, bs, ticketprice,tripid,startcity,endcity) {
    this.destinationloc = dloc;
    this.pickuploc = ploc;
    this.bus = bs;
    this.ticketprice = ticketprice;
    this.tripid=tripid;
    this.startcity=startcity;
    this.endcity=endcity;
  }

  @override
  _ConfirmTicketState createState() => _ConfirmTicketState();
}

class _ConfirmTicketState extends State<ConfirmTicket> {
  String pickupat;

  String droppingat;

  @override
  void initState() {
    super.initState();
    print(tripid);
  }


  void getPickupAt(){
    FirebaseFirestore.instance
        .collection("trips")
        .doc('$tripid')
        .collection("stops").doc('$startcity')
        .get()
        .then((documentSnapshot)  {
      if (documentSnapshot.exists) {
        pickupat=documentSnapshot.data()['time'];
        print('fffff $pickupat');
        getDroppingAt();

        print('$startcity');
        print('$endcity');
      }
    });
  }

  void getDroppingAt(){
    FirebaseFirestore.instance
        .collection("trips")
        .doc('$tripid')
        .collection("stops").doc('$endcity')
        .get()
        .then((documentSnapshot)  {
      if (documentSnapshot.exists) {
        droppingat=documentSnapshot.data()['time'];
        print('ggggg $droppingat');
        print('$startcity');
        print('$endcity');
        setState(() {
          status = 'yes';
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    if(status == 'no'){
      getPickupAt();
      return Scaffold(body: Text('Loading'),);
    }
    else{
      return Scaffold(
        appBar: AppBar(
          title: Text("Confirm Your Ticket"),
          backgroundColor: Colors.black,
          centerTitle: true,
        ),
        //backgroundColor: Colors.red,
        backgroundColor: Colors.white,
        body: StreamBuilder<QuerySnapshot >(
          // stream:FirebaseFirestore.instance.collection('trips').where('parts', isEqualTo: ).snapshots(),
          stream: FirebaseFirestore.instance.collection('trips')
          // .doc('$tripid')
          // .collection('stops').doc('Kollupitiya').collection('gg')
              .snapshots(),
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
                    crossAxisAlignment: CrossAxisAlignment.center,


                    children: <Widget>[


                      Expanded(
                        flex: 1,
                        child: ListTile(
                          leading: Icon(
                            Icons.add_road,
                            color: Colors.teal[900],
                          ),
                          title: Text("Destination: ${widget.destinationloc}",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),

                          ),
                        ),


                      ),

                      Expanded(
                        flex: 1,
                        child: ListTile(
                          leading: Icon(
                            Icons.edit_road_outlined,
                            color: Colors.teal[900],
                          ),
                          title: Text("Pickup Location: ${widget.pickuploc}",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),

                        ),
                      ),

                      Expanded(
                        flex: 1,
                        child: ListTile(
                          leading: Icon(
                            Icons.directions_bus_outlined,
                            color: Colors.teal[900],
                          ),
                          title: Text("Bus: ${widget.bus} ",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),

                        ),

                      ),

                      Expanded(
                        flex: 1,
                        child: ListTile(
                          leading: Icon(
                            Icons.timer_rounded,
                            color: Colors.teal[900],
                          ),
                          title: Text('Pickup At: $pickupat',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),

                      Expanded(
                        flex: 1,
                        child: ListTile(
                          leading: Icon(
                            Icons.access_time_outlined,
                            color: Colors.teal[900],
                          ),
                          title: Text('Dropping At: $droppingat',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),

                        ),


                      ),

                      Expanded(
                        flex: 1,
                        child: ListTile(
                          leading: Icon(
                            Icons.credit_card_sharp,
                            color: Colors.teal[900],
                          ),
                          title: Text("Ticket Price: Rs.${widget.ticketprice}",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),


                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            ButtonTheme(
                              minWidth: 100.0,
                              height: 50.0,
                              child: RaisedButton(
                                color: Colors.black, onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BuyTicket()),
                                );
                              }, child: Text("Yes",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              ),
                            ),


                            ButtonTheme(
                              minWidth: 100.0,
                              height: 50.0,
                              child: RaisedButton(
                                color: Colors.black, onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SelectDestination()),
                                );
                              }, child: Text("No",
                                style: TextStyle(
                                  color: Colors.white,
                                ),

                              ),
                              ),
                            ),


                          ],


                        ),
                      ),


                      // floatingActionButton: FloatingActionButton(
                      //   onPressed: () {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(builder: (context) => BuyTicket()),
                      //     );
                      //   },
                      //   child: Icon(Icons.arrow_forward_ios),
                      //   backgroundColor: Colors.black87,
                      // ),
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
}
