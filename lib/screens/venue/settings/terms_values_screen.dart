import 'package:aio_sport/widgets/app_bar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scaled_size/scaled_size.dart';

class TermsValuesScreen extends StatelessWidget {
  const TermsValuesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.maxFinite, 10.vh),
        child: AppbarWidget(
          title: "Terms of use",
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
            onPressed: () => Get.back(),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Terms of use",
              style: TextStyle(fontSize: screenHeight * 0.03, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  style: TextStyle(fontWeight: FontWeight.w600),
                  "Mobile app terms and conditions, also referred to as app terms of service or app terms of use. \n Explain the rules, requirements, restrictions, and limitations that users must abide by in order to use a mobile application. \n Specifically, they act as a binding contract between you and your users. This contract helps protect the rights of both parties. Business owners and app developers often use the same terms and conditions for both their website. \n Mobile applications in order to keep their terms consistent across all platforms. /nApp terms and conditions help protect the owner's intellectual property. \n Allow them to prohibit unwanted user activity and terminate user accounts that violate their terms."),
            )
          ],
        ),
      ),
    );
  }
}
