import 'package:crime_analysis_flutter/main.dart';
import 'package:crime_analysis_flutter/model/complain_model.dart';

import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   final List<LatLng> locations = [
//     const LatLng(37.7749, -122.4194), // San Francisco
//     const LatLng(34.0522, -118.2437), // Los Angeles
//     const LatLng(40.7128, -74.0060), // New York
//     // Add more coordinates as needed
//   ];

//   List<LatLng> closestLocations = [];

//   @override
//   void initState() {
//     super.initState();
//     // _getClosestLocations();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Top 10 Closest Locations'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'Top 10 Closest Locations:',
//               style: TextStyle(fontSize: 18),
//             ),
//             SizedBox(height: 10),
//             if (closestLocations.isNotEmpty)
//               Column(
//                 children: closestLocations.map((location) {
//                   return Text('Lat: ${location}, Lon: ${location}');
//                 }).toList(),
//               )
//             else
//               Text('Loading...'),
//           ],
//         ),
//       ),
//     );
//   }
// }
List<Response> getClosestLocations(
  List<Response> locations,
) {
  try {
    // Get current location

    // Calculate distances and sort locations
    locations.sort((a, b) {
      double distanceToA = getDistance(
          position!.latitude,
          position!.longitude,
          double.tryParse(a.latitude!) ?? 00,
          double.tryParse(a.longitude!) ?? 00);
      double distanceToB = getDistance(
          position!.latitude,
          position!.longitude,
          double.tryParse(b.latitude!) ?? 00,
          double.tryParse(b.longitude!) ?? 00);
      return distanceToA.compareTo(distanceToB);
    });
    List<Response> sortDarta = List.from(locations.take(10));
    return sortDarta;
  } catch (e) {
    return [];
  }
}

double getDistance(double lat1, double lon1, double lat2, double lon2) {
  const Distance distance = Distance();
  return distance.as(
    LengthUnit.Meter,
    LatLng(lat1, lon1),
    LatLng(lat2, lon2),
  );
}
