import 'package:crime_analysis_flutter/controllers/services/Complain%20Services/complain_services.dart';
import 'package:crime_analysis_flutter/model/complain_model.dart';
import 'package:crime_analysis_flutter/view/Home/custom_buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      position: LatLng(24.9121, 67.0988),
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
                  // controllerMap.animateCamera(CameraUpdate.newCameraPosition(
                  //     CameraPosition(
                  //         target: LatLng(
                  //             double.parse(complains.response![0].latitude!),
                  //             double.parse(complains.response![0].longitude!)),
                  //         zoom: 14.4746)));

                  for (var location in complains.response!) {
                    marker.add(Marker(
                      onTap: () {
                        showBarModalBottomSheet(
                          context: Get.context!,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20))),
                          builder: (context) => NearByGroupPreviewCard(
                            groupData: location.toJson(),
                            title: location.location ?? "",
                            tagline: "",
                            members: [],
                            dipslayPicture:
                                "https://media.gettyimages.com/id/155287967/photo/cars-in-rush-hour-with-traffic-at-dawn.jpg?s=1024x1024&w=gi&k=20&c=DbF3UUfK6Vc6Xyib8oY6vxxG6RUTzOgZQUvV8GgJUN0=",
                            type: location.type!,
                          ),
                        );
                      },
                      markerId: MarkerId(location.id.toString()),
                      position: LatLng(double.parse(location.latitude!),
                          double.parse(location.longitude!)),
                    ));
                  }
                  setState(() {});
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

class NearByGroupPreviewCard extends StatelessWidget {
  const NearByGroupPreviewCard(
      {super.key,
      required this.title,
      required this.groupData,
      required this.tagline,
      required this.members,
      required this.dipslayPicture,
      required this.type});
  final Map groupData;
  final String title;
  final List members;
  final String tagline;
  final String type;
  final String dipslayPicture;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: Get.width * 0.05,
          right: Get.width * 0.05,
          top: Get.height * 0.045,
          bottom: Get.height * 0.035),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              right: Get.width * 0.03,
              top: Get.height * 0.007,
            ),
            child: Container(
              height: Get.height * 0.09,
              width: Get.width * 0.2,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(0, 0, 0, 0.1),
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(dipslayPicture),
                  )),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: title,
                  fontColor: Colors.black,
                  fontSize: 0.018,
                  fontWeight: FontWeight.w500,
                ),
                CustomText(
                  text: "$type - ${members.length} members",
                  fontColor: Colors.black,
                  fontSize: 0.015,
                  fontWeight: FontWeight.w500,
                ),
                CustomText(
                  text: tagline,
                  fontSize: 0.014,
                  fontColor: Colors.black.withOpacity(0.8),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
