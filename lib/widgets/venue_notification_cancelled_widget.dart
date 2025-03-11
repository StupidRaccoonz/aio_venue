import 'package:flutter/material.dart';

class VenueNotificationCancelledWidget extends StatefulWidget {
  const VenueNotificationCancelledWidget({super.key});

  @override
  State<VenueNotificationCancelledWidget> createState() => _VenueNotificationCancelledWidgetState();
}

class _VenueNotificationCancelledWidgetState extends State<VenueNotificationCancelledWidget> {
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
              //           Text("Cancelled booking",style: TextStyle(fontSize: 25,color: Color(0xff15192C)),),
              //           SizedBox(height: 8),
              //           RichText(
              //             text: TextSpan(
              //               children: [
              //                 TextSpan(text: 'Mr.Jaze ',style: TextStyle(fontSize: 16,color: Color(0xff15192C))),
              //                 TextSpan(text: 'has cancelled booking, on date ',style: TextStyle(color: Color(0xff6E6F73),fontSize: 16)),
              //                 TextSpan(text: '30 November 2023. ',style: TextStyle(fontSize: 16,color: Color(0xff15192C))),
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
              //           Text("Cancelled booking",style: TextStyle(fontSize: 25,color: Color(0xff15192C)),),
              //           SizedBox(height: 8),
              //           RichText(
              //             text: TextSpan(
              //               children: [
              //                 TextSpan(text: 'Mr.Kooper ',style: TextStyle(fontSize: 16,color: Color(0xff15192C))),
              //                 TextSpan(text: 'has cancelled booking, on date ',style: TextStyle(color: Color(0xff6E6F73),fontSize: 16)),
              //                 TextSpan(text: '30 November 2023. ',style: TextStyle(fontSize: 16,color: Color(0xff15192C))),
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
