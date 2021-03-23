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


            children: <Widget>[
            Expanded(
                flex: 1,
              child:Container(

               child: Text("Destination: $destinationloc"),

              // Text(""),
              //
              // Text(
              //   "Pickup Location: $pickuploc",
              //   style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
              // ),
              // Text(""),
              //
              //
              // Text(
              //   "Bus:",
              //   style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
              // ),
              // Text(""),
              //
              // Text(
              //   "Pick Up At:",
              //   style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
              // ),
              // Text(""),
              //
              // Text(
              //   "Dropping At:",
              //   style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
              // ),
              // Text(""),
              //
              // Text(
              //   "Ticket Price:",
              //   style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
              // ),
              // FlatButton(color:Colors.green, onPressed: () {}, child: Text("Yes")
              // ),
              // RaisedButton(color:Colors.red, onPressed: () {}, child: Text("No")
              // ),


            ),
        ),

              Expanded(
               flex: 1,
               child:Container(

                  child: Text("Pickup Location: $pickuploc"),

          ),
              ),

      Expanded(
        flex: 1,
        child:Container(

          child: Text("Bus:"),

        ),
      ),

      Expanded(
        flex: 1,
        child:Container(

          child: Text("Pick Up At:"),

        ),
      ),

      Expanded(
        flex: 1,
        child:Container(

          child: Text("Dropping At:"),

        ),
      ),

      Expanded(
        flex: 1,
        child:Container(

          child: Text("Ticket Price:"),

        ),
      ),

              Expanded(
                flex: 1,
                child:Row(
                  children: <Widget> [

                             FlatButton(color:Colors.green, onPressed: () {}, child: Text("Yes"),
                          ),
                           RaisedButton(color:Colors.red, onPressed: () {}, child: Text("No")
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
    );
  }
}