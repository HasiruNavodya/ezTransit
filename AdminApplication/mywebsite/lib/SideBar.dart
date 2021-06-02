import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:mywebsite/AddBusOwner.dart';
import 'package:mywebsite/Complaints.dart';
import 'package:mywebsite/Emergency.dart';
import 'package:mywebsite/Home%20View.dart';
import 'package:mywebsite/NewBus.dart';
import 'package:mywebsite/auth.dart';
import 'package:mywebsite/initializeTrip.dart';
import 'package:mywebsite/login.dart';
import 'package:mywebsite/partial.dart';

class SideBarWidget {
  sideBarMenus(context, selectedRoute) {
    return SideBar(
      items: const [
        MenuItem(
          title: 'Home',
          route: Home.id,
          icon: Icons.home,
        ),
        MenuItem(
          title: 'Add New Bus',
          route: NewBus.id,
          icon: CupertinoIcons.bus,
        ),
        MenuItem(
          title: 'Initialize Trip',
          route: InitializeTrip.id,
          icon: Icons.trip_origin_rounded,
        ),
         MenuItem(
          title: 'Partial Route',
          route: Partial.id,
          icon: Icons.add_road,
        ),
        MenuItem(
          title: 'Emergency',
          route: Emergency.id,
          icon: Icons.dangerous,
        ),
        MenuItem(
            title: 'Complaints', route: Complaints.id, icon: Icons.messenger
        ),
        /*MenuItem(
            title: 'Add Bus Owner', route: AddBusOwner.id, icon: Icons.perm_identity
        ),*/


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
            child: ElevatedButton(
                onPressed: () {
                  AuthService().signOut();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => LoginPage()));
                },
                child: Center(child: Text('LOG OUT')))),
      ),
    );
  }
}
