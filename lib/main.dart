import 'package:crime_analysis_flutter/utilities/routes.dart';
import 'package:crime_analysis_flutter/view/Auth/SignIn/sign_In.dart';
import 'package:crime_analysis_flutter/view/Home/home.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

Position? position;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
      home: HomeScreen(),
    );
  }
}
