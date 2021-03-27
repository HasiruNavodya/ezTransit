import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mywebsite/AddTrip.dart';
//import 'page.dart';

const CameraPosition _kInitialPosition =
CameraPosition(target: LatLng(7.8731, 80.7718), zoom: 11.0);

class MapClickPageNew extends StatelessWidget {
  //MapClickPage() : super(const Icon(icons.mouse), 'Map click');

  @override
  Widget build(BuildContext context) {
    return const _MapClickBody();
  }
}

class _MapClickBody extends StatefulWidget {
  const _MapClickBody();

  @override
  State<StatefulWidget> createState() => _MapClickBodyState();
}

class _MapClickBodyState extends State<_MapClickBody> {
  _MapClickBodyState();

  GoogleMapController mapController;
  LatLng _lastTap;
  LatLng _lastLongPress;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _latitude;
  String _longitude;


//get data from textformfield
  TextEditingController cnlatitude = new TextEditingController();
  TextEditingController cnlongitude = new TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Stops'),
      ),
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              child: Column(
                children: [
                  TextFormField(
                  controller: cnlatitude,
                  decoration: InputDecoration(labelText: 'Latitude', border: OutlineInputBorder()),
                  /*onSaved: (String value) {
                    _publicPrivate = value;
                  },*/),
                  TextFormField(
                    controller: cnlongitude,
                    decoration: InputDecoration(labelText: 'Longitude', border: OutlineInputBorder()),
                    /*onSaved: (String value) {
                      _publicPrivate = value;
                    },*/),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                GoogleMap(
                onMapCreated: onMapCreated,
                initialCameraPosition: _kInitialPosition,
                onTap: (LatLng pos) {
                  cnlatitude.text = pos.latitude.toString();
                  cnlongitude.text = pos.longitude.toString();
                  setState(() {
                    _lastTap = pos;
                  });
                },
                onLongPress: (LatLng pos) {
                  setState(() {
                    _lastLongPress = pos;
                  });
                  },
                ),
              ],
            ),
          ),
        ],
      ),

    );
    final GoogleMap googleMap = GoogleMap(
      onMapCreated: onMapCreated,
      initialCameraPosition: _kInitialPosition,
      onTap: (LatLng pos) {
        setState(() {
          _lastTap = pos;
        });
      },
      onLongPress: (LatLng pos) {
        setState(() {
          _lastLongPress = pos;
        });
      },
    );

    final List<Widget> columnChildren = <Widget>[
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: SizedBox(
            width: 300.0,
            height: 200.0,
            child: googleMap,
          ),
        ),
      ),
    ];

    if (mapController != null) {
      final String lastTap = 'Tap:\n${_lastTap ?? ""}\n';
      columnChildren.add(Center(child: Text(lastTap, textAlign: TextAlign.center)));
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: columnChildren,
    );
  }

  void onMapCreated(GoogleMapController controller) async {
    setState(() {
      mapController = controller;
    });
  }

}
