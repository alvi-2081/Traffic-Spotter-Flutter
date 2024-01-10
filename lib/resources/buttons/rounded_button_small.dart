import 'package:crime_analysis_flutter/utilities/colors.dart';
import 'package:crime_analysis_flutter/utilities/responsive.dart';
import 'package:flutter/material.dart';

class RoundedButtonSmall extends StatelessWidget {
  final String title;
  final VoidCallback onPress;
  const RoundedButtonSmall({
    Key? key,
    required this.title,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          elevation: 1,
          backgroundColor: AppColors.main,
          minimumSize: Size(width(70), height(28)),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
            32,
          ))),
      onPressed: onPress,
      child: Text(
        title,
        style: TextStyle(color: Colors.white, fontSize: height(14)),
      ),
    );
  }
}
