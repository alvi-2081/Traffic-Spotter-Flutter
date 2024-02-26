import 'package:crime_analysis_flutter/controllers/services/Complain%20Services/complain_services.dart';
import 'package:crime_analysis_flutter/model/complain_model.dart';
import 'package:crime_analysis_flutter/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
                  controllerMap.animateCamera(CameraUpdate.newCameraPosition(
                      CameraPosition(
                          target: LatLng(
                              double.parse(complains.response![0].latitude!),
                              double.parse(complains.response![0].longitude!)),
                          zoom: 14.4746)));
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
