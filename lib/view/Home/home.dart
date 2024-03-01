import 'package:crime_analysis_flutter/controllers/services/Complain%20Services/complain_services.dart';
import 'package:crime_analysis_flutter/model/complain_model.dart';
import 'package:crime_analysis_flutter/view/Home/location.dart';
import 'package:crime_analysis_flutter/view/Home/navbar_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchQueryController = TextEditingController();
  bool searched = false;
  bool loading = false;

  DateTime startDate = DateTime(2018);
  DateTime endDate = DateTime.now();
  late GoogleMapController controllerMap;
  late GoogleMapController controllerMarker;

  final CameraPosition initailCameraPosition =
      const CameraPosition(target: LatLng(24.8607, 67.0011), zoom: 14.4746);

  // LatLng initialPosition = const LatLng(24.900621787983635, 67.0137608401669);

  Set<Marker> marker = {
    Marker(
      markerId: MarkerId('11'),
      position: LatLng(24.9204, 67.1344),
    )
  };
  // final List<Marker> _list = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        bottom: true,
        child: Scaffold(
          body: FutureBuilder(
              future: getAllComplains(),
              builder: (context, AsyncSnapshot<ComplainModel?> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                } else if (snapshot.hasError || snapshot.data == null) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasData) {
                  ComplainModel complains = snapshot.data!;
                  List<Response> closesrLocations =
                      getClosestLocations(complains.response!);
                  for (var location in closesrLocations) {
                    marker.add(Marker(
                      onTap: () {
                        showBarModalBottomSheet(
                          context: getx.Get.context!,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20))),
                          builder: (context) => NearByGroupPreviewCard(
                            groupData: location.toJson(),
                            title: location.location ?? "",
                            tagline: location.victimName ?? "",
                            members: [],
                            dipslayPicture:
                                "https://media.gettyimages.com/id/155287967/photo/cars-in-rush-hour-with-traffic-at-dawn.jpg?s=1024x1024&w=gi&k=20&c=DbF3UUfK6Vc6Xyib8oY6vxxG6RUTzOgZQUvV8GgJUN0=",
                            type: location.type!,
                          ),
                        );
                      },
                      markerId: MarkerId(location.id.toString()),
                      position: LatLng(
                          double.tryParse(location.latitude!) ?? 00,
                          double.tryParse(location.longitude!) ?? 00),
                    ));
                  }
                  // setState(() {});
                  return GoogleMap(
                      initialCameraPosition: initailCameraPosition,
                      markers: marker,
                      onMapCreated: (GoogleMapController controller) {
                        controllerMarker = controller;
                      });
                } else {
                  return const CircularProgressIndicator();
                }
                return const CircularProgressIndicator();
              }),
        ));
  }
}
