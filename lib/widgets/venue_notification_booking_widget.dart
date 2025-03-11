// import 'package:flutter/material.dart';
// class VenueNotificationBookingWidget extends StatefulWidget {
//   const VenueNotificationBookingWidget({super.key});
//
//   @override
//   State<VenueNotificationBookingWidget> createState() => _VenueNotificationBookingWidgetState();
// }
//
// class _VenueNotificationBookingWidgetState extends State<VenueNotificationBookingWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(12.0),
//       child: Column(
//         children: [
//           Container(
//             child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text("Today",style: TextStyle(color: Color(0xff252A35)),),
//           ),
//             decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(50)),
//           ),
//           SizedBox(height: 10),
//           Expanded(
//             child: Container(
//               decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(20),border: Border.all(color: Color(0xffE9E8EB))),
//               child: Padding(
//                 padding: EdgeInsets.all(12.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("Booking confirmed",style: TextStyle(fontSize: 25,color: Color(0xff15192C)),),
//                     SizedBox(height: MediaQuery.of(context).size.height * 0.009),
//                     RichText(
//                         text: TextSpan(
//                             children: [
//                               TextSpan(text: 'You have received a new booking from ',style: TextStyle(color: Color(0xff6E6F73),fontSize: 16)),
//                               TextSpan(text: 'Mr.Jaze ',style: TextStyle(fontSize: 16,color: Color(0xff15192C))),
//                               TextSpan(text: 'on date ',style: TextStyle(color: Color(0xff6E6F73),fontSize: 16)),
//                               TextSpan(text: '20 November 2023 ',style: TextStyle(fontSize: 16,color: Color(0xff15192C))),
//                               TextSpan(text: ', please see the other details on booking page',style: TextStyle(color: Color(0xff6E6F73),fontSize: 16)),
//                             ],
//                         ),
//                     ),
//                     SizedBox(height: MediaQuery.of(context).size.height * 0.009),
//                     Container(
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text("Details",style: TextStyle(color: Color(0xff5640FB)),),
//                       ),decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),border: Border.all(color:Color(0xff5640FB),)),
//                     ),
//                     SizedBox(height: MediaQuery.of(context).size.height * 0.009),
//                     Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         SizedBox(width: 10),
//                         Text('2:45 PM',
//                             style: TextStyle(color: Color(0xff6E6F73),fontSize: 16)
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: MediaQuery.of(context).size.height * 0.009),
//                     Divider(color: Color(0xffE9E8EB)),
//                     Text("Booking confirmed",style: TextStyle(fontSize: 25,color: Color(0xff15192C)),),
//                     SizedBox(height: MediaQuery.of(context).size.height * 0.009),
//                     RichText(
//                       text: TextSpan(
//                         children: [
//                           TextSpan(text: 'You have received a new booking from ',style: TextStyle(color: Color(0xff6E6F73),fontSize: 16)),
//                           TextSpan(text: 'Mr.Kooper ',style: TextStyle(fontSize: 16,color: Color(0xff15192C))),
//                           TextSpan(text: 'on date ',style: TextStyle(color: Color(0xff6E6F73),fontSize: 16)),
//                           TextSpan(text: '21 November 2023 ',style: TextStyle(fontSize: 16,color: Color(0xff15192C))),
//                           TextSpan(text: ', please see the other details on booking page',style: TextStyle(color: Color(0xff6E6F73),fontSize: 16)),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: MediaQuery.of(context).size.height * 0.009),
//                     Container(
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text("Details",style: TextStyle(color: Color(0xff5640FB)),),
//                       ),decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),border: Border.all(color:Color(0xff5640FB),)),
//                     ),
//                     SizedBox(height: MediaQuery.of(context).size.height * 0.009),
//                     Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         SizedBox(width: 10),
//                         Text('2:27 PM',
//                             style: TextStyle(color: Color(0xff6E6F73),fontSize: 16)
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: MediaQuery.of(context).size.height * 0.009),
//                     Divider(color: Color(0xffE9E8EB)),
//                     Text("Booking confirmed",style: TextStyle(fontSize: 25,color: Color(0xff15192C)),),
//                     SizedBox(height: MediaQuery.of(context).size.height * 0.009),
//                     RichText(
//                       text: TextSpan(
//                         children: [
//                           TextSpan(text: 'You have received a new booking from ',style: TextStyle(color: Color(0xff6E6F73),fontSize: 16)),
//                           TextSpan(text: 'Mr.Kooper ',style: TextStyle(fontSize: 16,color: Color(0xff15192C))),
//                           TextSpan(text: 'on date ',style: TextStyle(color: Color(0xff6E6F73),fontSize: 16)),
//                           TextSpan(text: '21 November 2023 ',style: TextStyle(fontSize: 16,color: Color(0xff15192C))),
//                           TextSpan(text: ', please see the other details on booking page',style: TextStyle(color: Color(0xff6E6F73),fontSize: 16)),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: MediaQuery.of(context).size.height * 0.009),
//                     Container(
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text("Details",style: TextStyle(color: Color(0xff5640FB)),),
//                       ),decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),border: Border.all(color:Color(0xff5640FB),)),
//                     ),
//                     SizedBox(height: MediaQuery.of(context).size.height * 0.009),
//                     Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         SizedBox(width: 10),
//                         Text('2:27 PM',
//                             style: TextStyle(color: Color(0xff6E6F73),fontSize: 16)
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: MediaQuery.of(context).size.height * 0.009),
//                     Divider(color: Color(0xffE9E8EB)),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:aio_sport/controllers/profile_controller.dart';
import 'package:aio_sport/models/venue_notifications_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VenueNotificationBookingWidget extends StatefulWidget {
  const VenueNotificationBookingWidget({super.key});

  @override
  State<VenueNotificationBookingWidget> createState() => _VenueNotificationBookingWidgetState();
}

