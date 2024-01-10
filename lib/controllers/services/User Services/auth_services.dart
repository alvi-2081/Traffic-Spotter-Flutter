import 'dart:convert';
import 'dart:io';
import 'package:crime_analysis_flutter/controllers/functions.dart';
import 'package:crime_analysis_flutter/model/user_model.dart';
import 'package:crime_analysis_flutter/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../globals.dart';

Future<void> emailLogin(
    String phone, String email, String password, context) async {
  try {
    final response = await http.post(Uri.parse("$url/login.php"),
        body: {'phone': phone, 'email': email, 'password': password},
        headers: {});
    var responseBody = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      userModel = UserModel.fromJson(responseBody[0]);
      snackBar(
        context,
        responseBody[0]["message"],
      );
      Navigator.pushNamedAndRemoveUntil(
          context, "/NavigationBar", (route) => false);
    } else {
      snackBar(context, responseBody[0]["message"], AppColors.error);
    }
  } on SocketException {
    snackBar(context, "No Internet Connection", AppColors.error);
  } catch (e) {
    snackBar(context, e.toString(), AppColors.error);
  }
}

Future<void> signUp(
    String name, String email, String phone, String password, context) async {
  try {
    final response = await http.post(Uri.parse("$url/signup.php"), body: {
      'name': name,
      'email': email,
      'phone': phone,
      'password': password
    });

    var responseBody = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      snackBar(context, responseBody["message"]);
      Navigator.pushNamedAndRemoveUntil(context, "/SignIn", (route) => false);
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

// Future<BarcodeResultModel>? barcodeResultApi(
//     String putToken, int barcodeData) async {
//   try {
//     final url =
//         Uri.parse("https://202.163.101.236:4443/api/v1/models/m_transaction?");

//     final uri = Uri.https(
//       url.authority,
//       url.path,
//       {'\$filter': "M_AttributeSetInstance_ID eq $barcodeData"},
//     );
//     // Set up the headers with the bearer token
//     final headers = {
//       'Authorization': 'Bearer $token',
//       'Content-Type': 'application/json',
//     };
//     final getResponse = await http.get(uri, headers: headers);
//     // print('this is barcode screen data $getjsonData');
//     if (getResponse.statusCode == 200) {
//       var jsonData = json.decode(getResponse.body);
//       return BarcodeResultModel.fromJson(jsonData);
//     } else if (getResponse.statusCode == 401) {
//       return null;
//       print("error 401");
//     } else {
//       return null;
//       print("error");
//     }
//   } catch (e) {
//     return null;
//     print("-----------------------");
//     print("this is the $e");
//   }
// }
