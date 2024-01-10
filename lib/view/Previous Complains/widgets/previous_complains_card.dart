import 'package:crime_analysis_flutter/model/previous_complain_model.dart';
import 'package:crime_analysis_flutter/utilities/colors.dart';
import 'package:crime_analysis_flutter/view/Recent%20Complains/widgets/complains_map.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PreviousComplainCard extends StatelessWidget {
  final Response? complainData;
  const PreviousComplainCard({required this.complainData, super.key});

  @override
  Widget build(BuildContext context) {
    List splitedDate = complainData!.date!.trim().split(" ");

    String formatedDate = complainData!.date!.contains("/")
        ? DateFormat('dd-MMMM-yyyy')
            .format(DateFormat("dd/MM/yyyy").parse(splitedDate[0]))
        : DateFormat('dd-MMMM-yyyy')
            .format(DateFormat("yyyy-MM-dd").parse(splitedDate[0]));

    String formatedTime = complainData!.date!.contains("/")
        ? splitedDate[1] + splitedDate[2]
        : DateFormat.jm().format(DateFormat("hh:mm:ss").parse(splitedDate[1]));
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ComplainsMapScreen(
                    location: complainData!.location.toString(),
                    long: double.parse(complainData!.longitude!),
                    lat: double.parse(complainData!.latitude!),
                  ))),
      child: Card(
        color: AppColors.main,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                complainData!.location!,
                style: const TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Row(
                  children: [
                    Text(
                      "Reporter Name : ${complainData!.victimName}",
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 5.0),
              //   child: Row(
              //     children: [
              //       Text(
              //         "Type of Crime : ${complainData!.type}",
              //         style: const TextStyle(color: Colors.white, fontSize: 14),
              //       ),
              //     ],
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Date : $formatedDate",
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    Text(
                      "Time : $formatedTime",
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
              ),
              Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage(
                        "assets/map.png",
                      ),
                      fit: BoxFit.cover,
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
