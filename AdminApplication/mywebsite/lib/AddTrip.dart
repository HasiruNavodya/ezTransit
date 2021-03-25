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

  String _plateNumber ;
  String _driverName ;  
  String _licenseNumber ; 
  String _color ; 
  String _publicPrivate ; 
  String _luxeryLevel ; 
  String _seat ; 

//get data from textformfield
  TextEditingController plateNumber = new TextEditingController();
   TextEditingController driverName = new TextEditingController();
    TextEditingController licenseNumber = new TextEditingController();
     TextEditingController color = new TextEditingController();
      TextEditingController publicPrivate = new TextEditingController();
       TextEditingController luxeryLevel = new TextEditingController();
        TextEditingController seat = new TextEditingController();

Widget _buildPlateNumber(){
  return TextFormField(
               controller: plateNumber,
               decoration: InputDecoration(
               labelText: 'Plate Number',
               border: OutlineInputBorder()),

                 validator:(String value) {
                 if(value.isEmpty){
                    return 'Plate Number is required';
                 }
               },
               onSaved: (String value){
                 _plateNumber = value;
               },
               
   );
}

  
Widget _buildDriverName(){
  return TextFormField(
                controller: driverName,
               // maxLength: 30,
               decoration: InputDecoration(
               labelText: 'Driver Name',
               border: OutlineInputBorder()),

                 validator:(String value) {
                 if(value.isEmpty){
                    return 'Driver Name is required';
                 }
               },
               onSaved: (String value){
                 _driverName = value;
               },
               
   );
}


Widget _buildLicenseNumber(){
  return TextFormField(
               controller: licenseNumber,
               decoration: InputDecoration(
               labelText: 'Driver License Number',
               border: OutlineInputBorder()),

                 validator:(String value) {
                 if(value.isEmpty){
                    return 'Driver License Number is required';
                 }
               },
               onSaved: (String value){
                 _licenseNumber = value;
               },
               
   );
}

Widget _buildColor(){
  return TextFormField(
               controller: color,
               decoration: InputDecoration(
               labelText: 'Color',
               border: OutlineInputBorder()),

                 validator:(String value) {
                 if(value.isEmpty){
                    return ('Color is required');
                 }
               },
               onSaved: (String value){
                 _color = value;
               },
               
   );
}

Widget _buildPublicPrivate(){
  return TextFormField(
                controller: publicPrivate,
               decoration: InputDecoration(
               labelText: 'Public / Private',
               border: OutlineInputBorder()),
               // maxLength: 7,
                 validator:(String value) {
                 if(value.isEmpty){
                    return ('This field is required');
                 }
               },
               onSaved: (String value){
                 _publicPrivate = value;
               },
               
   );
}

Widget _buildLuxeryLevel(){
  return TextFormField(
               controller: luxeryLevel,
               decoration: InputDecoration(
               labelText: 'Luxery Level',
               border: OutlineInputBorder()),
               // maxLength: 15,
                 validator:(String value) {
                 if(value.isEmpty){
                    return ('This field is required');
                 }
               },
               onSaved: (String value){
                 _luxeryLevel = value;
               },
               
   );
}


