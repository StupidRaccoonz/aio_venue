import 'package:aio_sport/controllers/profile_controller.dart';
import 'package:aio_sport/screens/venue/venue_home_screen.dart';
import 'package:aio_sport/services/server_urls.dart';
import 'package:aio_sport/themes/custom_theme.dart';
import 'package:aio_sport/widgets/image_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'venue_activity_screen.dart';
import 'venue_bookings_screen.dart';
import 'venue_profile_screen.dart';

class VenueMainPage extends StatefulWidget {
  const VenueMainPage({super.key});

  @override
  State<VenueMainPage> createState() => _VenueMainPageState();
}

class _VenueMainPageState extends State<VenueMainPage> {
  final pageController = PageController();
  final profile = Get.find<ProfileController>();
  
  int currentIndex = 0;

  @override
  void initState() {
     WidgetsBinding.instance.addPostFrameCallback((_) {
     
  
    profile.getVenuesListData();
    profile.getVenueEarning();
    profile.getVenueAnalytics();
    profile.getVenueBookings();    
      });
    super.initState();
  }

  void _navigateToActivityScreen() {
    setState(() {
      currentIndex = 2;
    });
    pageController.animateToPage(
      2,
      duration: const Duration(milliseconds: 300),
      curve: Curves.fastLinearToSlowEaseIn,
    );
  }

  void _navigateToBookingScreen() {
    setState(() {
      currentIndex = 1;
    });
    pageController.animateToPage(
      1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.fastLinearToSlowEaseIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            VenueHomeScreen(onNavigateToActivityScreen: _navigateToActivityScreen, onNavigateToBookingScreen: _navigateToBookingScreen,),
            VenueBookingsScreen(),
            VenueActivityScreen(),
            VenueProfileScreen(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            if (value != currentIndex) {
              setState(() {
                currentIndex = value;
              });
              pageController.animateToPage(value, duration: const Duration(milliseconds: 300), curve: Curves.fastLinearToSlowEaseIn);
            }
          },
          backgroundColor: Colors.white,
          currentIndex: currentIndex,
          iconSize: 30,
          selectedItemColor: CustomTheme.iconColor,
          unselectedItemColor: CustomTheme.grey,
          selectedLabelStyle: Get.textTheme.headlineSmall!.copyWith(color: CustomTheme.iconColor),
          unselectedLabelStyle: Get.textTheme.headlineSmall!.copyWith(color: CustomTheme.grey),
          showUnselectedLabels: true,
          items: [
            BottomNavigationBarItem(
              icon: Image.asset("assets/icons/home.png", width: 25.0),
              label: "Home",
              activeIcon: Image.asset("assets/icons/home.png", width: 25.0, color: CustomTheme.appColorSecondary),
            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/icons/bookings.png', height: 25.0),
              activeIcon: Image.asset('assets/icons/bookings.png', height: 25.0, color: CustomTheme.appColorSecondary),
              label: "Bookings",
            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/icons/activity.png', height: 25.0),
              activeIcon: Image.asset('assets/icons/activity.png', height: 25.0, color: CustomTheme.appColorSecondary),
              label: "Activities",
            ),
            BottomNavigationBarItem(
              icon: ImageWidget(
                imageurl: '${ServerUrls.mediaUrl}venue/${profile.currentVenue.value?.data?.venue.profilePicture}',
                height: 30.0,
                width: 30,
                radius: 20.0,
                fit: BoxFit.cover,
              ),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
