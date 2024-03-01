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
              height: Get.height * 0.25,
              width: Get.width * 0.9,
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(0, 0, 0, 0.1),
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(dipslayPicture),
                  )),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: 'Location : $title',
                  fontColor: Colors.black,
                  fontSize: 0.04,
                  fontWeight: FontWeight.w500,
                  padding: const EdgeInsets.symmetric(vertical: 5),
                ),
                CustomText(
                  text: 'Uploaded By : $tagline',
                  fontColor: Colors.black,
                  fontSize: 0.02,
                  fontWeight: FontWeight.w500,
                  padding: const EdgeInsets.symmetric(vertical: 5),
                ),
                const ListTile(
                  leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.account_circle,
                        color: Colors.grey,
                        size: 35,
                      )),
                  title: Text('Ahmed'),
                  subtitle: Text('It is a busy street'),
                ),
                const ListTile(
                  leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.account_circle,
                        color: Colors.grey,
                        size: 35,
                      )),
                  title: Text('Farhan'),
                  subtitle: Text('Stuck in trafic'),
                ),
                const ListTile(
                  leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.account_circle,
                        color: Colors.grey,
                        size: 35,
                      )),
                  title: Text('Zohaib'),
                  subtitle: Text('Worst experience'),
                ),
                // CustomText(
                //   text: "$type - ${members.length} members",
                //   fontColor: Colors.black,
                //   fontSize: 0.015,
                //   fontWeight: FontWeight.w500,
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
