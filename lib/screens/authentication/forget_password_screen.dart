import 'package:aio_sport/constants/constants.dart';
import 'package:aio_sport/controllers/auth_controller.dart';
import 'package:aio_sport/controllers/profile_controller.dart';
import 'package:aio_sport/widgets/input_field_widget.dart';
import 'package:aio_sport/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final emailC = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final profileController = Get.find<ProfileController>();

  @override
  void initState() {
    profileController.signout();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background.jpg'),
              fit: BoxFit.cover)),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: LayoutBuilder(builder: (context, constraints) {
          return GetX<AuthController>(
            builder: (controller) {
              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 30.0),
                          GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: const Icon(
                                Icons.arrow_back_outlined,
                                size: 26,
                              )),
                          const SizedBox(height: 30.0),
                          Container(
                              height: 80,
                              width: 80,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xffF7F9FA)),
                              child:
                                  Image.asset('assets/icons/lock_purple.png')),
                          const SizedBox(height: 12.0),
                          Text("Forgot Password",
                              style: Get.textTheme.displayLarge),
                          const SizedBox(height: 4.0),
                          Text(
                              "Enter your registered email to reset password.",
                              style: Get.textTheme.labelLarge),
                          const SizedBox(height: 30.0),
                          Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InputFieldWidget(
                                  textEditingController: emailC,
                                  label: "Email",
                                  inputAction: TextInputAction.next,
                                  capitalization: TextCapitalization.none,
                                  inputType: TextInputType.emailAddress,
                                  leadingIcon:
                                      Image.asset("assets/icons/sms.png"),
                                  validate: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "invalid email address";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16.0),
                              ],
                            ),
                          ),
                          const SizedBox(height: 50.0),
                          MyButton(
                            text: "Get OTP",
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                controller.loading.value = true;
                                final responseModel = await controller
                                    .authService
                                    .forgotPassword(email: emailC.text);
                                controller.loading.value = false;
                                if (responseModel != null) {
                                  Constants.showSnackbar(
                                      "Success", responseModel.message);
                                  Get.back();
                                }
                              }
                            },
                            height: constraints.maxHeight * 0.06,
                          ),
                          SizedBox(height: constraints.maxHeight * 0.05),
                        ],
                      ),
                    ),
                  ),
                  controller.loading.value
                      ? Container(
                          color: Colors.white54,
                          width: constraints.maxWidth,
                          height: constraints.maxHeight,
                          child: const Center(
                              child: CircularProgressIndicator()),
                        )
                      : const SizedBox(),
                ],
              );
            },
          );
        }),
      ),
    ));
  }
}
