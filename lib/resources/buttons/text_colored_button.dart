import 'package:crime_analysis_flutter/utilities/colors.dart';
import 'package:flutter/material.dart';

class TextColoredButton extends StatelessWidget {
  final String title;

  final VoidCallback onPress;
  const TextColoredButton({
    Key? key,
    required this.title,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Text(
        title,
        style: TextStyle(color: AppColors.main, fontWeight: FontWeight.bold),
      ),
    );
  }
}
