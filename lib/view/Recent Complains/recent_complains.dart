import 'package:crime_analysis_flutter/controllers/services/Complain%20Services/complain_services.dart';
import 'package:crime_analysis_flutter/utilities/colors.dart';
import 'package:crime_analysis_flutter/view/Recent%20Complains/widgets/complains_card.dart';
import 'package:flutter/material.dart';

class RecentComplains extends StatefulWidget {
  const RecentComplains({super.key});

  @override
  State<RecentComplains> createState() => _RecentComplainsState();
}

class _RecentComplainsState extends State<RecentComplains> {
  int count = 10;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.main,
        centerTitle: true,
        title: const Text("Recent Spots"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                  future: getAllComplains(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                                itemCount: count,
                                itemBuilder: (context, index) {
                                  return ComplainCard(
                                      complainData:
                                          snapshot.data?.response![index]);
                                }),
                          ),
                          InkWell(
                            onTap: () => setState(() {
                              count = count + 10;
                            }),
                            child: const Text(
                              "See More",
                              style: TextStyle(
                                  color: AppColors.main, fontSize: 24),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.main,
                        ),
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
