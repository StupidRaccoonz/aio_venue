import 'package:aio_sport/constants/constants.dart';
import 'package:aio_sport/controllers/profile_controller.dart';
import 'package:aio_sport/controllers/veneue_manager_controller.dart';
import 'package:aio_sport/screens/authentication/login_screen.dart';
import 'package:aio_sport/screens/venue/customer_support.dart/support_screen.dart';
import 'package:aio_sport/screens/venue/grounds_screen.dart';
import 'package:aio_sport/screens/venue/my_photos_screen.dart';
import 'package:aio_sport/screens/venue/settings/settings_screen.dart';
import 'package:aio_sport/screens/venue/show_venue_details.dart';
import 'package:aio_sport/screens/venue/venue_manage_screen.dart';
import 'package:aio_sport/services/server_urls.dart';
import 'package:aio_sport/themes/custom_theme.dart';
import 'package:aio_sport/widgets/app_bar_widget.dart';
import 'package:aio_sport/widgets/image_widget.dart';
import 'package:aio_sport/widgets/my_text_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scaled_size/scaled_size.dart';

import 'pause_ground_screen.dart';
import 'venue_list_bottombar.dart';

class VenueProfileScreen extends StatefulWidget {
  const VenueProfileScreen({super.key});

  @override
  State<VenueProfileScreen> createState() => _VenueProfileScreenState();
}

class _VenueProfileScreenState extends State<VenueProfileScreen> {
  final profileController = Get.find<ProfileController>();
  final manager = Get.find<VenueManagerController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Constants.backgroundDecoration,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
            preferredSize: Size(double.maxFinite, 10.vh),
            child: AppbarWidget(
              title: "Profile",
              //  leading: const SizedBox(),
              actionIcon: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: IconButton(
                  onPressed: () {
                    profileController.signout();
                    Get.to(LoginScreen());
                    setState(() {});
                  },
                  icon: Image.asset("assets/icons/logout.png", height: 45.0),
                  padding: const EdgeInsets.all(8.0),
                ),
              ),
            )),
        body: LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            child: Obx(() {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20.0),
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(constraints.maxHeight * 0.15),
                      child: ImageWidget(
                        imageurl:
                            "${ServerUrls.mediaUrl}venue/${profileController.currentVenue.value?.data?.venue.profilePicture}",
                        height: constraints.maxHeight * 0.2,
                        width: constraints.maxHeight * 0.2,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Center(
                      child: Text(profileController.currentVenue.value?.data?.venue.name ?? "N/A",
                          style: Get.textTheme.displayLarge)),
                  const SizedBox(height: 8.0),
                  Center(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      profileController.currentVenue.value?.data?.venue.address ?? "N/A",
                      style: Get.textTheme.displaySmall,
                      textAlign: TextAlign.center,
                    ),
                  )),
                  const SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        MyTextButton(
                          text: "Pause grounds",
                          onPressed: () => Get.to(() => const PauseGroundScreen()),
                          borderColor: CustomTheme.borderColor,
                          textColor: CustomTheme.cherryRed,
                          textStyle: Get.textTheme.headlineLarge!.copyWith(color: CustomTheme.cherryRed),
                          height: constraints.maxHeight * 0.07,
                          width: constraints.maxWidth * 0.42,
                        ),
                        MyTextButton(
                          text: "Switch venue",
                          onPressed: () => Get.bottomSheet(const VenueListBottomSheet()),
                          borderColor: CustomTheme.iconColor,
                          textColor: CustomTheme.iconColor,
                          textStyle: Get.textTheme.headlineLarge!.copyWith(color: CustomTheme.iconColor),
                          height: constraints.maxHeight * 0.07,
                          width: constraints.maxWidth * 0.42,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Material(
                      elevation: 1.0,
                      borderRadius: BorderRadius.circular(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            title: Text("Venue details",
                                style: Get.textTheme.headlineLarge!.copyWith(fontWeight: FontWeight.w500)),
                            onTap: () => Get.to(() => const ShowVenueDetailsScreen()),
                            trailing: const Icon(Icons.arrow_forward_ios_rounded),
                          ),
                          Divider(color: CustomTheme.borderColor, thickness: 2.0),
                          ListTile(
                            title: Text("Manage venue",
                                style: Get.textTheme.headlineLarge!.copyWith(fontWeight: FontWeight.w500)),
                            onTap: () => Get.to(() => const VenuemanageScreen()),
                            trailing: const Icon(Icons.arrow_forward_ios_rounded),
                          ),
                          Divider(color: CustomTheme.borderColor, thickness: 2.0),
                          ListTile(
                            title: Text("Manage ground",
                                style: Get.textTheme.headlineLarge!.copyWith(fontWeight: FontWeight.w500)),
                            onTap: () => Get.to(() => const GroundsScreen()),
                            trailing: const Icon(Icons.arrow_forward_ios_rounded),
                          ),
                          Divider(color: CustomTheme.borderColor, thickness: 2.0),
                          ListTile(
                            title: Text("My photos",
                                style: Get.textTheme.headlineLarge!.copyWith(fontWeight: FontWeight.w500)),
                            onTap: () {
                              Get.to(MyPhotosScreen());
                            },
                            trailing: const Icon(Icons.arrow_forward_ios_rounded),
                          ),
                          Divider(color: CustomTheme.borderColor, thickness: 2.0),
                          ListTile(
                            title: Text("Customer support",
                                style: Get.textTheme.headlineLarge!.copyWith(fontWeight: FontWeight.w500)),
                            onTap: () {
                              Get.to(SupportScreen());
                            },
                            trailing: const Icon(Icons.arrow_forward_ios_rounded),
                          ),
                          Divider(color: CustomTheme.borderColor, thickness: 2.0),
                          ListTile(
                            title: Text("Settings",
                                style: Get.textTheme.headlineLarge!.copyWith(fontWeight: FontWeight.w500)),
                            onTap: () {
                              Get.to(SettingScreen());
                            },
                            trailing: const Icon(Icons.arrow_forward_ios_rounded),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: constraints.maxHeight * 0.1),
                ],
              );
            }),
          );
        }),
      ),
    );
  }
}
