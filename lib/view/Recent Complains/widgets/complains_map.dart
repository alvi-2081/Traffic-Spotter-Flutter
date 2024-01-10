import 'dart:async';
import 'package:crime_analysis_flutter/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ComplainsMapScreen extends StatefulWidget {
  final String location;
  final double long;
  final double lat;
  const ComplainsMapScreen(
      {required this.location, required this.long, required this.lat, Key? key})
      : super(key: key);

  @override
  State<ComplainsMapScreen> createState() => ComplainsMapScreenState();
}

class ComplainsMapScreenState extends State<ComplainsMapScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  Widget build(BuildContext context) {
    LatLng initialPosition = LatLng(widget.lat, widget.long);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.main,
        title: Text(widget.location),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.lat, widget.long),
          zoom: 14.4746,
        ),
        zoomControlsEnabled: false,
        markers: {
          Marker(
            markerId: MarkerId(widget.location),
            position: initialPosition,
          ),
        },
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
