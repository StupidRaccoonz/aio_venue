import 'package:aio_sport/constants/constants.dart';
import 'package:aio_sport/controllers/auth_controller.dart';
import 'package:aio_sport/controllers/home_controller.dart';
import 'package:aio_sport/controllers/profile_controller.dart';
import 'package:aio_sport/screens/authentication/login_screen.dart';
import 'package:aio_sport/screens/authentication/wrapper.dart';
import 'package:aio_sport/screens/common/congratulation_screen.dart';
import 'package:aio_sport/themes/custom_theme.dart';
import 'package:aio_sport/widgets/input_field_widget.dart';
import 'package:aio_sport/widgets/my_button.dart';
import 'package:aio_sport/widgets/role_selection_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scaled_size/scaled_size.dart';

import '../venue/venue_details.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final emailC = TextEditingController();
  final phoneC = TextEditingController();
  final passwordC = TextEditingController();
  final confirmPasswordC = TextEditingController();
  final homeController = Get.find<HomeController>();
  final profileController = Get.find<ProfileController>();
  Rx<bool> agreeToAge = false.obs;
  Rx<bool> agreeToTerms = false.obs;
  final _formKey = GlobalKey<FormState>();
  Rx<int> roleType = 3.obs;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/images/background.jpg'), fit: BoxFit.cover)),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: LayoutBuilder(builder: (context, constraints) {
            return GetX<AuthController>(builder: (controller) {
              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Image.asset('assets/icons/logo.png', width: 20.vw),
                          ),
                          const SizedBox(height: 20.0),
                          Row(children: [
                            IconButton(
                                onPressed: () => Get.to(() => LoginScreen()),
                                icon: Icon(Icons.arrow_back_rounded, color: CustomTheme.appColor)),
                            Text("Create Account!", style: Get.textTheme.displayLarge),
                          ]),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 45.0),
                            child: Text("Setup your account!", style: Get.textTheme.labelLarge),
                          ),
                          const SizedBox(height: 20.0),
                          // Text("Select your role!", style: Get.textTheme.labelLarge),
                          // const SizedBox(height: 8.0),
                          // RoleSelectionWidget(roleTypeSelected: (value) => roleType.value = value),
                          // const SizedBox(height: 16.0),
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
                                  leadingIcon: Image.asset("assets/icons/sms.png"),
                                  // onChange: (value) => emailC.text = value,
                                  validate: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "invalid email address";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 12.0),
                                InputFieldWidget(
                                  textEditingController: phoneC,
                                  label: "Mobile Number",
                                  inputAction: TextInputAction.next,
                                  prefixText: "+986",
                                  maxlength: 8,
                                  inputType: TextInputType.phone,
                                  leadingIcon: const Icon(Icons.phone_outlined),
                                  // onChange: (value) => phoneC.text = value,
                                  validate: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "invalid email address";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 12.0),
                                InputFieldWidget(
                                  textEditingController: passwordC,
                                  label: "Password",
                                  inputAction: TextInputAction.next,
                                  capitalization: TextCapitalization.none,
                                  obsecureText: true,
                                  leadingIcon: Image.asset("assets/icons/lock.png"),
                                  // onChange: (value) => passwordC.text = value,
                                  validate: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "password field is required";
                                    }

                                    return null;
                                  },
                                  trailingIcon: const Icon(Icons.remove_red_eye),
                                ),
                                const SizedBox(height: 12.0),
                                InputFieldWidget(
                                  textEditingController: confirmPasswordC,
                                  label: "Confirm Password",
                                  obsecureText: true,
                                  inputAction: TextInputAction.done,
                                  capitalization: TextCapitalization.none,
                                  leadingIcon: Image.asset("assets/icons/lock.png"),
                                  // onChange: (value) => confirmPasswordC.text = value,
                                  validate: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "password field is required";
                                    }
                                    if (passwordC.text != confirmPasswordC.text) {
                                      return "password mismatched";
                                    }

                                    return null;
                                  },
                                  trailingIcon: const Icon(Icons.remove_red_eye),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          roleType.value != 2
                              ? Row(
                                  children: [
                                    Checkbox(
                                        value: agreeToAge.value,
                                        onChanged: (value) => agreeToAge.value = value ?? false,
                                        activeColor: CustomTheme.iconColor),
                                    Text(
                                      "I certify that I am 18 years of age or older.",
                                      style: Get.textTheme.headlineSmall!
                                          .copyWith(color: CustomTheme.appColor, fontSize: 10.rfs),
                                    ),
                                    // RichText(text: TextSpan(children: [TextSpan(text: "I certify that, ")])),
                                  ],
                                )
                              : const SizedBox(),
                          const SizedBox(height: 20.0),
                          Row(
                            children: [
                              Checkbox(
                                  value: agreeToTerms.value,
                                  onChanged: (value) => agreeToTerms.value = value ?? false,
                                  activeColor: CustomTheme.iconColor),
                              RichText(
                                  text: TextSpan(
                                style:
                                    Get.textTheme.headlineSmall!.copyWith(color: CustomTheme.appColor, fontSize: 9.rfs),
                                children: [
                                  const TextSpan(text: "I agree to the "),
                                  TextSpan(
                                    text: "terms of services",
                                    style: Get.textTheme.headlineSmall!
                                        .copyWith(color: CustomTheme.iconColor, fontSize: 9.rfs),
                                  ),
                                  const TextSpan(text: " and "),
                                  TextSpan(
                                    text: "Privacy policy",
                                    style: Get.textTheme.headlineSmall!
                                        .copyWith(color: CustomTheme.iconColor, fontSize: 9.rfs),
                                  ),
                                ],
                              )),
                            ],
                          ),
                          const SizedBox(height: 30.0),
                          MyButton(
                            text: "Create Account",
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                if (!agreeToTerms.value) {
                                  Constants.showSnackbar("Error", "please agree to the term of services");
                                  return;
                                }
                                controller.loading.value = true;
                                // Navigator.push(context, MaterialPageRoute(builder: (context) => VenueDetails(addAnotherVenue: false,),));
                                try {
                                  final result = await controller.authService.registerAccount(
                                    number: phoneC.text,
                                    // userType: controller.accountType.toLowerCase().trim(),
                                    userType: roleType.value == 2 ? "player" : "venue",
                                    email: emailC.text,
                                    password: passwordC.text,
                                  );

                                  print("${result.toString()}");
                                  print("---> Vivek testing");

                                  if (result != null) {
                                    if (result.httpCode != 200) {
                                      Constants.showSnackbar("Error", result.message);
                                    } else {
                                      final res = await controller.authService
                                          .login(email: emailC.text, password: passwordC.text);

                                      if (res != null) {
                                        getStorage.write(Constants.lastPage, "VenueDetails");
                                        controller.loginResponseModel.value = res;
                                        profileController.loginDataModel.value = res;
                                        profileController.firstTimeLoginCheck();
                                        profileController.isLoggedIn.value = true;
                                        Get.offAll(() => VenueDetails(
                                              addAnotherVenue: false,
                                            ));
                                        // Get.to(CongratulationScreen());
                                      }
                                    }
                                  }
                                } catch (e) {
                                  print(e);
                                  Constants.showSnackbar("Error", "$e");
                                }
                              }
                              controller.loading.value = false;
                            },
                            height: constraints.maxHeight * 0.06,
                          ),
                          SizedBox(height: constraints.maxHeight * 0.07),
                          Center(
                              child: Text("CONTINUE WITH",
                                  textAlign: TextAlign.center, style: Get.textTheme.displaySmall)),
                          SizedBox(height: constraints.maxHeight * 0.02),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/icons/facebook.png",
                                height: constraints.maxHeight * 0.06,
                                width: constraints.maxHeight * 0.06,
                              ),
                              SizedBox(width: constraints.maxWidth * 0.05),
                              Image.asset(
                                "assets/icons/google.png",
                                height: constraints.maxHeight * 0.06,
                                width: constraints.maxHeight * 0.06,
                              ),
                              SizedBox(width: constraints.maxWidth * 0.05),
                              Image.asset(
                                "assets/icons/apple.png",
                                height: constraints.maxHeight * 0.06,
                                width: constraints.maxHeight * 0.06,
                              ),
                            ],
                          ),
                          SizedBox(height: constraints.maxHeight * 0.05),
                          Center(
                              child: Text("Already have an account?",
                                  textAlign: TextAlign.center, style: Get.textTheme.displaySmall)),
                          Center(
                              child: InkWell(
                                  // onTap: () => controller.isLoginPage.value = true,
                                  onTap: () => Get.offAll(() => LoginScreen()),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Login Now",
                                        textAlign: TextAlign.center, style: Get.textTheme.headlineSmall),
                                  ))),
                        ],
                      ),
                    ),
                  ),
                  controller.loading.value
                      ? Container(
                          color: Colors.white54,
                          width: double.maxFinite,
                          height: double.maxFinite,
                          child: const Center(child: CircularProgressIndicator()),
                        )
                      : const SizedBox(),
                ],
              );
            });
          }),
        ),
      ),
    );
  }
}
