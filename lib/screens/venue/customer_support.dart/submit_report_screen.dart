import 'package:aio_sport/controllers/profile_controller.dart';
import 'package:aio_sport/themes/custom_theme.dart';
import 'package:aio_sport/widgets/app_bar_widget.dart';
import 'package:aio_sport/widgets/input_field_widget.dart';
import 'package:aio_sport/widgets/my_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scaled_size/scaled_size.dart';

class SubmitReportScreen extends StatelessWidget {
  final String type;
  const SubmitReportScreen({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    final profileController = Get.find<ProfileController>();

    final issueC = TextEditingController();
    final _formKey = GlobalKey<FormState>();
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
        child: Stack(
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    (type == "Others")
                        ? "Let us know what problem you are facing"
                        : "Let us know what problem you are facing while ${type.toLowerCase()}",
                    style: TextStyle(fontSize: screenHeight * 0.03, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0, left: 16, right: 16),
                    child: InputFieldWidget(
                      textEditingController: issueC,
                      label: "Write your issue",
                      capitalization: TextCapitalization.none,
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter issue";
                        }

                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: MyButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    profileController.submitReport(issue: issueC.text, id: "17");
                  }
                },
                text: "Send",
                width: double.infinity,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
