import 'package:aio_sport/screens/venue/settings/change_password_screen.dart';
import 'package:aio_sport/screens/venue/settings/privacy_policy_screen.dart';
import 'package:aio_sport/screens/venue/settings/terms_values_screen.dart';
import 'package:aio_sport/themes/custom_theme.dart';
import 'package:aio_sport/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scaled_size/scaled_size.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.maxFinite, 10.vh),
        child: AppbarWidget(
          title: "Settings",
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
            onPressed: () => Get.back(),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Security",
              style: TextStyle(
                fontSize: screenHeight * 0.03,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            CustomListTile(
              title: "Change password",
              onTap: () {
                Get.to(const ChangePasswordScreen());
              },
            ),
            const SizedBox(height: 20),
            Text(
              "About",
              style: TextStyle(
                fontSize: screenHeight * 0.03,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            CustomListTile(
              title: "Privacy Policy",
              onTap: () {
                Get.to(const PrivacyPolicyScreen());
              },
            ),
            const SizedBox(height: 5),
            CustomListTile(
              title: "Terms of use",
              onTap: () {
                Get.to(const TermsValuesScreen());
              },
            ),
            const Spacer(),
            Center(
              child: TextButton(
                onPressed: () {
                  // Handle delete account logic here
                },
                child: Text(
                  "Delete Account",
                  style: TextStyle(
                    color: CustomTheme.cherryRed,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
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
        title: Text(
          title,
          style: Get.textTheme.headlineLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        onTap: onTap,
        trailing: const Icon(Icons.arrow_forward_ios_rounded),
      ),
    );
  }
}
