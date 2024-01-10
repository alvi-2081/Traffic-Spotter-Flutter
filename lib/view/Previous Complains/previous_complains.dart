import 'package:crime_analysis_flutter/controllers/services/Complain%20Services/complain_services.dart';
import 'package:crime_analysis_flutter/utilities/colors.dart';
import 'package:crime_analysis_flutter/view/Previous%20Complains/widgets/previous_complains_card.dart';
import 'package:flutter/material.dart';

class PreviousComplainsScreen extends StatefulWidget {
  const PreviousComplainsScreen({super.key});

  @override
  State<PreviousComplainsScreen> createState() =>
      _PreviousComplainsScreenState();
}

class _PreviousComplainsScreenState extends State<PreviousComplainsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.main,
        centerTitle: true,
        title: const Text("Previous Spots"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                  future: getPreviousComplains(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data?.response?.length,
                          itemBuilder: (context, index) {
                            return PreviousComplainCard(
                                complainData: snapshot.data!.response![index]);
                          });
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
