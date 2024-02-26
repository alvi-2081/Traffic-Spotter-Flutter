import 'package:crime_analysis_flutter/view/Home/custom_buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NearByGroupPreviewCard extends StatelessWidget {
  const NearByGroupPreviewCard(
      {super.key,
      required this.title,
      required this.groupData,
      required this.tagline,
      required this.members,
      required this.dipslayPicture,
      required this.type});
  final Map groupData;
  final String title;
  final List members;
  final String tagline;
  final String type;
  final String dipslayPicture;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: Get.width * 0.05,
          right: Get.width * 0.05,
          top: Get.height * 0.045,
          bottom: Get.height * 0.035),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              right: Get.width * 0.03,
              top: Get.height * 0.007,
            ),
            child: Container(
              height: Get.height * 0.15,
              width: Get.width * 0.9,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(0, 0, 0, 0.1),
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(dipslayPicture),
                  )),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: title,
                  fontColor: Colors.black,
                  fontSize: 0.018,
                  fontWeight: FontWeight.w500,
                ),
                CustomText(
                  text: "$type - ${members.length} members",
                  fontColor: Colors.black,
                  fontSize: 0.015,
                  fontWeight: FontWeight.w500,
                ),
                CustomText(
                  text: tagline,
                  fontSize: 0.014,
                  fontColor: Colors.black.withOpacity(0.8),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
