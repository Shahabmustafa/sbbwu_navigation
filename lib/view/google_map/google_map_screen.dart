import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class GoogleMapPage extends StatefulWidget {
  GoogleMapPage({Key? key,required this.latitude,required this.longitude,required this.departmentName}) : super(key: key);
  double latitude;
  double longitude;
  String departmentName;
  @override
  State<GoogleMapPage> createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {

  Completer<GoogleMapController> _controller = Completer();
  String googleAPiKey = "AIzaSyBwuUjRz1WHEH4-WIRidK8QUKJNSqQgDUU";
  Set<Marker> markers = Set(); //markers for google map
  // final startLocation = LatLng(34.043059, 71.578878);
  // final endLocation = LatLng(34.027482, 71.575359);
  Map<PolylineId, Polyline> polylines = {}; //polylines to show direction;
  String mapTheme = "";
  List<LatLng> polylineCoordinates = [];
  LocationData? currentLocation;

  void getLocation()async{
    Location location = Location();
    location.getLocation().then((location){
      currentLocation = location;
    });
    GoogleMapController googleMapController = await _controller.future;
    location.onLocationChanged.listen((newloc){
      currentLocation = newloc;
      googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              zoom: 14,
              target: LatLng(newloc.latitude!, newloc.longitude!),
            ),
          ),
      );
      setState(() {

      });
    });
  }

  getDirections() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPiKey,
      PointLatLng(widget.latitude,widget.longitude),
      PointLatLng(currentLocation!.latitude!,currentLocation!.longitude!),
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    setState(() {

    });
  }

  @override
  void initState() {
    super.initState();
    DefaultAssetBundle.of(context).loadString("assets/maptheme/silver.json").then((value){
      mapTheme = value;
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.departmentName),
        centerTitle: true,
        actions: [
          PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                    onTap: (){
                      _controller.future.then((value){
                        DefaultAssetBundle.of(context).loadString("assets/maptheme/silver.json").then((String){
                          value.setMapStyle(String);
                        });
                      });
                    },
                    child: Text("Silver")
                ),
                PopupMenuItem(
                    onTap: (){
                      _controller.future.then((value){
                        DefaultAssetBundle.of(context).loadString("assets/maptheme/night_theme.json").then((String){
                          value.setMapStyle(String);
                        });
                      });
                    },
                    child: Text("Night")
                ),
                PopupMenuItem(
                    onTap: (){
                      _controller.future.then((value){
                        DefaultAssetBundle.of(context).loadString("assets/maptheme/aubergine.json").then((String){
                          value.setMapStyle(String);
                        });
                      });
                    },
                    child: Text("Aubergine")
                ),
              ]
          ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.latitude,widget.longitude),
          zoom: 20,
        ),
        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
          controller.setMapStyle(mapTheme);
        },
        markers: {
          Marker(
            markerId: MarkerId("Department Location"),
            position: LatLng(widget.latitude, widget.longitude),
            icon: BitmapDescriptor.defaultMarker,
            infoWindow: InfoWindow(
              title: widget.departmentName,
            ),
          ),
          Marker(
            markerId: MarkerId("Current Location"),
            position: currentLocation == null ? LatLng(widget.latitude,widget.longitude) : LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
            icon: BitmapDescriptor.defaultMarker,
            infoWindow: InfoWindow(
              title: "My Current Location",
            ),
          ),
        },
        polylines: {
          Polyline(
            polylineId: PolylineId("routes"),
            points: polylineCoordinates,
            width: 3,
            color: Colors.blue,
            jointType: JointType.bevel
          )
        },
        zoomGesturesEnabled: true,
        mapType: MapType.satellite,
        compassEnabled: true,
        // zoomControlsEnabled: true,
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: (){
              getDirections();
            },
            child: Icon(Icons.directions),
          ),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            onPressed: (){
              getLocation();
            },
            child: Icon(Icons.my_location),
          ),
        ],
      ),
    );
  }
}
