import 'package:crime_analysis_flutter/utilities/colors.dart';
import 'package:crime_analysis_flutter/utilities/responsive.dart';
import 'package:flutter/material.dart';

class TextFieldContainer extends StatefulWidget {
  final String title;
  final String hint;
  final IconData icon;
  final TextEditingController controller;
  final TextInputType inputType;

  final FormFieldValidator validator;

  const TextFieldContainer(
      {required this.title,
      required this.hint,
      required this.icon,
      required this.controller,
      this.inputType = TextInputType.name,
      required this.validator});

  @override
  State<TextFieldContainer> createState() => _TextFieldContainerState();
}

class _TextFieldContainerState extends State<TextFieldContainer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: width(10)),
        Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            )),
        SizedBox(height: width(10)),
        TextFormField(
          keyboardType: widget.inputType,
          controller: widget.controller,
          validator: widget.validator,
          cursorColor: AppColors.grey,
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: const TextStyle(
              color: AppColors.grey,
            ),
            prefixIcon: Icon(
              widget.icon,
              color: AppColors.grey,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  const BorderSide(color: AppColors.black_light, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              gapPadding: 0.0,
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  const BorderSide(color: AppColors.black_light, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              gapPadding: 0.0,
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  const BorderSide(color: AppColors.black_light, width: 1.5),
            ),
          ),
        ),
        SizedBox(
          height: height(5),
        ),
      ],
    );
  }
}
