import 'package:aio_sport/widgets/venue_activity_rules_&_regulation_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:scaled_size/scaled_size.dart';

import '../../widgets/activity_details_card_widget.dart';
import '../../widgets/app_bar_widget.dart';

class VenueActivityDetailsScreen extends StatefulWidget {
  const VenueActivityDetailsScreen({super.key});

  @override
  State<VenueActivityDetailsScreen> createState() => _VenueActivityDetailsScreenState();
}

class _VenueActivityDetailsScreenState extends State<VenueActivityDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.maxFinite, 10.vh),
        child: AppbarWidget(
            title: "Activity details",
            leading: IconButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xff303345)),
                  shape: MaterialStateProperty.all(CircleBorder()),
                ),
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ))),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 30.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffE9E8EB)),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(0xffE9E8EB)),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
                                  child: Image.asset(
                                    "assets/images/confetti.png",
                                    width: double.maxFinite,
                                    height: constraints.maxWidth * 0.5,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Image.asset(
                                      "assets/images/trophy.png",
                                      height: constraints.maxWidth * 0.25,
                                    ),
                                    Text(
                                      "\$ 500",
                                      style: TextStyle(
                                          color: Color(0xff25A70F), fontWeight: FontWeight.bold, fontSize: 35),
                                    ),
                                    Text("Winning price", style: TextStyle(color: Color(0xff6E6F73))),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(0xffE9E8EB)),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Center(
                                child: Text(
                              "Cancel",
                              style: TextStyle(color: Color(0xffC51B1B), fontWeight: FontWeight.bold, fontSize: 35),
                            )),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffE9E8EB)),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Event can be cancel until 6 Nov 2022",
                        style: TextStyle(color: Color(0xff6E6F73), fontSize: 20.0),
                      ),
                    )),
                  ),
                  SizedBox(height: 25.0),
                  Text(
                    "Activity Details",
                    style: TextStyle(color: Color(0xff15192C), fontSize: 25.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10.0),
                  ActivityDetailsCardWidget(
                    fees: '120',
                    sport: 'Football',
                    teamSize: '8 vs 8',
                    date: '13 November 2023',
                    time: '6:00 PM',
                  ),
                  SizedBox(height: 25.0),
                  Text(
                    "Rules & Regulations",
                    style: TextStyle(color: Color(0xff15192C), fontSize: 25.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10.0),
                  VenueActivityRulesRegulationCardWidget(
                    rules: "Lorem ipsum dolor sit amet, consectetur",
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
