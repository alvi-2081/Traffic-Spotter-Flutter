import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:crime_analysis_flutter/controllers/functions.dart';
import 'package:crime_analysis_flutter/controllers/globals.dart';
import 'package:crime_analysis_flutter/model/complain_model.dart';
import 'package:crime_analysis_flutter/model/previous_complain_model.dart';
import 'package:crime_analysis_flutter/navigation_bar.dart';
import 'package:crime_analysis_flutter/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

Future<ComplainModel?> getAllComplains() async {
  final response = await http.get(
    Uri.parse(
      '$url/all_crime_data.php',
    ),
  );
  var responseBody = jsonDecode(response.body);
  ComplainModel complains = ComplainModel();
  if (response.statusCode == 200) {
    complains = ComplainModel.fromJson(responseBody);
    return complains;
  } else {
    return complains;
  }
}

Future<ComplainModel?> searchComplain(
    {required String area,
    required String fromDate,
    required String toDate,
    context}) async {
  Map body = {'area': area, 'from': fromDate, 'to': toDate};
  log(body.toString());
  final response =
      await http.post(Uri.parse("$url/all_crime_data.php"), body: body);

  var responseBody = jsonDecode(response.body);
  ComplainModel complains = ComplainModel();
  if (response.statusCode == 200) {
    if (responseBody['response'] != null && responseBody['response'] != '') {
      complains = ComplainModel.fromJson(responseBody);
    }
    return complains;
  } else {
    return complains;
  }
}

Future<void> createComplain(
    {required String victimName,
    required String type,
    required String date,
    required String time,
    required String address,
    required LatLng addresslatLng,
    context}) async {
  try {
    Map body = {
      'user_id': userModel.response!.id.toString(),
      'location': address,
      'date': date,
      'time': time,
      'type': type,
      'victim_name': victimName,
      'latitude': addresslatLng.latitude.toString(),
      'longitude': addresslatLng.longitude.toString()
    };

    final response =
        await http.post(Uri.parse("$url/add_complain.php"), body: body);
    var responseBody = jsonDecode(response.body);
    if (response.statusCode == 200) {
      snackBar(context, responseBody["message"]);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const NaviGationBar(
                  tab: SelectedTab.profile,
                )),
      );
    } else {
      snackBar(context, responseBody["message"], AppColors.error);
    }
  } on SocketException {
    snackBar(context, "No Internet Connection", AppColors.error);
  } catch (e) {
    snackBar(context, "There is some error, please try again later",
        AppColors.error);
  }
}

Future<PreviousComplainModel?> getPreviousComplains() async {
  final response = await http.post(
      Uri.parse(
        '$url/previous_complain.php',
      ),
      body: {
        'user_id': userModel.response!.id.toString(),
      });
  var responseBody = jsonDecode(response.body);
  PreviousComplainModel previousComplains = PreviousComplainModel();
  if (response.statusCode == 200) {
    if (responseBody['response'] != null && responseBody['response'] != '') {
      previousComplains = PreviousComplainModel.fromJson(responseBody);
    }
    return previousComplains;
  } else {
    return previousComplains;
  }
}
