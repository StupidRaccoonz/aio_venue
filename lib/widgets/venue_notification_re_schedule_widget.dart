import 'package:flutter/material.dart';

class VenueNotificationRe_scheduleWidget extends StatefulWidget {
  const VenueNotificationRe_scheduleWidget({super.key});

  @override
  State<VenueNotificationRe_scheduleWidget> createState() => _VenueNotificationRe_scheduleWidgetState();
}

class _VenueNotificationRe_scheduleWidgetState extends State<VenueNotificationRe_scheduleWidget> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Today",
                    style: TextStyle(color: Color(0xff252A35)),
                  ),
                ),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(50)),
              ),
              SizedBox(height: 10),
              SizedBox(width: double.infinity, child: Center(child: Text("No Notifications")))
              // Expanded(
              //   child: Container(
              //     decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(20),border: Border.all(color: Color(0xffE9E8EB))),
              //     child: Padding(
              //       padding: EdgeInsets.all(12.0),
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Text("Booking Re-schedule",style: TextStyle(fontSize: 25,color: Color(0xff15192C)),),
              //           SizedBox(height: 8),
              //           RichText(
              //             text: TextSpan(
              //               children: [
              //                 TextSpan(text: 'Your booking for ',style: TextStyle(color: Color(0xff6E6F73),fontSize: 16)),
              //                 TextSpan(text: 'Mr.Jaze ',style: TextStyle(fontSize: 16,color: Color(0xff15192C))),
              //                 TextSpan(text: 'is reschedule, on date ',style: TextStyle(color: Color(0xff6E6F73),fontSize: 16)),
              //                 TextSpan(text: '30 November 2023 ',style: TextStyle(fontSize: 16,color: Color(0xff15192C))),
              //                 TextSpan(text: ', please see the other details on booking page',style: TextStyle(color: Color(0xff6E6F73),fontSize: 16)),
              //               ],
              //             ),
              //           ),
              //           SizedBox(height: 10),
              //           Container(
              //             child: Padding(
              //               padding: const EdgeInsets.all(8.0),
              //               child: Text("Details",style: TextStyle(color: Color(0xff5640FB)),),
              //             ),decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),border: Border.all(color:Color(0xff5640FB),)),
              //           ),
              //           SizedBox(height: 10),
              //           Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //               SizedBox(width: 10),
              //               Text('3:15 PM',
              //                   style: TextStyle(color: Color(0xff6E6F73),fontSize: 16)
              //               ),
              //             ],
              //           ),
              //           SizedBox(height: 5),
              //           Divider(color: Color(0xffE9E8EB)),
              //           Text("Booking Re-schedule",style: TextStyle(fontSize: 25,color: Color(0xff15192C)),),
              //           SizedBox(height: 8),
              //           RichText(
              //             text: TextSpan(
              //               children: [
              //                 TextSpan(text: 'You booking for ',style: TextStyle(color: Color(0xff6E6F73),fontSize: 16)),
              //                 TextSpan(text: 'Mr.Kooper ',style: TextStyle(fontSize: 16,color: Color(0xff15192C))),
              //                 TextSpan(text: 'on date ',style: TextStyle(color: Color(0xff6E6F73),fontSize: 16)),
              //                 TextSpan(text: '213 November 2023 ',style: TextStyle(fontSize: 16,color: Color(0xff15192C))),
              //                 TextSpan(text: ', please see the other details on booking page',style: TextStyle(color: Color(0xff6E6F73),fontSize: 16)),
              //               ],
              //             ),
              //           ),
              //           SizedBox(height: 10),
              //           Container(
              //             child: Padding(
              //               padding: const EdgeInsets.all(8.0),
              //               child: Text("Details",style: TextStyle(color: Color(0xff5640FB)),),
              //             ),decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),border: Border.all(color:Color(0xff5640FB),)),
              //           ),
              //           SizedBox(height: 10),
              //           Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //               SizedBox(width: 10),
              //               Text('2:27 PM',
              //                   style: TextStyle(color: Color(0xff6E6F73),fontSize: 16)
              //               ),
              //             ],
              //           ),
              //           SizedBox(height: 5),
              //           Divider(color: Color(0xffE9E8EB)),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        );
      },
    );
  }
}
