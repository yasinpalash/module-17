import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

//AIzaSyAq6IwRq6ur-gF9-lkR8xLz0QtIll-e_Mk
class _HomeScreenState extends State<HomeScreen> {
  late GoogleMapController googleMapController;
  Location location = Location();
  Future<void> getCurrentLocation() async {
    final LocationData locationData = await location.getLocation();

    googleMapController.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(locationData.latitude!, locationData.longitude!),
          zoom: 17,
        ),
      ),

    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
            zoom: 17,
            target: LatLng(23.792265005916146, 90.40561775869223),
            bearing: 0,
            tilt: 5),
        onTap: (LatLng position) {
          print(position);
        },
        onCameraMove: (cameraPosition) {
          print(cameraPosition);
        },
        onMapCreated: (GoogleMapController controller) {
          googleMapController = controller;
          getCurrentLocation();

        },
        zoomControlsEnabled: true,
        compassEnabled: true,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        markers: {
          Marker(
              markerId: MarkerId('initialPosition'),
              position: LatLng(23.792265005916146, 90.40561775869223),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueYellow),
              infoWindow: const InfoWindow(
                  title: 'this is my location', snippet: 'this is snipprt'),
              draggable: true,
              onDragEnd: (LatLng position) {
                print(position);
              },
              onDragStart: (LatLng position) {
                print(position);
              },
              onDrag: (LatLng position) {
                print(position);
              },
              onTap: () {
                print('on tapped ');
              }),
          Marker(
              markerId: MarkerId('initialPosition'),
              position: LatLng(23.791120163741198, 90.40613237768412),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueBlue),
              infoWindow: const InfoWindow(
                  title: 'this is my location 2', snippet: 'this is snipprt 2'),
              draggable: true,
              onDragEnd: (LatLng position) {
                print(position);
              },
              onDragStart: (LatLng position) {
                print(position);
              },
              onDrag: (LatLng position) {
                print(position);
              },
              onTap: () {
                print('on tapped 2');
              }),
          Marker(
              markerId: MarkerId('initialPosition'),
              position: LatLng(23.792516335226885, 90.40664903819561),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueCyan),
              infoWindow: const InfoWindow(
                  title: 'this is my location 3', snippet: 'this is snipprt 3'),
              draggable: true,
              onDragEnd: (LatLng position) {
                print(position);
              },
              onDragStart: (LatLng position) {
                print(position);
              },
              onDrag: (LatLng position) {
                print(position);
              },
              onTap: () {
                print('on tapped 3 ');
              }),
        },
        polylines: {
          Polyline(
              polylineId: PolylineId('basic-id'),
              width: 6,
              color: Colors.blue,
              endCap: Cap.buttCap,
              jointType: JointType.mitered,
              patterns: [
                PatternItem.gap(10),
                PatternItem.dash(10),
                PatternItem.dot,
                PatternItem.dash(10)
              ],
              points: [
                LatLng(23.792516335226885, 90.40664903819561),
                LatLng(23.791120163741198, 90.40613237768412),
                LatLng(23.792265005916146, 90.40561775869223),
                LatLng(23.792516335226885, 90.40664903819561),
              ])
        },
        polygons: {
          Polygon(
              polygonId: PolygonId('basic-polygons'),
              fillColor: Colors.blueGrey,
              consumeTapEvents: true,
              onTap: () {
                print('this is polygon');
              },
              points: [
                LatLng(23.790039355343435, 90.4059362411499),
                LatLng(23.790464562331124, 90.40803171694279),
                LatLng(23.788457855384536, 90.40875859558582),
                LatLng(23.787985089003186, 90.40676940232515),
              ])
        },
        circles: {
          Circle(
              circleId: CircleId('basic-circle'),
              center: LatLng(23.789620282737566, 90.4040989279747),
              radius: 40,
              fillColor: Colors.pinkAccent,
              strokeColor: Colors.blue,
              strokeWidth: 6,
              consumeTapEvents: true,
              onTap: () {
                print('this circle');
              })
        },
      ),
    );
  }
}
