import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MapScreen(),
    );
  }
}

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();
  LocationData? _currentLocation;
  Location _location = Location();
  Set<Marker> _markers = {};
  List<LatLng> _polylineCoordinates = [];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _updateLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      LocationData locationData = await _location.getLocation();
      setState(() {
        _currentLocation = locationData;
        _markers.add(_createMarker());
        _polylineCoordinates.add(LatLng(
          locationData.latitude!,
          locationData.longitude!,
        ));
      });
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  void _updateLocation() {
    Timer.periodic(Duration(seconds: 10), (timer) async {
      await _getCurrentLocation();
      _updatePolyline();
      _animateToUser();
    });
  }

  void _updatePolyline() {
    setState(() {
      _polylineCoordinates.add(LatLng(
        _currentLocation!.latitude!,
        _currentLocation!.longitude!,
      ));
    });
  }

  Marker _createMarker() {
    return Marker(
      markerId: MarkerId("myLocation"),
      position: LatLng(
        _currentLocation!.latitude!,
        _currentLocation!.longitude!,
      ),
      infoWindow: InfoWindow(
        title: "My current location",
        snippet:
        "Lat: ${_currentLocation!.latitude}, Lng: ${_currentLocation!.longitude}",
      ),
    );
  }

  void _animateToUser() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
            _currentLocation!.latitude!,
            _currentLocation!.longitude!,
          ),
          zoom: 15.0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Real Time Location Tracker'),
      ),
      body: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(0, 0),
          zoom: 2.0,
        ),
        markers: _markers,
        polylines: {
          Polyline(
            polylineId: PolylineId("userLocation"),
            color: Colors.blue,
            points: _polylineCoordinates,
          ),
        },
      ),
    );
  }
}
