import 'package:aio_sport/screens/venue/customer_support.dart/submit_report_screen.dart';
import 'package:aio_sport/screens/venue/settings/change_password_screen.dart';
import 'package:aio_sport/screens/venue/settings/privacy_policy_screen.dart';
import 'package:aio_sport/screens/venue/settings/terms_values_screen.dart';
import 'package:aio_sport/themes/custom_theme.dart';
import 'package:aio_sport/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scaled_size/scaled_size.dart';

class ReportProblemScreen extends StatelessWidget {
  const ReportProblemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> issuesList = [
      "Payment issue",
      "Cancellation",
      "Others",
      "Linking Bank Account",
      "Refund",
      "Price discrepancy",
      "Unable to Join Match",
      "Unable to create booking",
      "Not able to cancel booking",
    ];
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.maxFinite, 10.vh),
        child: AppbarWidget(
          title: "Report problem",
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
            onPressed: () => Get.back(),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Why are you facing issue?",
              style: TextStyle(fontSize: screenHeight * 0.03, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "Select the problem you are facing from below and write us, we will look into that and get back to you real soon.",
              style: TextStyle(fontSize: screenHeight * 0.02, fontWeight: FontWeight.normal),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: issuesList.length,
                itemBuilder: (context, index) {
                  return CustomListTile(
                    title: issuesList[index],
                    onTap: () {
                      Get.to(SubmitReportScreen(
                        type: issuesList[index],
                      ));
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  const CustomListTile({
    super.key,
    required this.onTap,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: CustomTheme.grey.withOpacity(0.2)),
      ),
      child: ListTile(
        title: Text(title, style: Get.textTheme.headlineLarge!.copyWith(fontWeight: FontWeight.bold)),
        onTap: onTap,
        trailing: const Icon(Icons.arrow_forward_ios_rounded),
      ),
    );
  }
}
