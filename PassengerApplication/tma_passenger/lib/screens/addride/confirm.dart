import 'package:flutter/material.dart';
import 'package:tma_passenger/screens/addride/buy.dart';

class ConfirmTicket extends StatelessWidget {
  String destinationloc;
  String pickuploc;
  ConfirmTicket(dloc,ploc)
  {
    this.destinationloc=dloc;
    this.pickuploc=ploc;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Confirm Your Ticket"),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      //backgroundColor: Colors.red,
      body: Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Text(
                "Destination: $destinationloc",
                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
              ),
              Text(""),

              Text(
                "Pickup Location: $pickuploc",
                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
              ),
              Text(""),


              Text(
                "Bus:",
                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
              ),
              Text(""),

              Text(
                "Pick Up At:",
                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
              ),
              Text(""),

              Text(
                "Dropping At:",
                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
              ),
              Text(""),

              Text(
                "Ticket Price:",
                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
              ),
            ],
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
    );
  }
}