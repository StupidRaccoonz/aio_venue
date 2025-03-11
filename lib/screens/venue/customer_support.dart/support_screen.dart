import 'package:aio_sport/screens/venue/customer_support.dart/contact_us_screen.dart';
import 'package:aio_sport/screens/venue/customer_support.dart/report_problem_screen.dart';
import 'package:aio_sport/screens/venue/settings/change_password_screen.dart';
import 'package:aio_sport/screens/venue/settings/privacy_policy_screen.dart';
import 'package:aio_sport/screens/venue/settings/terms_values_screen.dart';
import 'package:aio_sport/themes/custom_theme.dart';
import 'package:aio_sport/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scaled_size/scaled_size.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.maxFinite, 10.vh),
        child: AppbarWidget(
          title: "Help & Support",
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
            CustomListTile(
              title: "Report problem",
              onTap: () {
                Get.to(ReportProblemScreen());
              },
            ),
            SizedBox(
              height: 10,
            ),
            CustomListTile(
              title: "Contact us",
              onTap: () {
                Get.to(ContactUsScreen());
              },
            ),
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
