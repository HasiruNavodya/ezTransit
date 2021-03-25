//import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:mywebsite/add new bus.dart';
import 'package:flutter/material.dart';
import 'package:mywebsite/AddTrip.dart';
import 'package:mywebsite/auth.dart';
//import 'package:transportapp/Pages/emergency.dart';


class Navigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context,constraints){
          if(constraints.maxWidth>1200){
            return DesktopNavbar();
          }

          else if (constraints.maxWidth>800 && constraints.maxWidth<1800)
        {return DesktopNavbar();

         }  
         else {
         return MobileNavbar();
           }  },
    
    );
    
    
    /*Container(
      height:80,
      child:Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
         // SizedBox(height:80, width:150,child:Image.asset('assets/logo.jpg'),
          //),
          Row(
            mainAxisSize: MainAxisSize.min,
            children:<Widget>[
              _NavBarItem('New Bus'),
              SizedBox(width:60),
              _NavBarItem('Add Trip'),
              SizedBox(width:60),
             _NavBarItem('Emergencies'),
              SizedBox(width:60)
          ],) 
        ],

      ),
    );*/
  }
}

/*class _NavBarItem extends StatelessWidget {

  final String title;
  const _NavBarItem(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(title, style:TextStyle(fontSize:18),);
  }
}*/

class DesktopNavbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:20, horizontal:30),
      child: Container(
        constraints: BoxConstraints(maxWidth: 1200),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Transport Management Application', style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 22,
            ),),

            Row(
              children: [
                
                Text('Home',style:TextStyle(color: Colors.white), 
                ),
                SizedBox(width:60),
                MaterialButton(
                        color:Colors.pink,
                        onPressed: (){
                         // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context )=>NewBus()));
                        },
                        child: Text('New Bus',style:TextStyle(color: Colors.white), 
                    ),
                    ),
                SizedBox(width:60),
                Text('Add Trip',style:TextStyle(color: Colors.white), 
                ),
                SizedBox(width:60),

                   MaterialButton(
                       color:Colors.pink, 

                       onPressed: ()
                         async { 
                         // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context )=>Emergency()));
      //DocumentSnapshot variable = await FirebaseFirestore.instance.collection('NewBus').doc('tvkvBAluBhI0QJ6Hjjeo').get();
  //print(variable['Color']);
  ;
                        
                        },
                        child: Text('Emergency',style:TextStyle(color: Colors.white), 
                        
                    ),
                    ),
             
                SizedBox(width:60),
                  ElevatedButton(
          onPressed: () {
            AuthService().signOut();
             /* Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MapSample()),
              );*/
          },
          child: Center(child: Text('LOG OUT')))
              ],
            )
          ],
        )
      ),
    );
  }
}

class MobileNavbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:15),
      child: Container(
        child: Column(
          children: <Widget>[
           
              Text('Transport Management Application', style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 22,
              ),),

              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Row(
                  mainAxisAlignment:MainAxisAlignment.center,
                  children: [
                    SizedBox(width:40),
                    Text('Home',style:TextStyle(color: Colors.white), 
                    ),
                    SizedBox(width:50),
                     MaterialButton(
                        color:Colors.pink,
                        onPressed: (){
                         // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context )=>NewBus()));
                        },
                        child: Text('New Bus',style:TextStyle(color: Colors.white), 
                    ),
                    ),
                   
                    SizedBox(width:50),
                    MaterialButton(
                        color:Colors.pink,
                        onPressed: (){
                         Navigator.push(context, MaterialPageRoute(builder: (BuildContext context )=>AddTrip()));
                        },
                        child: Text('New Bus',style:TextStyle(color: Colors.white), 
                    ),
                    ),
                    SizedBox(width:50),
                   MaterialButton(
                       color:Colors.pink, 

                       onPressed: ()
                          { 
                           // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context )=>Emergency()));
      //DocumentSnapshot variable = await FirebaseFirestore.instance.collection('New Bus').doc('GR944BdniaKIp0NdmqKz').get();
     // print(variable['color']);
                        
                        },
                        child: Text('Emergency',style:TextStyle(color: Colors.white), 
                        
                    ),
                    ),
                    SizedBox(width:40),
                  ],
                ),
              )
            ],
        )
      ),
    );
  }
}