import 'package:aio_sport/controllers/profile_controller.dart';
import 'package:aio_sport/models/venue_notifications_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:scaled_size/scaled_size.dart';

import '../../themes/custom_theme.dart';
import '../../widgets/venue_notification_cancelled_widget.dart';
import '../../widgets/venue_notification_re_schedule_widget.dart';
import '../../widgets/app_bar_widget.dart';
import '../../widgets/venue_notification_booking_widget.dart';

class VenueNotificationScreen extends StatefulWidget {
  const VenueNotificationScreen({super.key});

  @override
  State<VenueNotificationScreen> createState() => _VenueNotificationScreenState();
}

class _VenueNotificationScreenState extends State<VenueNotificationScreen> {
  final profileController = Get.find<ProfileController>();
  VenueNotificationsResponse? venueNotifications;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var response = await profileController.venueService.getVenueNotifications();
      venueNotifications = response;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar:
            // PreferredSize(
            //   preferredSize: Size.fromHeight(10.vh + 100),
            //   // preferredSize:Size(double.infinity, 600),
            //   child:
            //   AppbarWidget(
            //     title: "Notification",
            //     leading: IconButton(
            //         style: ButtonStyle(backgroundColor:  MaterialStateProperty.all(Color(0xff303345)),shape: MaterialStateProperty.all(CircleBorder()), ),
            //         onPressed: () {
            //           Get.back();
            //         }, icon: const Icon(Icons.arrow_back,color: Colors.white,)),
            //     bottomWidget: PreferredSize(
            //       // preferredSize: const Size.fromHeight(48),
            //       preferredSize: Size.fromHeight(screenHeight * 0.6),
            //       child: TabBar(
            //         padding: EdgeInsets.all(10),
            //         indicatorSize: TabBarIndicatorSize.tab,
            //         labelStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
            //         dividerColor: Colors.transparent,
            //         isScrollable: true,
            //         indicator: BoxDecoration(
            //           color: Colors.blue,
            //           borderRadius: BorderRadius.circular(30),
            //         ),
            //         labelColor: Colors.white,
            //         // unselectedLabelColor: Colors.grey,
            //         unselectedLabelStyle: TextStyle(color: Colors.grey,decorationColor: Color(0xff303345),),
            //         tabs: [
            //           Tab(text: "Booking (2)"),
            //           Tab(text: "Cancelled (2)"),
            //           Tab(text: "Re-schedule (2)"),
            //         ]
            //       ),
            //     ),
            //   ),
            // ),
            AppBar(
          // leading: IconButton(
          //           style: ButtonStyle(backgroundColor:  MaterialStateProperty.all(Color(0xff303345)),shape: MaterialStateProperty.all(CircleBorder()), ),
          //           onPressed: () {
          //             Get.back();
          //           }, icon: const Icon(Icons.arrow_back,color: Colors.white,)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(13.br),
            ),
          ),
          title: Text(
            "Notification",
            style: TextStyle(color: Color(0xffEBECF0)),
          ),
          backgroundColor: Color(0xff15192C),
          bottom: TabBar(
              padding: EdgeInsets.all(10),
              indicatorSize: TabBarIndicatorSize.tab,
              labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              dividerColor: Colors.transparent,
              isScrollable: true,
              indicator: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(30),
              ),
              labelColor: Colors.white,
              // unselectedLabelColor: Colors.grey,
              unselectedLabelStyle: TextStyle(
                color: Colors.grey,
                decorationColor: Color(0xff303345),
              ),
              tabs: [
                Tab(text: "Booking"),
                Tab(text: "Cancelled"),
                Tab(text: "Re-schedule"),
              ]),
        ),
        body: TabBarView(
          children: [
            VenueNotificationBookingWidget(),
            VenueNotificationCancelledWidget(),
            VenueNotificationRe_scheduleWidget(),
          ],
        ),
      ),
    );
  }
}
