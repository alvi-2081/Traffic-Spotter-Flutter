import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

//Custom Button Widget
class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.title,
    this.color = Colors.green,
    this.isDisable = false,
    required this.onClick,
    this.alignment,
    this.padding,
    this.boarderColor = Colors.green,
    this.width = 0.55,
    this.heigth = 0.06,
    this.textSize = 0.039,
    this.textColor,
    this.fontWeight = FontWeight.w500,
    this.boarderRadius = 100,
  }) : super(key: key);
  final String title;
  final bool isDisable;
  final Color color;
  final Color? textColor;
  final Color boarderColor;
  final void Function()? onClick;
  final double width;
  final FontWeight fontWeight;
  final double heigth;
  final double textSize;
  final double boarderRadius;
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isDisable ? null : onClick,
      child: Padding(
        padding: padding ?? const EdgeInsets.only(),
        child: Align(
          alignment: alignment ?? Alignment.center,
          child: Container(
            width: Get.width * width,
            height: Get.height * heigth,
            decoration: BoxDecoration(
                border: Border.all(
                    color: isDisable
                        ? boarderColor.withOpacity(0.0)
                        : boarderColor,
                    width: 1),
                borderRadius: BorderRadius.circular(boarderRadius),
                color: isDisable ? color.withOpacity(0.3) : color),
            child: Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: textColor ?? Colors.white,
                    fontWeight: fontWeight,
                    fontSize: Get.width * textSize),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    Key? key,
    required this.title,
    this.isDisable = false,
    required this.onClick,
    this.alignment,
    this.padding,
    this.width = 0.55,
    this.heigth = 0.06,
    this.textSize = 0.039,
    this.textColor,
    this.fontWeight = FontWeight.w500,
  }) : super(key: key);
  final String title;
  final bool isDisable;
  final Color? textColor;
  final void Function()? onClick;
  final double width;
  final FontWeight fontWeight;
  final double heigth;
  final double textSize;
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isDisable ? null : onClick,
      child: Padding(
        padding: padding ?? const EdgeInsets.only(),
        child: Align(
          alignment: alignment ?? Alignment.center,
          child: Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: textColor ?? Colors.white,
                  fontWeight: fontWeight,
                  fontSize: Get.width * textSize),
            ),
          ),
        ),
      ),
    );
  }
}

class SimpleBackButton extends StatelessWidget {
  const SimpleBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding:
            EdgeInsets.only(top: Get.height * 0.05, left: Get.width * 0.025),
        child: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Row(
            children: [
              const Icon(
                Icons.arrow_back_ios_new,
                size: 21,
              ),
              CustomText(
                padding: EdgeInsets.only(left: Get.width * 0.01),
                text: "back",
                fontSize: 0.014,
                alignment: Alignment.topLeft,
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom_Text for whole app
class CustomText extends StatelessWidget {
  const CustomText(
      {Key? key,
      required this.text,
      this.fontSize = 0.015,
      this.padding,
      this.alignment,
      this.fontColor,
      this.fontWeight,
      this.isItalic = false,
      this.textAlign})
      : super(key: key);
  final String text;
  final double fontSize;
  final bool isItalic;
  final FontWeight? fontWeight;
  final EdgeInsetsGeometry? padding;
  final TextAlign? textAlign;
  final AlignmentGeometry? alignment;
  final Color? fontColor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.only(),
      child: Align(
        alignment: alignment ?? Alignment.topLeft,
        child: Text(text,
            textAlign: textAlign ?? TextAlign.start,
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
              fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
              fontWeight: fontWeight ?? FontWeight.w400,
              color: fontColor ?? Colors.black12,
              fontSize: Get.height * fontSize,
            ))),
      ),
    );
  }
}

////////////////////////////////////////////////////////