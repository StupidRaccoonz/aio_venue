import 'package:aio_sport/constants/constants.dart';
import 'package:aio_sport/controllers/auth_controller.dart';
import 'package:aio_sport/controllers/home_controller.dart';
import 'package:aio_sport/controllers/profile_controller.dart';
import 'package:aio_sport/screens/authentication/signup_screen.dart';
import 'package:aio_sport/screens/authentication/wrapper.dart';
import 'package:aio_sport/widgets/input_field_widget.dart';
import 'package:aio_sport/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scaled_size/scaled_size.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailC = TextEditingController();
  final passwordC = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final profileController = Get.find<ProfileController>();
  final homeController = Get.find<HomeController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      profileController.signout();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/background.jpg'), fit: BoxFit.cover)),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: LayoutBuilder(builder: (context, constraints) {
          return GetX<AuthController>(
            builder: (controller) {
              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 25.0),
                              child: Image.asset('assets/icons/logo.png', width: 25.vw),
                            ),
                          ),
                          const SizedBox(height: 30.0),
                          Text("Welcome Back!", style: Get.textTheme.displayLarge),
                          Text("Access your account!", style: Get.textTheme.labelLarge),
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
                                  leadingIcon: Image.asset("assets/icons/sms.png"),
                                  validate: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "invalid email address";
                                    }

                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16.0),
                                InputFieldWidget(
                                  textEditingController: passwordC,
                                  label: "Password",
                                  capitalization: TextCapitalization.none,
                                  obsecureText: true,
                                  leadingIcon: Image.asset("assets/icons/lock.png"),
                                  validate: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "password field is required";
                                    }

                                    return null;
                                  },
                                  trailingIcon: const Icon(Icons.remove_red_eye),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(onTap: () {}, child: Text("Forgot Password?", style: Get.textTheme.headlineMedium)),
                          ),
                          const SizedBox(height: 30.0),
                          MyButton(
                            text: "LOGIN",
                            onPressed: () async {
                              // Get.to(() => const VenueDetails());
                              if (_formKey.currentState!.validate()) {
                                controller.loading.value = true;
                                final result = await controller.authService.login(email: emailC.text, password: passwordC.text);
                                if (result != null) {
                                  if (result.data == null || result.httpCode != 200) {
                                    print("LOGIN ++++++++++++++++++++++++++++++++++++++++++>");
                                    print("${result.data}&& ${result.httpCode}");
                                    Constants.showSnackbar("Error", result.message);
                                  } else {
                                    controller.loginResponseModel.value = result;
                                    profileController.loginDataModel.value = result;
                                    await profileController.firstTimeLoginCheck();
                                    profileController.isLoggedIn.value = true;
                                    // Get.to(() => const VenueHomeScreen());
                                    // Get.to(() => const VenueMainPage());
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => Wrapper()),
                                    );
                                    setState(() {});
                                  }
                                }
                                print('$result');
                                controller.loading.value = false;
                              }
                            },
                            height: constraints.maxHeight * 0.06,
                          ),
                          SizedBox(height: constraints.maxHeight * 0.05),
                          Center(child: Text("CONTINUE WITH", textAlign: TextAlign.center, style: Get.textTheme.displaySmall)),
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
                              InkWell(
                                onTap: () async {
                                  controller.loading.value = true;
                                  final result = await controller.authService.signInWithGoogle();
                                  if (result != null) {
                                    if (result.data == null || result.httpCode != 200) {
                                      Constants.showSnackbar("Error", result.message);
                                    } else {
                                      controller.loginResponseModel.value = result;
                                      profileController.loginDataModel.value = result;
                                      await profileController.firstTimeLoginCheck();
                                      profileController.isLoggedIn.value = true;
                                    }
                                  }
                                  controller.loading.value = false;
                                },
                                child: Image.asset("assets/icons/google.png", height: constraints.maxHeight * 0.06, width: constraints.maxHeight * 0.06),
                              ),
                              SizedBox(width: constraints.maxWidth * 0.05),
                              Image.asset("assets/icons/apple.png", height: constraints.maxHeight * 0.06, width: constraints.maxHeight * 0.06),
                            ],
                          ),
                          SizedBox(height: constraints.maxHeight * 0.07),
                          Center(child: Text("Don't have an account?", textAlign: TextAlign.center, style: Get.textTheme.displaySmall)),
                          Center(
                              child: InkWell(
                                  // onTap: () => controller.isLoginPage.value = false,
                                  onTap: () => Get.offAll(() => SignupScreen()),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Create Account", textAlign: TextAlign.center, style: Get.textTheme.headlineSmall),
                                  ))),
                        ],
                      ),
                    ),
                  ),
                  controller.loading.value
                      ? Container(
                          color: Colors.white54,
                          width: constraints.maxWidth,
                          height: constraints.maxHeight,
                          child: const Center(child: CircularProgressIndicator()),
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
