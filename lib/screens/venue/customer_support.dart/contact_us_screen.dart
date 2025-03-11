import 'package:aio_sport/screens/venue/customer_support.dart/report_problem_screen.dart';
import 'package:aio_sport/screens/venue/settings/change_password_screen.dart';
import 'package:aio_sport/screens/venue/settings/privacy_policy_screen.dart';
import 'package:aio_sport/screens/venue/settings/terms_values_screen.dart';
import 'package:aio_sport/themes/custom_theme.dart';
import 'package:aio_sport/widgets/app_bar_widget.dart';
import 'package:aio_sport/widgets/my_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scaled_size/scaled_size.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

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
        child: Container(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "How may I assist you?",
                  style: TextStyle(fontSize: screenHeight * 0.03, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  ",tell me how can I help you?",
                ),
                SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  onTap: () async {
                    final Uri phoneUri = Uri.parse("https://wa.me/+96894161710"); // Replace with desired phone number
                    if (await canLaunchUrl(phoneUri)) {
                      await launchUrl(phoneUri, mode: LaunchMode.externalApplication);
                    } else {
                      throw 'Could not launch $phoneUri';
                    }
                  },
                  child: Container(
                    width: MediaQuery.sizeOf(context).width * 0.7,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: CustomTheme.grey.withOpacity(0.2)),
                    ),
                    child: Center(
                        child: Text(
                      "Connect on WhatsApp",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
              ],
            ),
          ),
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
