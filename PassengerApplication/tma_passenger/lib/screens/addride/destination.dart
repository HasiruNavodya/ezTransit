import 'package:flutter/material.dart';
import 'package:tma_passenger/screens/addride/pickup.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SelectDestination extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Select Destination',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>{

  Widget build(BuildContext context) {
    return Scaffold(
        body:Map()
    );
  }
}

class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class  _MapState extends State<Map> {
  GoogleMapController mapController;
  static const _initialPosition = LatLng(7.2906, 80.6337);
  LatLng _lastPostion = _initialPosition;
  final Set<Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Destination"),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SelectPickup()),
          );
        },
        child: Icon(Icons.arrow_forward_ios),
        backgroundColor: Colors.black87,
      ),

      body: Stack(
        children: <Widget>[

          GoogleMap(initialCameraPosition: CameraPosition(
              target: _initialPosition, zoom: 200.0),
            onMapCreated: onCreated,
            myLocationEnabled: true,
            mapType: MapType.normal,
            compassEnabled: true,
            markers: _markers,
            onCameraMove: _onCameraMove,


          ),

        ],
      ),
    );
  }

  void onCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }


  void _onCameraMove(CameraPosition position) {
    setState(() {
      _lastPostion = position.target;
    });
  }


  void _onAddMarkerPressed() {
    setState(() {
      _markers.add(Marker(markerId: MarkerId(_lastPostion.toString()),
          position: _lastPostion,
          infoWindow: InfoWindow(
            title: "remeber here",
            snippet: "good place",

          ),
          icon: BitmapDescriptor.defaultMarker
      ));
    });
  }
}



