import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapPage extends StatefulWidget {
  GoogleMapPage({Key? key,required this.latitude,required this.longitude,required this.departmentName}) : super(key: key);
  double latitude;
  double longitude;
  String departmentName;
  @override
  State<GoogleMapPage> createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {

  final List<Marker> _marker = [];

  List<LatLng> points = [
    LatLng(34.057705, 71.569144),
    LatLng(34.057599, 71.566108),
    LatLng(34.054106, 71.566215),
    LatLng(34.053466, 71.567750),
    LatLng(34.054594, 71.569005),
    LatLng(34.056470, 71.569209),
  ];

  Set<Polygon> _polygone = HashSet<Polygon>();

  Completer<GoogleMapController> _controller = Completer();

  Future<Position> getUserCurrentLocation()async{
    await Geolocator.requestPermission().then((value){

    }).onError((error, stackTrace){
      print("Error : ${error}");
    });
    return await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final List<Marker> _list = [
      Marker(
        markerId: MarkerId('1'),
        position: LatLng(widget.latitude,widget.longitude),
        infoWindow: InfoWindow(
          title: "${widget.departmentName} Department",
        ),
      ),
    ];
    _marker.addAll(_list);
    _polygone.add(
      Polygon(
        polygonId: PolygonId("2"),
        points: points,
        fillColor: Colors.blue.withOpacity(0.1),
        geodesic: true,
        strokeWidth: 1,
        strokeColor: Colors.blue,
      )
    );
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.departmentName),
        centerTitle: true,
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.latitude, widget.longitude),
          zoom: 17,
        ),
        markers: Set<Marker>.of(_marker),
        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
        },
        mapType: MapType.hybrid,
        compassEnabled: true,
        polygons: _polygone,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
          getUserCurrentLocation().then((value)async{
            print("my current Location");
            print(value.longitude.toString() + value.latitude.toString());
            _marker.add(
              Marker(
                markerId: MarkerId("2"),
                position: LatLng(value.latitude, value.longitude),
                icon: BitmapDescriptor.defaultMarkerWithHue(50.0),
                infoWindow: InfoWindow(
                  title: "My Current Location",
                ),
              ),
            );
            CameraPosition cameraPosition = CameraPosition(
              target: LatLng(value.latitude, value.longitude),
              zoom: 16,
            );
            final GoogleMapController controller = await _controller.future;
            controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
          });
          setState(() {
            
          });
        },
        child: Icon(Icons.my_location),
      ),
    );
  }
}
