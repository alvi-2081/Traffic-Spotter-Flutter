import 'package:crime_analysis_flutter/utilities/colors.dart';
import 'package:crime_analysis_flutter/utilities/responsive.dart';
import 'package:flutter/material.dart';

class ProfileScreenButton extends StatelessWidget {
  final String? title;
  final IconData? icon;
  final VoidCallback? onPress;

  const ProfileScreenButton(
      {required this.title,
      required this.icon,
      required this.onPress,
      super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
            color: AppColors.grey_light,
            border: Border.all(color: AppColors.grey_light, width: 1),
            borderRadius: BorderRadius.circular(15)),
        child: Row(
          children: [
            Icon(
              icon,
              color: AppColors.main,
            ),
            SizedBox(
              width: width(20),
            ),
            Expanded(
              child: Text(
                title!,
                style: TextStyle(
                    color: AppColors.main, fontWeight: FontWeight.bold),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.main,
            ),
          ],
        ),
      ),
    );
  }
}
