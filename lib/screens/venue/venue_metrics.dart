import 'package:aio_sport/widgets/metrics_booking_comparison_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scaled_size/scaled_size.dart';

import '../../controllers/profile_controller.dart';
import '../../themes/custom_theme.dart';
import '../../widgets/app_bar_widget.dart';

class VenueMetricsScreen extends StatefulWidget {
  const VenueMetricsScreen({super.key});

  @override
  State<VenueMetricsScreen> createState() => _VenueMetricsScreenState();
}

class _VenueMetricsScreenState extends State<VenueMetricsScreen> {
  final profileController = Get.find<ProfileController>();
  final Color longTermColor = Color(0XFF5640FB);
  final Color shortTermColor = Color(0XFF20B9FC);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final myEarnings =
        profileController.venueEarnings.value?.data?.myEarning?.data ?? [];
    var longBookingsCount =
        myEarnings.where((item) => item.bookingType == "long").toList();
    var shortBookingCount =
        myEarnings.where((item) => item.bookingType == "short").toList();

    var totalLongBookingAmount = longBookingsCount.fold(
        0.0, (sum, item) => sum + (item.totalAmount ?? 0.0));
    var totalshortBookingAmount = shortBookingCount.fold(
        0.0, (sum, item) => sum + (item.totalAmount ?? 0.0));

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.maxFinite, 10.vh),
        child: AppbarWidget(
          title: "Metrics",
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
            onPressed: () => Get.back(),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              Text("Overview",
                  style: TextStyle(
                      fontSize: screenHeight * 0.03,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 6,
                    child: Container(
                      height: screenHeight * 0.3,
                      width: double.infinity,
                      padding: EdgeInsets.only(bottom: 20, left: 0, right: 0),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: screenHeight * 0.2,
                              width: screenWidth * 0.2,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  PieChart(
                                    PieChartData(
                                      sectionsSpace: 0,
                                      centerSpaceRadius: 40,
                                      sections: [
                                        PieChartSectionData(
                                          color: longTermColor,
                                          value: longBookingsCount.length
                                              .toDouble(),
                                          title: '',
                                          radius: 20,
                                        ),
                                        PieChartSectionData(
                                          color: shortTermColor,
                                          value: shortBookingCount.length
                                              .toDouble(),
                                          title: '',
                                          radius: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${profileController.venueAnalytics.value?.data.totalBooking}",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 60,
                                        child: Text(
                                          "Total Bookings",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 14, color: Colors.grey),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            _buildLegend(
                                totalLongBookingAmount +
                                            totalshortBookingAmount >
                                        0
                                    ? (longBookingsCount.length *
                                        100 /
                                        (shortBookingCount.length +
                                            longBookingsCount.length))
                                    : 0,
                                totalLongBookingAmount +
                                            totalshortBookingAmount >
                                        0
                                    ? (shortBookingCount.length *
                                        100 /
                                        (shortBookingCount.length +
                                            longBookingsCount.length))
                                    : 0),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                            color: CustomTheme.grey.withOpacity(0.5)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * 0.05,
                  ),
                  Expanded(
                    flex: 6,
                    child: Container(
                      height: screenHeight * 0.3,
                      padding: EdgeInsets.only(left: 20, top: 20, bottom: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ActivityItem(
                            color: Colors.purple,
                            value: profileController
                                .venueAnalytics.value!.data.createdActivity
                                .toString(),
                            label: "Created activity",
                          ),
                          SizedBox(height: 12),
                          ActivityItem(
                            color: Colors.blue,
                            value: profileController
                                .venueAnalytics.value!.data.hostedActivity
                                .toString(),
                            label: "Hosted activity",
                          ),
                          SizedBox(height: 12),
                          ActivityItem(
                            color: Colors.orange,
                            value: profileController
                                .venueAnalytics.value!.data.challanges
                                .toString(),
                            label: "Challenges",
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                            color: CustomTheme.grey.withOpacity(0.5)),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Container(
                // height: screenHeight * 0.5,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border:
                        Border.all(color: CustomTheme.grey.withOpacity(0.5))),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                  child: profileController
                              .venueAnalytics.value?.data.shortTermBooking ==
                          null
                      ? Center(
                          child: Text('No Data Found'),
                        )
                      : MetricsBookingComparisonWidget(),
                ),
              ),
              SizedBox(height: 20),
              Text("Total ground bookings",
                  style: TextStyle(
                      fontSize: screenHeight * 0.03,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: profileController
                    .venueAnalytics.value!.data.gettotalgroundbookings.length,
                itemBuilder: (context, index) {
                  final items = profileController
                          .venueAnalytics.value?.data.gettotalgroundbookings ??
                      [];
                  ;
                  if (items == null || items.isEmpty) {
                    return Center(child: Text("No data available"));
                  }
                  final item = items[index];
                  return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    item.sportsName,
                                    style: Get.textTheme.titleMedium,
                                  ),
                                  Text(
                                    "Bookings",
                                    style: Get.textTheme.titleMedium,
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              if (item.grounds != null &&
                                  item.grounds.isNotEmpty)
                                Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xffE9E8EB).withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                        color:
                                            CustomTheme.grey.withOpacity(0.5)),
                                  ),
                                  child: ListView.separated(
                                      separatorBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, right: 8.0),
                                          child: Divider(),
                                        );
                                      },
                                      shrinkWrap: true,
                                      itemCount: item.grounds.length,
                                      itemBuilder: (context, index) {
                                        var ground = item.grounds[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                ground.groundName,
                                                style:
                                                    Get.textTheme.labelMedium,
                                              ),
                                              Text(
                                                "${ground.pitchBookingCount.toString()}", // Displays the booking count
                                                style:
                                                    Get.textTheme.titleMedium,
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                                  // child: Column(
                                  //   children: item.grounds.map((ground) {
                                  //     return Padding(
                                  //       padding: const EdgeInsets.all(12.0),
                                  //       child: Row(
                                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //         children: [
                                  //           Text(
                                  //             ground.groundName,
                                  //             style: Get.textTheme.labelMedium,
                                  //           ),
                                  //           Text(
                                  //             "${ground.pitchBookingCount.toString()}", // Replace with the actual booking count if available
                                  //             style: Get.textTheme.titleMedium,
                                  //           ),
                                  //         ],
                                  //       ),
                                  //     );
                                  //   }).toList(),
                                  // ),
                                ),
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                              color: CustomTheme.grey.withOpacity(0.5)),
                        ),
                      )
                      // MetricsTotalGroundBookingsWidget(data: '${profileController.venueAnalytics.value!.data}',),
                      );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    double screenWidth =
        MediaQuery.of(context).size.width - 32; // Full width minus padding
    double total = 10500;
    double orangeWidth = (2200 / total) * screenWidth;
    double blueWidth = (3150 / total) * screenWidth;
    double purpleWidth = (5150 / total) * screenWidth;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              height: 12,
              width: screenWidth,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            // 3️⃣ Last segment (Purple) - Drawn first
            _progressSegment(
                purpleWidth, longTermColor, screenWidth - purpleWidth,
                overlap: 6, isLast: true),
            // 2️⃣ Middle segment (Blue) - Drawn second, overlapping last
            _progressSegment(blueWidth, shortTermColor,
                screenWidth - (purpleWidth + blueWidth),
                overlap: 6),
            // 1️⃣ First segment (Orange) - Drawn last, overlapping all
            _progressSegment(orangeWidth, Colors.orange, 0, isFirst: true),
          ],
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _legendProgressItem("OMR 2200", "Challenges Match", Colors.orange),
            _legendProgressItem("OMR 3150", "Hosted Match", shortTermColor),
            _legendProgressItem("OMR 5150", "Created Activity", longTermColor),
          ],
        ),
      ],
    );
  }

  Widget _legendProgressItem(String data, String text, Color color) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 3),
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(shape: BoxShape.circle, color: color),
            ),
          ),
          SizedBox(width: 5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 60,
                child: Text(
                  data,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  softWrap: true,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: 60,
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 12,
                  ),
                  softWrap: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _progressSegment(double width, Color color, double leftPosition,
      {bool isFirst = false, bool isLast = false, double overlap = 0}) {
    return Positioned(
      left: leftPosition - overlap,
      right: isLast ? 0 : null, // Adjust for overlapping effect
      child: Container(
        margin: EdgeInsets.only(right: 1),
        height: 12,
        width: width + overlap, // Extend width for overlap
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.only(
            topLeft: isFirst ? Radius.circular(10) : Radius.circular(10),
            bottomLeft: isFirst ? Radius.circular(10) : Radius.circular(0),
            topRight: isLast ? Radius.circular(10) : Radius.circular(10),
            bottomRight: isLast ? Radius.circular(10) : Radius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _buildLegend(double long, double short) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _legendItem("${long.round().toString()}%", "Long term", longTermColor),
        SizedBox(width: 20),
        _legendItem(
            "${short.round().toString()}%", "Short term", shortTermColor),
      ],
    );
  }

  Widget _legendItem(String percent, String text, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(shape: BoxShape.circle, color: color),
            ),
            SizedBox(width: 5),
            Text(percent,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
        //SizedBox(width: 5),
        Text(text, style: TextStyle(fontSize: 14)),
      ],
    );
  }
}

class ActivityItem extends StatelessWidget {
  final Color color;
  final String value;
  final String label;

  const ActivityItem({
    required this.color,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 40,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
