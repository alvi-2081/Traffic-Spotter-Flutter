import 'package:crime_analysis_flutter/utilities/colors.dart';
import 'package:flutter/material.dart';

class RoundedButtonExpanded extends StatelessWidget {
  final String title;
  final VoidCallback onPress;
  final bool loading;
  const RoundedButtonExpanded({
    Key? key,
    required this.title,
    required this.onPress,
    this.loading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: loading ? null : onPress,
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20), // <-- Radius
            ),
            disabledBackgroundColor: AppColors.main,
            backgroundColor: AppColors.main,
            elevation: 3,
            minimumSize: Size(200, 55)),
        child: loading
            ? const SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : Text(title));
  }
}
