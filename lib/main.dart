import 'dart:developer';

import 'package:crime_analysis_flutter/utilities/routes.dart';
import 'package:crime_analysis_flutter/view/Auth/SignIn/sign_In.dart';
import 'package:crime_analysis_flutter/view/Home/home.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

Position? position;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }
  var permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }
  // position = Position(
  //     longitude: 24.918877,
  //     latitude: 67.097681,
  //     timestamp: DateTime.now(),
  //     accuracy: 47.93199920654297,
  //     altitude: -26.30000114440918,
  //     altitudeAccuracy: 1.7562021017074585,
  //     floor: null,
  //     heading: 0.0,
  //     headingAccuracy: 45.0,
  //     speed: 0.0,
  //     speedAccuracy: 1.5,
  //     isMocked: false);
  position = await Geolocator.getCurrentPosition();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Traffic Spotters',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: appRoutes,
      home: SignIn(),
    );
  }
}
