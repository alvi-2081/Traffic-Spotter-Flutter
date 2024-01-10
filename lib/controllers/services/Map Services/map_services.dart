import 'dart:convert';

import 'package:crime_analysis_flutter/controllers/globals.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<LatLng?> getLatLngFromAddress(String address) async {
  final query = Uri.encodeComponent(address);

  final url =
      'https://maps.googleapis.com/maps/api/geocode/json?address=$query&key=$mapApiKEy';

  final response = await http.get(Uri.parse(url));
  final responseData = json.decode(response.body);
  print(responseData);
  print("---------------------------------------------");
  if (response.statusCode == 200 &&
      responseData['status'] == 'OK' &&
      responseData['results'] != null &&
      responseData['results'].length > 0) {
    final result = responseData['results'][0];
    final geometry = result['geometry'];
    final location = geometry['location'];
    final lat = location['lat'];
    final lng = location['lng'];

    return LatLng(lat, lng);
  }

  return null;
}
