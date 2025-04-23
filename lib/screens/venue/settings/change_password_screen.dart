import 'package:aio_sport/controllers/profile_controller.dart';
import 'package:aio_sport/themes/custom_theme.dart';
import 'package:aio_sport/widgets/app_bar_widget.dart';
import 'package:aio_sport/widgets/input_field_widget.dart';
import 'package:aio_sport/widgets/my_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scaled_size/scaled_size.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileController = Get.find<ProfileController>();

    final oldPasswordC = TextEditingController();
    final passwordC = TextEditingController();
    final confirmPasswordC = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.maxFinite, 10.vh),
        child: AppbarWidget(
          title: "Change Password",
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
                    "Set New Password",
                    style: TextStyle(
                        fontSize: screenHeight * 0.03,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: screenWidth * 0.7,
                    child: Text(
                      "Your new password must be different from previous password.",
                      style: TextStyle(
                          fontSize: screenHeight * 0.02,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 16.0, bottom: 12, left: 16, right: 16),
                    child: InputFieldWidget(
                      textEditingController: oldPasswordC,
                      label: "Old Password",
                      capitalization: TextCapitalization.none,
                      obsecureText: true,
                      leadingIcon: Image.asset("assets/icons/lock.png"),
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return "Old password field is required";
                        }

                        return null;
                      },
                      trailingIcon: const Icon(Icons.remove_red_eye_outlined),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 12.0, left: 16, right: 16),
                    child: InputFieldWidget(
                      textEditingController: passwordC,
                      label: "New Password",
                      capitalization: TextCapitalization.none,
                      obsecureText: true,
                      leadingIcon: Image.asset("assets/icons/lock.png"),
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return "New password field is required";
                        }

                        return null;
                      },
                      trailingIcon: const Icon(Icons.remove_red_eye_outlined),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 12.0, left: 16, right: 16),
                    child: InputFieldWidget(
                      textEditingController: confirmPasswordC,
                      label: "Confrim New Password",
                      capitalization: TextCapitalization.none,
                      obsecureText: true,
                      leadingIcon: Image.asset("assets/icons/lock.png"),
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return "Confirm new password field is required";
                        } else if (confirmPasswordC.text != passwordC.text) {
                          return "password mismatched";
                        }

                        return null;
                      },
                      trailingIcon: const Icon(Icons.remove_red_eye_outlined),
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
                    profileController.changePassword(
                        oldPassword: oldPasswordC.text,
                        newPassword: passwordC.text,
                        confirmPassword: confirmPasswordC.text);
                  }
                },
                text: "Change Password",
                width: double.infinity,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
