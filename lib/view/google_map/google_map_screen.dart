import 'dart:async';

import 'package:flutter/material.dart';
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

  Completer<GoogleMapController> _controller = Completer();

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
          zoom: 18.7,
        ),
        markers: Set<Marker>.of(_marker),
        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
        },
        mapType: MapType.hybrid,
        compassEnabled: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
          GoogleMapController controller = await _controller.future;
          controller.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(34.028716,71.591731),
              zoom: 14.1,
            ),
          ));
          setState(() {

          });
        },
        child: Icon(Icons.my_location),
      ),
    );
  }
}
