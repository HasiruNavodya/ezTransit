import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:mywebsite/SideBar.dart';


class Complaints extends StatefulWidget {
  static const String id = 'complaints';
  @override
  _ComplaintsState createState() => _ComplaintsState();
}

class _ComplaintsState extends State<Complaints> {
  @override
  Widget build(BuildContext context) {

    SideBarWidget _sideBar = SideBarWidget();
    return  AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Transport Management System'),
      ),
      sideBar: _sideBar.sideBarMenus(context, Complaints.id),
      body: 
        
          StreamBuilder (
         stream: FirebaseFirestore.instance.collection('complaints').snapshots(),
         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot ){
        if(!snapshot.hasData){
             return Text('No Value');
           }
           return 
            Padding(
               padding: EdgeInsets.symmetric(vertical: 40, horizontal: 50),
             
              child:
             
                  ListView(
               children: snapshot.data.docs.map((DocumentSnapshot document){
               
                return  Card(
                   elevation: 10, 
              child:Container(
                 padding: EdgeInsets.all(30),
                  
                    
                  height:200,
                   decoration: BoxDecoration(
                     color: Colors.blue[200],
              borderRadius: BorderRadius.only(
                
              ),),
            
        
          
                   child: Column(children: [
                     
                    Row(children: [
Text('Bus Plate Number : ',style: TextStyle(fontSize: 16),),
  Text(document.data()['Plate Number'].toString(),style: TextStyle(fontSize: 16),),
   ],)  , 
          SizedBox(height:10),         
                                 
                    Row(children: [
Text('Complaint : ',style: TextStyle(fontSize: 16),),
   
   ],)  ,
   Text(document.data()['Complaint'].toString(),style: TextStyle(fontSize: 16),),       
                 
                   
                 
                    
                 ],),
              
               ),);},).toList(),
                
           
     ),);}),
        );
      




 
    
  }
}

 
 
         
      