Widget _buildSeat(){
  return TextFormField(
               controller:seat,
               
               decoration: InputDecoration(
               labelText: 'Seat Count',
               
               border: OutlineInputBorder()),
                keyboardType:TextInputType.number,
               // maxLength: 3,

                 validator:(String value) {
                 if(value.isEmpty){
                    return ('Seat count is required');
                 }
               },
               onSaved: (String value){
                 _seat = value;
               },
               
   );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text('Add New Bus'),
        backgroundColor: Colors.pink[400],
        
        elevation:0.0,
      ),
      body:// Column(
        
       // children:[
         /* child: DraggableScrollbar.semicircle(
           controller: _controller, 
           child: GridView.builder(
             controller: _controller,
             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
               crossAxisCount: 5,
               ),
               padding: EdgeInsets.zero,
               itemCount: 1000,
               itemBuilder:(context,index){
                 return Container(
                   alignment: Alignment.center,
                   margin:EdgeInsets.all(2.0),
                   color:Colors.grey[300],

                 );
               },
           ),
          ),*/
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
          
      // height: MediaQuery.of(context).size.height*6,
       //width:0.4 * MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 400.0),
       
      
       /* child:Card(
        
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
         // color: Colors.blue[400],
         
       elevation: 6.0,*/
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
            
            //Colors.indigo[900],
            //Colors.deepPurple[900],
         //  Color.fromRGBO(195,20,50,1.0),
       // Color.fromRGBO(36,11,54,1.0),
        ]),
      ),
        child: Form(
           
         //because of this global key we can acess build in validations
          key: _formKey,
        
          child:Column(
         mainAxisAlignment:MainAxisAlignment.center,
       crossAxisAlignment: CrossAxisAlignment.center,
      
      
            
            children : <Widget>[
              
                _buildPlateNumber(),
              SizedBox(height :10.0),
              _buildDriverName(),
              SizedBox(height :10.0),
              _buildLicenseNumber(),
              SizedBox(height :10.0),
              _buildColor(),
              SizedBox(height :10.0),
              _buildPublicPrivate(),
              SizedBox(height :10.0),
              _buildLuxeryLevel(),
              SizedBox(height :10.0),
              _buildSeat(),
            SizedBox(height :10.0),
              
              
              //SizedBox(height :10.0),
              /* TextFormField(
                controller: plateNumber,
               validator: (val) => val.isEmpty ?'Enter the plate number':null,   
               decoration: InputDecoration(
               labelText: 'Plate Number',
               border: OutlineInputBorder()
               
             ),
                 onChanged: (val){
                   setState(() => email = val);

                 }
               ),
                SizedBox(height :10.0),
              
               TextFormField(
                 controller: driverName,
                 validator: (val) => val.isEmpty?'Enter the driver name':null,
                // obscureText: true,
                decoration: InputDecoration(
               labelText: 'Driver Name',
               border: OutlineInputBorder()
               
             ),
                 onChanged: (val){
                     setState(() => password = val);
                 }),
                  SizedBox(height :10.0),

               TextFormField(
                  controller: licenseNumber,
                 validator: (val) => val.isEmpty?'Enter the driver license number':null,
                
                decoration: InputDecoration(
               labelText: 'Driver License Number',
               border: OutlineInputBorder()
               
             ),
                 onChanged: (val){
                     setState(() => password = val);
                 }),
                  SizedBox(height :10.0),


               TextFormField(
                 controller: color,
                validator: (val) => val.isEmpty?'Enter the color':null,
                decoration: InputDecoration(
               labelText: 'Color',
               border: OutlineInputBorder()
               
             ),
                 onChanged: (val){
                     setState(() => password = val);
                 }),
                  SizedBox(height :10.0),

               TextFormField(
                 controller: publicPrivate,
                validator: (val) => val.isEmpty?'Enter private or public':null,
                decoration: InputDecoration(
               labelText: 'Private or Public',
               border: OutlineInputBorder()
               
             ),
                 onChanged: (val){
                     setState(() => password = val);
                 }),
                  SizedBox(height :10.0),

               TextFormField(
                 controller: luxeryLevel,
                  validator: (val) => val.isEmpty?'Enter luxery level':null,
                decoration: InputDecoration(
               labelText: 'Luxery Level',
               border: OutlineInputBorder()
               
             ),
                 onChanged: (val){
                     setState(() => password = val);
                 }),
                  SizedBox(height :10.0),

               TextFormField(
                  controller: seat,
                 validator: (val) => val.isEmpty?'Enter seat count':null,
                decoration: InputDecoration(
               labelText: 'Seat Count',
               border: OutlineInputBorder()
               
             ),
                 onChanged: (val){
                     setState(() => password = val);
                 }),*/
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
  Map <String, dynamic> data ={"Plate Number":plateNumber.text,"Driver Name":
  driverName.text,"License Number":licenseNumber.text,"Color":color.text,
  "Public or Private":publicPrivate.text,"Luxury Level":luxeryLevel.text,"Seat Count":seat.text,};

  FirebaseFirestore.instance.collection('NewBus').add(data);

                     
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



                 ),],),],),),),),//)
                 
                  
          
       /* Column(
        mainAxisAlignment:MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width:0.4 * MediaQuery.of(context).size.width,
           child: TextField(
             decoration: InputDecoration(
               labelText: 'Plate Number',
               border: OutlineInputBorder()
               
             ),
           )),
           SizedBox(height:20),
           
            Row(
             mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.center,
           
             children: [
                  Container(
            width:0.4 * MediaQuery.of(context).size.width,
           child: TextField(
             decoration: InputDecoration(
               labelText: 'Driver Name',
               border: OutlineInputBorder()
               
             ),
           )),

              
             ],
             
           ),
           SizedBox(height:20),
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.center,
           
             children: [
                  Container(
            width:0.4 * MediaQuery.of(context).size.width,
           child: TextField(
             decoration: InputDecoration(
               labelText: 'Driver License Number',
               border: OutlineInputBorder()
               
             ),
           )),

              
             ],
             
           ),
           SizedBox(height:20),
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.center,
           
             children: [
                  Container(
            width:0.4 * MediaQuery.of(context).size.width,
           child: TextField(
             decoration: InputDecoration(
               labelText: 'Color',
               border: OutlineInputBorder()
               
             ),
           )),

              
             ],
             
           ),
           SizedBox(height:20),
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.center,
           
             children: [
                  

               RaisedButton(onPressed: (){}, child: Text('Submit')),
               SizedBox(width:20),
                RaisedButton(onPressed: (){}, child: Text('Cancel')),
             ],
             
           ),
        ],
      ),*/
        );//])
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