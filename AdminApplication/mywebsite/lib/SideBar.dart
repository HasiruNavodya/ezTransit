



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:mywebsite/AddTrip.dart';
import 'package:mywebsite/Complaints.dart';
import 'package:mywebsite/Emergency.dart';
import 'package:mywebsite/Home%20View.dart';
import 'package:mywebsite/LogOut.dart';
import 'package:mywebsite/NewBus.dart';
import 'package:mywebsite/auth.dart';

class SideBarWidget{
  sideBarMenus(context, selectedRoute){
    return SideBar(
        items: const [
          MenuItem(
            title: 'Dashboard',
            route: Home.id,
            icon: Icons.dashboard,
          ),

          MenuItem(
            title: 'Add New Bus',
            route: NewBus.id,
            icon: CupertinoIcons.bus,
          ),

          MenuItem(
            title: 'Add Trip',
            route: Trip.id,
            icon: Icons.trip_origin_rounded,
          ),

          MenuItem(
            title: 'Emergency',
            route: Emergency.id,
            icon: Icons.dangerous,
          ),
            MenuItem(
            title: 'Complaints',
            route: Complaints.id,
            icon: Icons.messenger
          ),
               MenuItem(
            title: 'Log Out',
            route: LogOut.id,
            icon: Icons.logout
          ),
         
        ],
            
        selectedRoute: selectedRoute,
        onSelected: (item) {
          Navigator.of(context).pushNamed(item.route);
        },

           
        header: Container(
          height: 50,
          width: double.infinity,
          color: Colors.black26,
          child: Center(
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        footer: Container(
          height: 50,
          
          child: Center(
            child:        ElevatedButton(
          onPressed: () {
            AuthService().signOut();
             
          },
          child: Center(child: Text('LOG OUT')))
          ),
        ),
    );


      
  }
}