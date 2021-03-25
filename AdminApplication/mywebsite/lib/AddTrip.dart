import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:draggable_scrollbar/draggable_scrollbar.dart';

class AddTrip extends StatefulWidget {

  @override
  _AddTripState createState() => _AddTripState();
}

class _AddTripState extends State<AddTrip> {
  ScrollController _controller = ScrollController();

// reference for the form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _stopName ;
  String _arrivingTime ;  
  String _timeDu ; 
  String _latitude ; 
  String _longitude ; 


//get data from textformfield
  TextEditingController stopName = new TextEditingController();
   TextEditingController arrivingTime = new TextEditingController();
    TextEditingController timeDu = new TextEditingController();
     TextEditingController latitude = new TextEditingController();
      TextEditingController longitude = new TextEditingController();
       

Widget _buildstopName(){
  return TextFormField(
               controller: stopName,
               decoration: InputDecoration(
               labelText: 'Stop Name',
               border: OutlineInputBorder()),

                 validator:(String value) {
                 if(value.isEmpty){
                    return 'Stop Name is required';
                 }
               },
               onSaved: (String value){
                 _stopName = value;
               },
               
   );
}

  
Widget _buildarrivingTime(){
  return TextFormField(
                controller: arrivingTime,
               // maxLength: 30,
               decoration: InputDecoration(
               labelText: 'Arriving Time',
               border: OutlineInputBorder()),

                 validator:(String value) {
                 if(value.isEmpty){
                    return 'Arriving Time is required';
                 }
               },
               onSaved: (String value){
                 _arrivingTime = value;
               },
               
   );
}


Widget _buildtimeDu(){
  return TextFormField(
               controller: timeDu,
               decoration: InputDecoration(
               labelText: 'Time Duration From Last Stop',
               border: OutlineInputBorder()),

                 validator:(String value) {
                 if(value.isEmpty){
                    return 'Time Duration From Last Stop is required';
                 }
               },
               onSaved: (String value){
                 _timeDu = value;
               },
               
   );
}

Widget _buildlatitude(){
  return TextFormField(
               controller: latitude,
               decoration: InputDecoration(
               labelText: 'latitude',
               border: OutlineInputBorder()),

                 validator:(String value) {
                 if(value.isEmpty){
                    return ('latitude is required');
                 }
               },
               onSaved: (String value){
                 _latitude = value;
               },
               
   );
}

Widget _buildlongitude(){
  return TextFormField(
                controller: longitude,
               decoration: InputDecoration(
               labelText: 'longitude',
               border: OutlineInputBorder()),
               // maxLength: 7,
                 validator:(String value) {
                 if(value.isEmpty){
                    return ('longitude is required');
                 }
               },
               onSaved: (String value){
                 _longitude = value;
               },
               
   );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text('Add Stops'),
        backgroundColor: Colors.pink[400],
        
        elevation:0.0,
      ),
      body:
        Container(
         
          
          decoration:BoxDecoration(
            
        gradient: LinearGradient(
          begin:Alignment.centerLeft,
          end: Alignment.centerRight,
          colors:[
            Colors.blue[400],
            Colors.blue[600],
            Colors.blue[900],
            Colors.indigo[900],
            Colors.deepPurple[900],
         
        ]),
        
      ),
          
     
        padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 400.0),
       
      
      
         child:Container(
            //: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
             constraints: BoxConstraints(maxHeight: 1500),
             decoration:BoxDecoration(
        gradient: LinearGradient(
          begin:Alignment.centerLeft,
          end: Alignment.centerRight,
          colors:[
            Colors.blue[400],
            
        Colors.blue[100],
            
            
        ]),
      ),
        child: Form(
           
         //because of this global key we can acess build in validations
          key: _formKey,
        
          child:Column(
         mainAxisAlignment:MainAxisAlignment.center,
       crossAxisAlignment: CrossAxisAlignment.center,
      
      
            
            children : <Widget>[
              
                _buildstopName(),
              SizedBox(height :10.0),
              _buildarrivingTime(),
              SizedBox(height :10.0),
              _buildtimeDu(),
              SizedBox(height :10.0),
              _buildlatitude(),
              SizedBox(height :10.0),
              _buildlongitude(),
              SizedBox(height :10.0),
             
              
SizedBox(height :5.0),
Row(
  mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.center,
  children:[
  
      ElevatedButton(
          child:Text(
          'Submit',style: TextStyle(fontSize: 20),),
  style: ElevatedButton.styleFrom(
    primary: Colors.pink[400], // background
    onPrimary: Colors.white, // foreground
    
  ),  

    onPressed :() async{
       
      // validate the form based on it's current state
if(_formKey.currentState.validate()) {
  Map <String, dynamic> data ={"Stop Name":stopName.text,"Ariving Time":
  arrivingTime.text,"Time Duration ":timeDu.text,"Latitude":latitude.text,
  "Longitude":longitude.text,};

  FirebaseFirestore.instance.collection('AddStops').add(data);

                     
                       showDialog(context: context, builder:(BuildContext context) {
                       return AlertBox('Successfully Inserted!');});
                     }
                   }

                 ),
SizedBox(width:50.0),
                ElevatedButton(
                     child:Text(
                        'Cancel',style: TextStyle(fontSize: 20),),
  style: ElevatedButton.styleFrom(
    primary: Colors.pink[400], // background
    onPrimary: Colors.white, // foreground
  ), 
                   onPressed :()async{
                    
                   }



                 ),],),],),),
                 
                 ),
                 
                 ), 
                 
              
          
      
        );
  }
}
 

 class AlertBox extends StatelessWidget {
   final title;
   AlertBox(this.title);

   @override
   Widget build(BuildContext context) {
     return AlertDialog(
       //Round rectangle border
       
       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      
       
      title: Text('Alert'),
       content: Text(title),
       actions:<Widget> [
         new TextButton(onPressed: (){Navigator.of(context).pop();}, child: Text('Okay'))
         
       ],
       
     );
   }
 }