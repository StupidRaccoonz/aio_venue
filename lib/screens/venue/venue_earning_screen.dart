import 'dart:developer';

import 'package:aio_sport/models/venue_earning_model.dart';
import 'package:aio_sport/screens/venue/venue_earning_metrics.dart';
import 'package:aio_sport/screens/venue/venue_metrics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controllers/profile_controller.dart';

class VenueEarningScreen extends StatefulWidget {
  const VenueEarningScreen({super.key});

  @override
  State<VenueEarningScreen> createState() => _VenueEarningScreenState();
}

class _VenueEarningScreenState extends State<VenueEarningScreen> {
  final profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    String? convertDate(String dateString) {
      DateTime? datetime = DateTime.tryParse(dateString);
      return datetime == null
          ? null
          : DateFormat('dd MMM yy, hh:mm a').format(datetime!);
    }

    log(profileController.venueEarnings.value.toString());

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) => Obx(
          () => Column(
            children: [
              Container(
                height: screenHeight * 0.242,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Color(0xff15192C),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: screenHeight * 0.05),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey.withOpacity(0.6),
                            child: IconButton(
                                onPressed: () {
                                  Get.back();
                                },
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: Color.fromRGBO(235, 236, 240, 1),
                                )),
                          ),
                          Expanded(
                            child: Center(
                                child: Text('My earnings',
                                    style: TextStyle(
                                        color: Color(0xffEBECF0),
                                        fontSize: screenHeight * 0.03))),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        VenueEarningMetricsScreen(),
                                  ));
                            },
                            icon: Image.asset(
                              'assets/icons/pie_chart.png',
                              height: 40,
                              width: 40,
                            ),
                            color: Color(0xffEBECF0),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.018),
                    Text(
                      'OMR ${profileController.venueEarnings.value?.data?.totalVenueEarning ?? 0}',
                      style: TextStyle(
                          color: Color(0xffEBECF0),
                          fontSize: screenHeight * 0.05,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Text(
                      'Total earning',
                      style: TextStyle(
                          color: Color(0xffEBECF0),
                          fontSize: screenHeight * 0.02),
                    ),
                    // SizedBox(height: screenHeight * 0.025),
                    // GestureDetector(
                    //   onTap: () {
                    //     print("Click Manage bank account");
                    //   },
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       Text('Manage bank account',style: TextStyle(color: Colors.deepOrange,fontSize: screenHeight * 0.02)),
                    //       Icon(Icons.arrow_forward_rounded,color: Colors.deepOrange,size: screenHeight * 0.02,)
                    //     ],
                    //   ),
                    // ),
                    // SizedBox(height: screenHeight * 0.02),
                    // Padding(
                    //   padding: const EdgeInsets.only(bottom: 5.0),
                    //   child: Text('The app will charge 10% from your each earning as commission.',style: TextStyle(color: Color(0xffEBECF0),fontSize: screenHeight * 0.015),),
                    // ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "My sales",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: screenHeight * 0.03,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.grey.shade200)),
                      child: DropdownButton<String>(
                        padding: EdgeInsets.zero,
                        //elevation: 2,
                        value: profileController
                            .selectedValue.value, // Set default selected value
                        items: [
                          DropdownMenuItem(
                            value: 'All',
                            child: Text(
                              'All',
                              softWrap: true,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: screenHeight * 0.02,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'Last month',
                            child: Text(
                              'Last month',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: screenHeight * 0.02,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            profileController.selectedValue.value =
                                value; // Update selected value
                          }
                        },
                        icon: Icon(
                          CupertinoIcons.chevron_down,
                          color: Colors.black,
                          size: 16,
                        ),
                        underline: Container(),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: profileController.venueEarnings.value == null
                    ? Center(child: Text("No sales found."))
                    : ListView.builder(
                        padding: EdgeInsets.zero,
                        //physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: profileController
                            .venueEarnings.value?.data?.myEarning?.data?.length,
                        itemBuilder: (context, index) {
                          return Card(
                            color: Colors.white,
                            margin: EdgeInsets.symmetric(
                                vertical: index == 0 ? 0 : 8, horizontal: 10),
                            child: Padding(
                              padding: EdgeInsets.all(15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${profileController.venueEarnings.value?.data?.myEarning?.data![index].player?.name}',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            '${convertDate(profileController.venueEarnings.value?.data?.myEarning?.data![index].paymentDate ?? DateTime.now.toString())}',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        'OMR ${profileController.venueEarnings.value?.data?.myEarning?.data![index].totalAmount ?? 0}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Program name',
                                            style: TextStyle(fontSize: 14),
                                          ),
                                          Text(
                                            '${profileController.venueEarnings.value?.data?.myEarning?.data![index].bookingType}',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Translation ID',
                                            style: TextStyle(fontSize: 14),
                                          ),
                                          Text(
                                            '#${profileController.venueEarnings.value?.data?.myEarning?.data![index].paymentId}',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: screenWidth * 0.02 / 2,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
