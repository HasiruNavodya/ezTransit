import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:payhere_mobilesdk_flutter/payhere_mobilesdk_flutter.dart';
import 'package:toast/toast.dart';
import 'package:twilio_flutter/twilio_flutter.dart';

import '../../main.dart';
import 'destination.dart';
import '../ride/ride.dart';

int ticketNum;
String userEmail;
String ticketID;
String phoneNo;

class ConfirmTicket extends StatefulWidget {
  String destinationloc;
  String pickuploc;
  String bus;
  String ticketprice;
  String tripid;
  String startcity;
  String endcity;

  ConfirmTicket(destinationloc, pickuploc, bus, ticketprice, tripid, startcity, endcity) {
    this.destinationloc = destinationloc;
    this.pickuploc = pickuploc;
    this.bus = bus;
    this.ticketprice = ticketprice;
    this.tripid = tripid;
    this.startcity = startcity;
    this.endcity = endcity;
  }

  @override
  _ConfirmTicketState createState() => _ConfirmTicketState(destinationloc, pickuploc, bus, ticketprice, tripid, startcity, endcity);
}

class _ConfirmTicketState extends State<ConfirmTicket> {

  String pickupat;
  String droppingat;
  String loading = 'yes';

  String destinationloc;
  String pickuploc;
  String bus;
  String ticketprice;
  String tripid;
  String startcity;
  String endcity;

  _ConfirmTicketState(String destinationloc, String pickuploc, String bus, String ticketprice, String tripid, String startcity, String endcity)
  {
    this.destinationloc = destinationloc;
    this.pickuploc = pickuploc;
    this.bus = bus;
    this.ticketprice = ticketprice;
    this.tripid = tripid;
    this.startcity = startcity;
    this.endcity = endcity;
  }

  @override
  void initState() {
    super.initState();

    getUserInfo();

  }

