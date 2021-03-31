import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:payhere_mobilesdk_flutter/payhere_mobilesdk_flutter.dart';
import 'package:toast/toast.dart';

import 'destination.dart';



class ConfirmTicket extends StatefulWidget {
  String destinationloc;
  String pickuploc;
  String bus;
  String ticketprice;
  String tripid;
  String startcity;
  String endcity;

  ConfirmTicket(dloc, ploc, bs, ticketprice, tripid, startcity, endcity) {
    this.destinationloc = dloc;
    this.pickuploc = ploc;
    this.bus = bs;
    this.ticketprice = ticketprice;
    this.tripid = tripid;
    this.startcity = startcity;
    this.endcity = endcity;
  }

  @override
  _ConfirmTicketState createState() => _ConfirmTicketState();
}

class _ConfirmTicketState extends State<ConfirmTicket> {

  String pickupat;
  String droppingat;
  String loading = 'yes';

  void getPickupAt() {
    FirebaseFirestore.instance
        .collection("trips")
        .doc('${widget.tripid}')
        .collection("stops")
        .doc('${widget.startcity}')
        .get()
        .then((documentSnapshot) {
      if (documentSnapshot.exists) {
        pickupat = documentSnapshot.data()['time'];
        getDroppingAt();
        print('fffff $pickupat');

        print('${widget.startcity}');
        print('${widget.endcity}');
      }
    });
  }

  void getDroppingAt() {
    FirebaseFirestore.instance
        .collection("trips")
        .doc('${widget.tripid}')
        .collection("stops")
        .doc('${widget.endcity}')
        .get()
        .then((documentSnapshot) {
      if (documentSnapshot.exists) {
        droppingat = documentSnapshot.data()['time'];
        setState(() {
          loading = 'no';
        });
        print('ggggg $droppingat');
        print('${widget.startcity}');
        print('${widget.endcity}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {


    PayHerePay() {
      Map paymentObject = {
        "sandbox": true, // true if using Sandbox Merchant ID
        "merchant_id": "1216958", // Replace your Merchant ID
        "merchant_secret":
            "4q6h8wJ4gl74ZJ3DAH0GEm8m0UeEP0Hk14pCBjyrOCYg", // See step 4e
        "notify_url": "http://sample.com/notify",
        "order_id": "ItemNo12345",
        "items": "bus fare",
        "amount": widget.ticketprice,
        "currency": "LKR",
        "first_name": "Saman",
        "last_name": "Perera",
        "email": "samanp@gmail.com",
        "phone": "0771234567",
        "address": "No.1, Galle Road",
        "city": "Colombo",
        "country": "Sri Lanka",
        "delivery_address": "No. 46, Galle road, Kalutara South",
        "delivery_city": "Kalutara",
        "delivery_country": "Sri Lanka",
        "custom_1": "",
        "custom_2": ""
      };

      PayHere.startPayment(paymentObject, (paymentId) {
        print("One Time Payment Success. Payment Id: $paymentId");
      }, (error) {
        print("One Time Payment Failed. Error: $error");
        Toast.show(
          "Payment Failed! Try Again.",
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.CENTER,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          border: Border.all(color: Colors.white),
        );
      }, () {
        print("One Time Payment Dismissed");
      });
    }

    if(loading == 'yes'){
      getPickupAt();
      return Scaffold(body: Center(child: Text('Loading...'),),);
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
        body: StreamBuilder<QuerySnapshot>(
          // stream:FirebaseFirestore.instance.collection('trips').where('parts', isEqualTo: ).snapshots(),
          stream: FirebaseFirestore.instance
              .collection('trips')
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
                          title: Text(
                            "Destination: ${widget.destinationloc}",
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
                          title: Text(
                            "Pickup Location: ${widget.pickuploc}",
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
                          title: Text(
                            "Bus: ${widget.bus} ",
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
                          title: Text(
                            "Pick Up At: $pickupat",
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
                          title: Text(
                            "Dropping At: $droppingat",
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
                          title: Text(
                            "Ticket Price: Rs.${widget.ticketprice}",
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
                                color: Colors.black,
                                onPressed: () => {PayHerePay()},
                                child: Text(
                                  "Pay",
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
                                color: Colors.black,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SelectDestination()),
                                  );
                                },
                                child: Text(
                                  "Back",
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
