import 'dart:async';
import 'dart:developer';
import 'package:crime_analysis_flutter/controllers/globals.dart';
import 'package:crime_analysis_flutter/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';

class PickLocationScreen extends StatefulWidget {
  final TextEditingController addressController;
  final Function(LatLng) updateAddressLatLng;

  const PickLocationScreen(
      {required this.addressController,
      required this.updateAddressLatLng,
      super.key});

  @override
  State<PickLocationScreen> createState() => _PickLocationScreenState();
}

class _PickLocationScreenState extends State<PickLocationScreen> {
  GoogleMapController? mapController;
  LatLng? selectedLatLng;
  TextEditingController locationController = TextEditingController();
  List<String> suggestions = [];
  List<String> suggestionsName = [];

  // Position? currentPosition;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    //   currentPosition = await _determinePosition();
    // });
  }

  @override
  void dispose() {
    locationController.dispose();
    super.dispose();
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<List<String>> fetchSuggestions(String input) async {
    final query = Uri.encodeComponent(input);

    final url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$query&components=country:PK&key=$mapApiKEy';
    // log(url.toString());
    final response = await http.get(Uri.parse(url));
    final responseData = json.decode(response.body);
    // log(responseData.toString());
    // log("---------------------------------------------");
    if (response.statusCode == 200 &&
        responseData['status'] == 'OK' &&
        responseData['predictions'] != null) {
      final predictions = responseData['predictions'] as List<dynamic>;
      final suggestionList = predictions
          .map((prediction) => prediction['description'] as String)
          .toList();
      suggestionsName = predictions
          .map((prediction) =>
              prediction['structured_formatting']['main_text'] as String)
          .toList();
      return suggestionList;
    }

    return [];
  }

  void updateSuggestions(String input) async {
    final suggestionList = await fetchSuggestions(input);
    setState(() {
      suggestions = suggestionList;
    });
  }

  void updateLocation(String address) async {
    // final address = locationController.text;
    List<Location> locations = await locationFromAddress(address);
    // final location = await getLatLngFromAddress(address);

    if (locations.isNotEmpty) {
      final pickedLatLng =
          LatLng(locations.last.latitude, locations.last.longitude);
      mapController?.animateCamera(CameraUpdate.newLatLng(pickedLatLng));

      setState(() {
        selectedLatLng = pickedLatLng;
      });
    } else {
      // Handle invalid address
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Invalid address. Please try again.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.main,
          title: TextField(
            controller: locationController,
            onChanged: (input) {
              updateSuggestions(input);
            },
            decoration: const InputDecoration(
              hintText: 'Enter an area name',
              hintStyle: TextStyle(color: Colors.white),
              border: InputBorder.none,
            ),
            style: const TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
            if (locationController.text.isNotEmpty)
              IconButton(
                icon: const Icon(Icons.cancel_outlined),
                onPressed: () {
                  setState(() {
                    locationController.clear();
                    suggestions.clear();
                    widget.addressController.clear();
                  });
                },
              ),
          ],
        ),
        body: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: suggestions.length,
              itemBuilder: (ctx, index) {
                final suggestion = suggestions[index];
                return ListTile(
                  title: Text(suggestion),
                  onTap: () {
                    locationController.text = suggestion;
                    updateLocation(suggestion);
                    suggestions.clear();
                    widget.addressController.text = suggestionsName[index];
                    log(widget.addressController.text);
                  },
                );
              },
            ),
            Expanded(
              child: GoogleMap(
                onMapCreated: (controller) {
                  setState(() {
                    mapController = controller;
                  });
                },
                onTap: (LatLng location) {
                  setState(() {
                    selectedLatLng = location;
                  });
                },
                initialCameraPosition: CameraPosition(
                  target:
                      //  currentPosition != null ? LatLng(currentPosition!.latitude, currentPosition!.latitude):
                      LatLng(24.8607, 67.0011), // Initial map location
                  zoom: 12.0,
                ),
                zoomControlsEnabled: false,
                markers: <Marker>{
                  if (selectedLatLng != null)
                    Marker(
                      markerId: const MarkerId('picked-location'),
                      position: selectedLatLng!,
                    ),
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: AppColors.main,
          onPressed: () {
            if (selectedLatLng != null) {
              log('Latitude: ${selectedLatLng!.latitude}');
              log('Longitude: ${selectedLatLng!.longitude}');
              widget.updateAddressLatLng(selectedLatLng!);
              Navigator.pop(context);
            }
          },
          label: const Text('Pick Location'),
          icon: const Icon(Icons.location_on),
        ),
      ),
    );
  }
}
