import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sbbwu_navigator/model/polyline_response.dart';

class Practis extends StatefulWidget {
  const Practis({Key? key}) : super(key: key);

  @override
  State<Practis> createState() => _PractisState();
}

class _PractisState extends State<Practis> {

  LatLng sourceLocation = LatLng(34.043965, 71.579495);
  LatLng destinationLocation = LatLng(34.036513, 71.578927);
  String apiKey = "AIzaSyBwuUjRz1WHEH4-WIRidK8QUKJNSqQgDUU";
  Set<Polyline> polylinePoints = {};

  PolylineResponse polylineResponse = PolylineResponse();

  // void getPollyLinePoint()async{
  //   PolylinePoints points = PolylinePoints();
  //   PolylineResult result = await points.getRouteBetweenCoordinates(
  //     "AIzaSyBwuUjRz1WHEH4-WIRidK8QUKJNSqQgDUU",
  //     PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
  //     PointLatLng(destinationLocation.latitude, destinationLocation.longitude),
  //     travelMode: TravelMode.driving,
  //   );
  //   if(result.points.isNotEmpty){
  //     result.points.forEach((PointLatLng point) => polyLineCoordinates.add(
  //       LatLng(point.latitude, point.longitude),
  //     ));
  //     setState(() {
  //
  //     });
  //   }
  // }

  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
            target: sourceLocation,
            zoom: 15,
          ),
        polylines: polylinePoints,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){

        },
        child: Icon(Icons.directions),
      ),
    );
  }

  // void drawPolyLine()async{
  //   var response = await http.post(Uri.parse(
  //       "https://maps.googleapis.com/maps/api/directions/json?origin=${sourceLocation.latitude},${sourceLocation.longitude}&destination=${destinationLocation.latitude},${destinationLocation.longitude}&key=${apiKey}"
  //   ));
  //   print(">><<<<>>>${response.body}");
  //   polylineResponse = PolylineResponse.fromJson(jsonDecode(response.body));
  //   setState(() {
  //
  //   });
  // }
}