class _VenueNotificationBookingWidgetState extends State<VenueNotificationBookingWidget> {
  final profileController = Get.find<ProfileController>();
  VenueNotificationsResponse? venueNotifications;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var response = await profileController.venueService.getVenueNotifications();
      venueNotifications = response;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
            ),
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Today",
              style: TextStyle(
                color: const Color(0xff252A35),
                fontSize: screenWidth * 0.045, // Responsive font size
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.02), // Responsive spacing
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xffE9E8EB)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: (venueNotifications == null || venueNotifications!.data.data.isEmpty)
                    ? SizedBox(width: double.infinity, child: Text("No Notifications"))
                    : ListView.builder(
                        itemCount: venueNotifications!.data.data.length,
                        itemBuilder: (context, index) => BookingCard(
                          venueNotificationsResponse: venueNotifications!,
                          index: index,
                          screenWidth: screenWidth,
                          screenHeight: screenHeight,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BookingCard extends StatelessWidget {
  final VenueNotificationsResponse venueNotificationsResponse;

  final double screenWidth;
  final double screenHeight;
  final int index;

  const BookingCard({
    required this.screenWidth,
    required this.screenHeight,
    required this.venueNotificationsResponse,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${venueNotificationsResponse.data.data[index].title}",
          style: TextStyle(
            fontSize: screenWidth * 0.06,
            color: const Color(0xff15192C),
          ),
        ),
        SizedBox(height: screenHeight * 0.01),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '${venueNotificationsResponse.data.data[index].body}',
                style: TextStyle(
                  color: const Color(0xff6E6F73),
                  fontSize: screenWidth * 0.04,
                ),
              ),
              // TextSpan(
              //   text: "name",
              //   style: TextStyle(
              //     fontSize: screenWidth * 0.04,
              //     color: const Color(0xff15192C),
              //   ),
              // ),
              // TextSpan(
              //   text: ' on date ',
              //   style: TextStyle(
              //     color: const Color(0xff6E6F73),
              //     fontSize: screenWidth * 0.04,
              //   ),
              // ),
              // TextSpan(
              //   text: "date",
              //   style: TextStyle(
              //     fontSize: screenWidth * 0.04,
              //     color: const Color(0xff15192C),
              //   ),
              // ),
              // TextSpan(
              //   text: ', please see the other details on the booking page.',
              //   style: TextStyle(
              //     color: const Color(0xff6E6F73),
              //     fontSize: screenWidth * 0.04,
              //   ),
              // ),
            ],
          ),
        ),
        SizedBox(height: screenHeight * 0.01),
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: const Color(0xff5640FB)),
          ),
          child: Text(
            "Details",
            style: TextStyle(
              color: const Color(0xff5640FB),
              fontSize: screenWidth * 0.04,
            ),
          ),
        ),
        SizedBox(height: screenHeight * 0.01),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: screenWidth * 0.02),
            Text(
              "${venueNotificationsResponse.data.data[index].date}".split(" ")[1].substring(0, 5),
              style: TextStyle(
                color: const Color(0xff6E6F73),
                fontSize: screenWidth * 0.04,
              ),
            ),
          ],
        ),
        SizedBox(height: screenHeight * 0.01),
        const Divider(color: Color(0xffE9E8EB)),
      ],
    );
  }
}
