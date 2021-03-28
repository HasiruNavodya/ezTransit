import 'package:flutter/material.dart';
import 'package:tma_passenger/screens/addride/buy.dart';

import 'destination.dart';

class ConfirmTicket extends StatelessWidget {
  String destinationloc;
  String pickuploc;
  String bus;
  String ticketprice;
  ConfirmTicket(dloc,ploc,bs,ticketprice)
  {
    this.destinationloc=dloc;
    this.pickuploc=ploc;
    this.bus=bs;
    this.ticketprice=ticketprice;
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
      body: Container(
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,


              children: <Widget>[

              Expanded(
                flex:1,
                child:Card(
                  color: Colors.white,
                  margin:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.account_box,
                      color: Colors.teal[900],
                    ),
                  title: Text("Destination: $destinationloc",
                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),

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
                          Icons.account_box,
                          color: Colors.teal[900],
                        ),
                      title: Text("Pickup Location: $pickuploc",
                        style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
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
                  Icons.account_box,
                  color: Colors.teal[900],
                ),
              title: Text("Bus: $bus ",
                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
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
                  Icons.account_box,
                  color: Colors.teal[900],
                ),
              title: Text("Pick Up At:",
                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
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
                  Icons.account_box,
                  color: Colors.teal[900],
                ),
              title: Text("Dropping At:",
                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
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
                  Icons.account_box,
                  color: Colors.teal[900],
                ),
              title: Text("Ticket Price: $ticketprice",
                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
              ),
            ),
        ),
        ),

                Expanded(
                  flex: 1,
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget> [

                               FlatButton(color:Colors.green, onPressed: () {
                                 Navigator.push(
                                     context,
                                     MaterialPageRoute(builder: (context) => BuyTicket()),
                                 );
                               }, child: Text("Yes"),
                            ),
                             RaisedButton(color:Colors.red, onPressed: () {
                               Navigator.push(
                                 context,
                                 MaterialPageRoute(builder: (context) => SelectDestination()),
                               );
                             }, child: Text("No")
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
    ),
      ),
    );
  }
}