  void getUserInfo(){
    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      userEmail = auth.currentUser.email;
      print(auth.currentUser.email);
    }
  }

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

    if(loading == 'yes'){
      getPickupAt();
      return Scaffold(body: Center(child: SpinKitDualRing(color: Colors.black87),),);
    }
    else{
      return Scaffold(
        appBar: AppBar(
          title: Text("BOOK TICKET"),
          backgroundColor: Colors.black,
          centerTitle: true,
        ),
        //backgroundColor: Colors.red,
        backgroundColor: Colors.white,
        body: Container(
          color: Colors.white,
          child: StreamBuilder<QuerySnapshot>(
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
                return SpinKitDualRing(color: Colors.black87);
              }

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: snapshot.data.docs.map((DocumentSnapshot document) {
                    return Container(
                      child: Column(
                        children: [
                          Expanded(
                          flex: 6,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Container(
                                          child: Text(
                                            "Ticket Details",
                                            style: TextStyle(
                                              //fontSize: 19,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: ListTile(
                                        leading: Icon(
                                          Icons.add_road,
                                          color: Colors.black87,
                                        ),
                                        title: Text(
                                          "Destination: ${widget.destinationloc}",
                                          style: TextStyle(
                                              fontSize: 18,
                                              //fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),
                                    ),

                                    Expanded(
                                      flex: 1,
                                      child: ListTile(
                                        leading: Icon(
                                          Icons.edit_road_outlined,
                                          color: Colors.black87,
                                        ),
                                        title: Text(
                                          "Pickup Location: ${widget.pickuploc}",
                                          style: TextStyle(
                                              fontSize: 18,
                                              //fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),
                                    ),

                                    Expanded(
                                      flex: 1,
                                      child: ListTile(
                                        leading: Icon(
                                          Icons.directions_bus_outlined,
                                          color: Colors.black87,
                                        ),
                                        title: Text(
                                          "Bus: ${widget.bus} ",
                                          style: TextStyle(
                                              fontSize: 18,
                                              //fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),
                                    ),

                                    Expanded(
                                      flex: 1,
                                      child: ListTile(
                                        leading: Icon(
                                          Icons.timer_rounded,
                                          color: Colors.black87,
                                        ),
                                        title: Text(
                                          "Pick Up At: $pickupat",
                                          style: TextStyle(
                                              fontSize: 18,
                                              //fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),
                                    ),

                                    Expanded(
                                      flex: 1,
                                      child: ListTile(
                                        leading: Icon(
                                          Icons.access_time_outlined,
                                          color: Colors.black87,
                                        ),
                                        title: Text(
                                          "Dropping At: $droppingat",
                                          style: TextStyle(
                                              fontSize: 18,
                                              //fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),
                                    ),

                                    Expanded(
                                      flex: 1,
                                      child: ListTile(
                                        leading: Icon(
                                          Icons.credit_card_sharp,
                                          color: Colors.black87,
                                        ),
                                        title: Text(
                                          "Ticket Price: Rs.${widget.ticketprice}",
                                          style: TextStyle(
                                              fontSize: 18,
                                              //fontWeight: FontWeight.bold
                                          ),
                                        ),
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
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.black87,
                                  ),
                                  onPressed: () => {addTicketAndPay()},
                                  child: Text(
                                    "Pay Now",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.black87,
                                  ),
                                  onPressed: () {
                                    //RideView().setTID('tck1000');
                                    showAlertDialog(context);
                                  },
                                  child: Text(
                                    "Pay Cash",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.black38,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).popUntil((route) => route.isFirst);
                                  },
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ),

                        ],
                      ),
                    );

                    //Card(child: Text(document.data()['name']??'default'),);
                  }).toList(),
                ),
              );
            },
          ),
        ),
      );
    }


  }

  void addTicket(){

    FirebaseFirestore.instance.collection('tickets').doc('ticketNumbers').get().then((DocumentSnapshot ticketNo){
      if (ticketNo.exists) {
        ticketNum = ticketNo.data()['last'];
        ticketNum = ticketNum + 1;
        ticketID = 'TCK' + ticketNum.toString();
        print('ticket numberrrrrr' + ticketID);

        FirebaseFirestore.instance.collection("tickets").doc('ticketNumbers').update({"last": FieldValue.increment(1)})
            .then((value) => print("Records Added Successfully!"))
            .catchError((error) => print("Failed: $error"));

        FirebaseFirestore.instance.collection("tickets").doc(ticketID).set({
          "bus": bus,
          "drop":endcity,
          "dropTime":droppingat,
          "fare":ticketprice,
          "passenger":userEmail,
          "pickup":startcity,
          "pickupTime":pickupat,
          "ticketID":ticketID,
          "tripID":tripid,
          "payment": "Cash"
        }).then((value) {
          print("Records Added Successfully!");
          FirebaseFirestore.instance.collection("trips").doc(tripid).update({"ticketCount": FieldValue.increment(1)})
              .then((value) => print("Records Added Successfully!"))
              .catchError((error) => print("Failed: $error"));

          FirebaseFirestore.instance.collection("passengers").doc(userEmail).update({
            "currentTicketNo": ticketID,
            "onRide": "True"
          })
              .then((value) => print("Records Added Successfully!"))
              .catchError((error) => print("Failed: $error"));

          streamController.add(ticketID);
          Navigator.of(context).popUntil((route) => route.isFirst);
        })
            .catchError((error) => print("Failed: $error"));

        FirebaseFirestore.instance.collection("trips").doc(tripid).collection('stops').doc(startcity).update({"pickupCount": FieldValue.increment(1)})
            .then((value) => print("Records Added Successfully!"))
            .catchError((error) => print("Failed: $error"));
        FirebaseFirestore.instance.collection("trips").doc(tripid).collection('stops').doc(endcity).update({"dropCount": FieldValue.increment(1)})
            .then((value) => print("Records Added Successfully!"))
            .catchError((error) => print("Failed: $error"));
        sendSMS();
      }
    });
  }

  void addTicketAndPay(){

    FirebaseFirestore.instance.collection('tickets').doc('ticketNumbers').get().then((DocumentSnapshot ticketNo){
      if (ticketNo.exists) {
        ticketNum = ticketNo.data()['last'];
        ticketNum = ticketNum + 1;
        ticketID = 'TCK' + ticketNum.toString();
        print('ticket numberrrrrr' + ticketID);

        Map paymentObject = {
          "sandbox": true, // true if using Sandbox Merchant ID
          "merchant_id": "1216958", // Replace your Merchant ID
          "merchant_secret": "4q6h8wJ4gl74ZJ3DAH0GEm8m0UeEP0Hk14pCBjyrOCYg", // See step 4e
          "notify_url": "http://sample.com/notify",
          "order_id": ticketID,
          "items": "bus fare",
          "amount": widget.ticketprice,
          "currency": "LKR",
          "first_name": userEmail,
          "last_name": "",
          "email": userEmail,
          "phone": "",
          "address": "",
          "city": "",
          "country": "",
          "delivery_address": "",
          "delivery_city": "",
          "delivery_country": "",
          "custom_1": "",
          "custom_2": ""
        };

        PayHere.startPayment(paymentObject, (paymentId) {

          print("One Time Payment Success. Payment Id: $paymentId");

          FirebaseFirestore.instance.collection("tickets").doc('ticketNumbers').update({"last": FieldValue.increment(1)})
              .then((value) => print("Records Added Successfully!"))
              .catchError((error) => print("Failed: $error"));

          FirebaseFirestore.instance.collection("tickets").doc(ticketID).set({
            "bus": bus,
            "drop":endcity,
            "dropTime":droppingat,
            "fare":ticketprice,
            "passenger":userEmail,
            "pickup":startcity,
            "pickupTime":pickupat,
            "ticketID":ticketID,
            "tripID":tripid,
            "payment": 'Payed'
          }).then((value) {
            print("Records Added Successfully!");
            FirebaseFirestore.instance.collection("trips").doc(tripid).update({"ticketCount": FieldValue.increment(1)})
                .then((value) => print("Records Added Successfully!"))
                .catchError((error) => print("Failed: $error"));


            FirebaseFirestore.instance.collection("passengers").doc(userEmail).update({
              "currentTicketNo": ticketID,
              "onRide": "True"
            })
                .then((value) {
                  print("Records Added Successfully!");
                  streamController.add(ticketID);
                  Navigator.of(context).popUntil((route) => route.isFirst);
                })
                .catchError((error) => print("Failed: $error"));


          })
              .catchError((error) => print("Failed: $error"));

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
        FirebaseFirestore.instance.collection("trips").doc(tripid).collection('stops').doc(startcity).update({"pickupCount": FieldValue.increment(1)})
            .then((value) => print("Records Added Successfully!"))
            .catchError((error) => print("Failed: $error"));
        FirebaseFirestore.instance.collection("trips").doc(tripid).collection('stops').doc(endcity).update({"dropCount": FieldValue.increment(1)})
            .then((value) => print("Records Added Successfully!"))
            .catchError((error) => print("Failed: $error"));
        sendSMS();
      }
    });
  }

  void sendSMS(){
    FirebaseFirestore.instance.collection("passengers").doc(userEmail).get().then((DocumentSnapshot userDoc) {
      if (userDoc.exists) {

        phoneNo = userDoc.data()['PhoneNum'];
        print('ALALALALALALALAL'+phoneNo.toString());

        TwilioFlutter twilioFlutter;
        twilioFlutter = TwilioFlutter(
            accountSid : 'AC30903a9112a151014af6052c82523ef5', // replace *** with Account SIDSKbae770986c6e1af0d3def33cda34b2b8
            authToken : '8f807406e0c0982b1398338cdb283728',  // replace xxx with Auth Token
            twilioNumber : '+14154187518'  // replace .... with Twilio Number
        );
        twilioFlutter.sendSMS(
            toNumber : phoneNo,
            messageBody : '\n\nTicket Info\n\nTicket ID: $ticketID\n$bus\nRs. $ticketprice\n$startcity ($pickupat)\n$endcity ($droppingat)\n\nThank you!\nezTransit'
        );

        print('\n\nTicket Info\nTicket ID: $ticketID\n$bus\nRs. $ticketprice\n$startcity ($pickupat)\n$endcity ($droppingat)');
      }
    });
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(
        "YES",
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.blue.shade900,
        ),
      ),
      onPressed:  () {
        Navigator.pop(context);
        addTicket();
      },
    );
    Widget continueButton = TextButton(
      child: Text(
        "CLOSE",
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
      title: Text("Confirm"),
      content: Text("Book this Ticket?"),
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
