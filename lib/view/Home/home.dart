import 'dart:async';
import 'dart:developer';
import 'package:crime_analysis_flutter/controllers/services/Complain%20Services/complain_services.dart';
import 'package:crime_analysis_flutter/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

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

  void handleSearch(context) async {
    setState(() {
      loading = true;
    });
    await searchComplain(
            area: searchQueryController.text,
            fromDate:
                DateFormat('yyyy-MM-dd HH:mm:ss').format(startDate).toString(),
            toDate:
                DateFormat('yyyy-MM-dd HH:mm:ss').format(endDate).toString())
        .then((value) {
      if (value!.response != null) {
        for (var i in value.response!) {
          marker.add(Marker(
            markerId: MarkerId(i.id.toString()),
            position:
                LatLng(double.parse(i.latitude!), double.parse(i.longitude!)),
          ));
        }

        log(marker.toString());
      } else {
        setState(() {
          // _list.clear();
          marker.clear();
        });
      }
      setState(() {
        loading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    // _marker.addAll(_list);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size(MediaQuery.of(context).size.width * 1, 115),
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 0),
                    child: TextField(
                      controller: searchQueryController,
                      decoration: InputDecoration(
                        suffixIcon: searched
                            ? InkWell(
                                onTap: () {
                                  setState(() {
                                    searched = !searched;
                                  });

                                  searchQueryController.clear();
                                },
                                child: const Icon(
                                  Icons.cancel_outlined,
                                  color: AppColors.main,
                                ))
                            : InkWell(
                                onTap: () async {
                                  if (searchQueryController.text.isNotEmpty) {
                                    setState(() {
                                      searched = !searched;
                                    });
                                    handleSearch(context);
                                  }
                                },
                                child: const Icon(
                                  Icons.search,
                                  color: AppColors.main,
                                )),
                        hintText: "Search Area Name",
                        border: InputBorder.none,
                        hintStyle: const TextStyle(color: AppColors.main),
                      ),
                      style: const TextStyle(
                          color: AppColors.main, fontSize: 16.0),
                    ),
                  ),
                ),
                Container(
                  height: 1,
                  color: AppColors.main,
                ),
                Container(
                  color: Colors.white,
                  child: Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          dense: true,
                          onTap: () {
                            _startDate(context);
                          },
                          title: const Text(
                            'Start Date:',
                            style: TextStyle(
                                // fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: AppColors.main),
                          ),
                          subtitle: Text(
                            DateFormat.yMMMd().format(startDate),
                          ),
                          trailing: IconButton(
                              onPressed: () {
                                _startDate(context);
                              },
                              icon: const Icon(
                                Icons.date_range,
                                color: AppColors.main,
                              )),
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          dense: true,
                          onTap: () {
                            _endDate(context);
                          },
                          title: const Text(
                            'End Date:',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.main),
                          ),
                          subtitle: Text(
                            DateFormat.yMMMd().format(endDate),
                          ),
                          trailing: IconButton(
                              onPressed: () {
                                _endDate(context);
                              },
                              icon: const Icon(
                                Icons.date_range,
                                color: AppColors.main,
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          body: loading == false
              ? marker.isEmpty
                  ? GoogleMap(
                      initialCameraPosition: initailCameraPosition,
                      onMapCreated: (GoogleMapController controller) {
                        controllerMap = controller;
                      },
                    )
                  : GoogleMap(
                      initialCameraPosition: initailCameraPosition,
                      markers: marker,
                      onMapCreated: (GoogleMapController controller) {
                        controllerMarker = controller;
                      },
                      // circles: {
                      //   Circle(
                      //       circleId: CircleId("i"),
                      //       center: initialPosition,
                      //       radius: 430,
                      //       strokeWidth: 1,
                      //       // strokeColor: ,
                      //       fillColor: Color.fromARGB(255, 255, 221, 221))
                      // },
                      // mapType: MapType.normal,
                      // myLocationButtonEnabled: true,
                      // myLocationEnabled: true,
                      // compassEnabled: false,
                    )
              : const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.main,
                  ),
                )),
    );
  }

  _startDate(BuildContext context) async {
    DateTime? selected = await showDatePicker(
      context: context,
      initialDate: startDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.main, // header background color
              // onPrimary: Colors.black, // header text color
              onSurface: AppColors.main, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.main, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (selected != null && selected != startDate) {
      setState(() {
        startDate = selected;
      });
    }
  }

  _endDate(BuildContext context) async {
    DateTime? selected = await showDatePicker(
      context: context,
      initialDate: endDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.main, // header background color
              // onPrimary: Colors.black, // header text color
              onSurface: AppColors.main, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.main, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (selected != null && selected != endDate) {
      setState(() {
        endDate = selected;
      });
    }
  }
}
