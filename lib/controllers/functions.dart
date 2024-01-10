import 'package:crime_analysis_flutter/utilities/colors.dart';
import 'package:flutter/material.dart';

void snackBar(BuildContext context, String message,
    [Color color = AppColors.main, int time = 3000]) {
  var snackBar = SnackBar(
    dismissDirection: DismissDirection.horizontal,
    backgroundColor: color,
    duration: Duration(milliseconds: time),
    content: Text(
      message,
      style: const TextStyle(fontWeight: FontWeight.bold),
    ),
    padding: const EdgeInsets.symmetric(vertical: 23, horizontal: 20),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
