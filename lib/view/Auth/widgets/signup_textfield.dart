import 'package:crime_analysis_flutter/utilities/colors.dart';
import 'package:crime_analysis_flutter/utilities/responsive.dart';
import 'package:flutter/material.dart';

class FirstNameSignUp extends StatefulWidget {
  final String title;
  final String hint;
  final IconData icon;
  final TextEditingController controller;

  const FirstNameSignUp({
    required this.title,
    required this.hint,
    required this.icon,
    required this.controller,
  });

  @override
  State<FirstNameSignUp> createState() => _FirstNameSignUpState();
}

class _FirstNameSignUpState extends State<FirstNameSignUp> {
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
          keyboardType: TextInputType.name,
          maxLength: 30,
          controller: widget.controller,
          validator: (value) {
            if (value!.isEmpty) {
              return "*Required";
            } else {
              return null;
            }
          },
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
              borderRadius: BorderRadius.circular(15),
              borderSide:
                  const BorderSide(color: AppColors.black_light, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              gapPadding: 0.0,
              borderRadius: BorderRadius.circular(15),
              borderSide:
                  const BorderSide(color: AppColors.black_light, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              gapPadding: 0.0,
              borderRadius: BorderRadius.circular(15),
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

class NumberSignUp extends StatefulWidget {
  final String title;
  final String hint;
  final IconData icon;
  final TextEditingController controller;

  const NumberSignUp({
    required this.title,
    required this.hint,
    required this.icon,
    required this.controller,
  });

  @override
  State<NumberSignUp> createState() => _NumberSignUpState();
}

class _NumberSignUpState extends State<NumberSignUp> {
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
          keyboardType: TextInputType.number,
          controller: widget.controller,
          maxLength: 15,
          validator: (value) {
            if (value!.isEmpty) {
              return "*Required";
            } else {
              return null;
            }
          },
          cursorColor: AppColors.grey,
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: const TextStyle(
              color: AppColors.grey,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide:
                  const BorderSide(color: AppColors.black_light, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              gapPadding: 0.0,
              borderRadius: BorderRadius.circular(15),
              borderSide:
                  const BorderSide(color: AppColors.black_light, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              gapPadding: 0.0,
              borderRadius: BorderRadius.circular(15),
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

class PasswordSignUp extends StatefulWidget {
  final String title;
  final String hint;
  final IconData icon;
  final TextEditingController controller;

  const PasswordSignUp({
    super.key,
    required this.title,
    required this.hint,
    required this.icon,
    required this.controller,
  });

  @override
  State<PasswordSignUp> createState() => _PasswordSignUpState();
}

class _PasswordSignUpState extends State<PasswordSignUp> {
  bool _passwordVisible = false;

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
          maxLength: 12,
          controller: widget.controller,
          cursorColor: AppColors.grey,
          obscureText: !_passwordVisible,
          validator: (value) {
            if (value!.isEmpty) {
              return "*Required";
            } else if (value.length <= 7) {
              return '*Minimum 8 character required';
            } else {
              return null;
            }
          },
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: const TextStyle(
              color: AppColors.grey,
            ),
            prefixIcon: Icon(
              widget.icon,
              color: AppColors.grey,
            ),
            suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
                child: Icon(
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: AppColors.grey,
                )),
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
