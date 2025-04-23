import 'dart:developer';

import 'package:aio_sport/controllers/profile_controller.dart';
import 'package:aio_sport/models/venue_analytics_model.dart';
import 'package:aio_sport/models/venue_booking_response.dart';
import 'package:aio_sport/models/venue_earning_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MetricsBookingComparisonWidget extends StatefulWidget {
  const MetricsBookingComparisonWidget({super.key});

  @override
  _MetricsBookingComparisonWidgetState createState() =>
      _MetricsBookingComparisonWidgetState();
}

class _MetricsBookingComparisonWidgetState
    extends State<MetricsBookingComparisonWidget> {
  List<FlSpot> totalShortAmountSpots = [];
  List<FlSpot> slotsCountSpots = [];
  List<String> dateLabels = [];
  String selectedFilter = "1W";
  final Color longTermColor = Color(0XFF5640FB);
  final Color shortTermColor = Color(0XFF20B9FC);
  final profileController = Get.find<ProfileController>();

  List<FlSpot> longTermSpots = [];
  List<FlSpot> shortTermSpots = [];
  // Set<DateTime> uniqueDates = {};

  // int getDateIndexByDate(DateTime targetDate) {
  //   int index = uniqueDates.toList().indexWhere((date) => date.year == targetDate.year && date.month == targetDate.month && date.day == targetDate.day);
  //   return index;
  // }

  // int getLongTermBookingsCountByDate(DateTime targetDate) {
  //   return profileController.longBookings.value!.bookings!.data!.where((item) => item.date[0].year == targetDate.year && item.date[0].month == targetDate.month && item.date[0].day == targetDate.day).length;
  // }

  // int getShortTermBookingsCountByDate(DateTime targetDate) {
  //   return profileController.shortBookings.value!.bookings!.data.where((item) => item.date[0].year == targetDate.year && item.date[0].month == targetDate.month && item.date[0].day == targetDate.day).length;
  // }

  // List<FlSpot> getLongFlSpots() {
  //   List<FlSpot> list = [];
  //   uniqueDates.forEach((date) {
  //     final counOfLongDateOfGivenDate = getLongTermBookingsCountByDate(date);
  //     final dateIndex = getDateIndexByDate(date);
  //     if (counOfLongDateOfGivenDate > 0) {
  //       list.add(FlSpot(dateIndex.toDouble(), counOfLongDateOfGivenDate.toDouble()));
  //     }
  //   });
  //   return list;
  // }

  // List<FlSpot> getShortFlSpots() {
  //   List<FlSpot> list = [];
  //   uniqueDates.forEach((date) {
  //     final counOfShortDateOfGivenDate = getShortTermBookingsCountByDate(date);
  //     final dateIndex = getDateIndexByDate(date);
  //     if (counOfShortDateOfGivenDate > 0) {
  //       list.add(FlSpot(dateIndex.toDouble(), counOfShortDateOfGivenDate.toDouble()));
  //     }
  //   });
  //   return list;
  // }
  @override
  void initState() {
    getShortSpots();
    getLongSpots();
    super.initState();
  }

  void getShortSpots() {
    if (selectedFilter == '1W') {
      final today = DateTime.now();
      // List<FlSpot> longTermSpotList = [];
      List<FlSpot> shortTermSpotList = [];

      for (int i = 6; i >= 0; i--) {
        final date = today.subtract(Duration(days: i));
        final booking = profileController!
            .venueAnalytics.value!.data.shortTermBooking
            .firstWhereOrNull((element) =>
                element.bookingDate!.day == date.day &&
                element.bookingDate!.month == date.month &&
                element.bookingDate!.year == date.year);
        shortTermSpotList.add(FlSpot(6 - i.toDouble(),
            (booking != null ? booking.bookingCount : 0).toDouble()));
      }
      shortTermSpots = shortTermSpotList;
    } else if (selectedFilter == '1M') {
      final today = DateTime.now();
      List<FlSpot> spotList = [];
      Map<int, int> weeklyBookingCount = {};

      DateTime startOfMonth = today.subtract(Duration(days: 28));

      for (int week = 0; week < 4; week++) {
        weeklyBookingCount[week] = 0;
      }

      for (var booking
          in profileController!.venueAnalytics.value!.data.shortTermBooking) {
        DateTime bookingDate = booking.bookingDate!;

        if (bookingDate.isAfter(startOfMonth) && bookingDate.isBefore(today)) {
          int weekIndex = ((bookingDate.difference(startOfMonth).inDays) ~/ 7);
          weeklyBookingCount[weekIndex] =
              (weeklyBookingCount[weekIndex] ?? 0) + booking.bookingCount;
        }
      }

      weeklyBookingCount.forEach((week, count) {
        spotList.add(FlSpot(week.toDouble(), count.toDouble()));
      });

      shortTermSpots = spotList;
    }
    if (selectedFilter == '6M') {
      final today = DateTime.now();
      List<FlSpot> shortTermSpotList = [];

      for (int monthIndex = 5; monthIndex >= 0; monthIndex--) {
        int monthlyBookingCount = 0;

        final currentMonth = today.subtract(Duration(days: 30 * monthIndex));
        final firstDayOfMonth =
            DateTime(currentMonth.year, currentMonth.month, 1);
        final lastDayOfMonth =
            DateTime(currentMonth.year, currentMonth.month + 1, 0);

        for (var day = firstDayOfMonth;
            day.isBefore(lastDayOfMonth.add(Duration(days: 1)));
            day = day.add(Duration(days: 1))) {
          final booking = profileController!
              .venueAnalytics.value!.data.shortTermBooking
              .firstWhereOrNull((element) =>
                  element.bookingDate!.day == day.day &&
                  element.bookingDate!.month == day.month &&
                  element.bookingDate!.year == day.year);
          if (booking != null) {
            monthlyBookingCount += booking.bookingCount;
          }
        }

        shortTermSpotList.add(
            FlSpot(5 - monthIndex.toDouble(), monthlyBookingCount.toDouble()));
      }

      shortTermSpots = shortTermSpotList;
    } else if (selectedFilter == '1Y') {
      final today = DateTime.now();
      List<FlSpot> yearlySpotList = [];

      for (int quarterIndex = 3; quarterIndex >= 0; quarterIndex--) {
        int quarterlyBookingCount = 0;

        int monthsToSubtract = quarterIndex * 3;
        final startMonth = today.month - monthsToSubtract;

        final firstDayOfQuarter = DateTime(today.year, startMonth, 1);
        final lastMonthOfQuarter =
            (startMonth + 2) > 12 ? 12 : (startMonth + 2);
        final lastDayOfQuarter =
            DateTime(today.year, lastMonthOfQuarter + 1, 0);

        for (var day = firstDayOfQuarter;
            day.isBefore(lastDayOfQuarter.add(Duration(days: 1)));
            day = day.add(Duration(days: 1))) {
          final booking = profileController!
              .venueAnalytics.value!.data.shortTermBooking
              .firstWhereOrNull((element) =>
                  element.bookingDate!.day == day.day &&
                  element.bookingDate!.month == day.month &&
                  element.bookingDate!.year == day.year);

          if (booking != null) {
            quarterlyBookingCount += booking.bookingCount;
          }
        }

        yearlySpotList.add(FlSpot(
            (3 - quarterIndex).toDouble(), quarterlyBookingCount.toDouble()));
      }

      shortTermSpots = yearlySpotList;
    }
    if (selectedFilter == '5Y') {
      final today = DateTime.now();
      List<FlSpot> fiveYearSpotList = [];

      for (int yearIndex = 4; yearIndex >= 0; yearIndex--) {
        int yearlyBookingCount = 0;

        int year = today.year - (4 - yearIndex);

        final firstDayOfYear = DateTime(year, 1, 1);
        final lastDayOfYear = DateTime(year, 12, 31);

        for (var day = firstDayOfYear;
            day.isBefore(lastDayOfYear.add(Duration(days: 1)));
            day = day.add(Duration(days: 1))) {
          final booking = profileController!
              .venueAnalytics.value!.data.shortTermBooking
              .firstWhereOrNull((element) =>
                  element.bookingDate!.day == day.day &&
                  element.bookingDate!.month == day.month &&
                  element.bookingDate!.year == day.year);

          if (booking != null) {
            yearlyBookingCount += booking.bookingCount;
          }
        }

        fiveYearSpotList
            .add(FlSpot((yearIndex).toDouble(), yearlyBookingCount.toDouble()));
      }

      shortTermSpots = fiveYearSpotList;
    } else if (selectedFilter == 'Max') {
      final bookingData =
          profileController!.venueAnalytics.value!.data.shortTermBooking;

      if (bookingData.isEmpty) return;

      int minYear = bookingData
          .map((e) => e.bookingDate!.year)
          .reduce((a, b) => a < b ? a : b);
      int maxYear = bookingData
          .map((e) => e.bookingDate!.year)
          .reduce((a, b) => a > b ? a : b);

      List<FlSpot> spotList = [];
      Map<int, int> yearlyBookingCount = {};

      for (int year = minYear; year <= maxYear; year++) {
        yearlyBookingCount[year] = 0;
      }

      for (var booking in bookingData) {
        int year = booking.bookingDate!.year;
        yearlyBookingCount[year] =
            (yearlyBookingCount[year] ?? 0) + booking.bookingCount;
      }

      int index = 0;
      yearlyBookingCount.forEach((year, count) {
        spotList.add(FlSpot(index.toDouble(), count.toDouble()));
        index++;
      });
      shortTermSpots = spotList;
    }

    setState(() {});
  }

  void getLongSpots() {
    if (selectedFilter == '1W') {
      final today = DateTime.now();
      List<FlSpot> longTermSpots = [];

      for (int i = 6; i >= 0; i--) {
        final date = today.subtract(Duration(days: i));
        final booking = profileController!
            .venueAnalytics.value!.data.longTermBooking
            .firstWhereOrNull((element) =>
                element.bookingDate!.day == date.day &&
                element.bookingDate!.month == date.month &&
                element.bookingDate!.year == date.year);
        longTermSpots.add(FlSpot(6 - i.toDouble(),
            (booking != null ? booking.bookingCount : 0).toDouble()));
      }
      longTermSpots = longTermSpots;
    } else if (selectedFilter == '1M') {
      final today = DateTime.now();
      List<FlSpot> spotList = [];
      Map<int, int> weeklyBookingCount = {};

      DateTime startOfMonth = today.subtract(Duration(days: 28));

      for (int week = 0; week < 4; week++) {
        weeklyBookingCount[week] = 0;
      }
      for (var booking
          in profileController!.venueAnalytics.value!.data.longTermBooking) {
        DateTime bookingDate = booking.bookingDate!;
        if (bookingDate.isAfter(startOfMonth) && bookingDate.isBefore(today)) {
          int weekIndex = ((bookingDate.difference(startOfMonth).inDays) ~/ 7);
          weeklyBookingCount[weekIndex] =
              (weeklyBookingCount[weekIndex] ?? 0) + booking.bookingCount;
        }
      }
      weeklyBookingCount.forEach((week, count) {
        spotList.add(FlSpot(week.toDouble(), count.toDouble()));
      });
      longTermSpots = spotList;
    }
    if (selectedFilter == '6M') {
      final today = DateTime.now();
      List<FlSpot> longTermSpotList = [];

      for (int monthIndex = 5; monthIndex >= 0; monthIndex--) {
        int monthlyBookingCount = 0;
        final currentMonth = today.subtract(Duration(days: 30 * monthIndex));
        final firstDayOfMonth =
            DateTime(currentMonth.year, currentMonth.month, 1);
        final lastDayOfMonth =
            DateTime(currentMonth.year, currentMonth.month + 1, 0);
        for (var day = firstDayOfMonth;
            day.isBefore(lastDayOfMonth.add(Duration(days: 1)));
            day = day.add(Duration(days: 1))) {
          final booking = profileController!
              .venueAnalytics.value!.data.longTermBooking
              .firstWhereOrNull((element) =>
                  element.bookingDate!.day == day.day &&
                  element.bookingDate!.month == day.month &&
                  element.bookingDate!.year == day.year);
          if (booking != null) {
            monthlyBookingCount += booking.bookingCount;
          }
        }
        longTermSpotList.add(
            FlSpot(5 - monthIndex.toDouble(), monthlyBookingCount.toDouble()));
      }

      longTermSpots = longTermSpotList;
    } else if (selectedFilter == '1Y') {
      final today = DateTime.now();
      List<FlSpot> yearlySpotList = [];

      for (int quarterIndex = 3; quarterIndex >= 0; quarterIndex--) {
        int quarterlyBookingCount = 0;
        int monthsToSubtract = quarterIndex * 3;
        final startMonth = today.month - monthsToSubtract;
        final firstDayOfQuarter = DateTime(today.year, startMonth, 1);
        final lastMonthOfQuarter =
            (startMonth + 2) > 12 ? 12 : (startMonth + 2);
        final lastDayOfQuarter =
            DateTime(today.year, lastMonthOfQuarter + 1, 0);
        for (var day = firstDayOfQuarter;
            day.isBefore(lastDayOfQuarter.add(Duration(days: 1)));
            day = day.add(Duration(days: 1))) {
          final booking = profileController!
              .venueAnalytics.value!.data.longTermBooking
              .firstWhereOrNull((element) =>
                  element.bookingDate!.day == day.day &&
                  element.bookingDate!.month == day.month &&
                  element.bookingDate!.year == day.year);

          if (booking != null) {
            quarterlyBookingCount += booking.bookingCount;
          }
        }
        yearlySpotList.add(FlSpot(
            (3 - quarterIndex).toDouble(), quarterlyBookingCount.toDouble()));
      }

      longTermSpots = yearlySpotList;
    }
    if (selectedFilter == '5Y') {
      final today = DateTime.now();
      List<FlSpot> fiveYearSpotList = [];

      for (int yearIndex = 4; yearIndex >= 0; yearIndex--) {
        int yearlyBookingCount = 0;

        int year = today.year - (4 - yearIndex);
        final firstDayOfYear = DateTime(year, 1, 1);
        final lastDayOfYear = DateTime(year, 12, 31);

        for (var day = firstDayOfYear;
            day.isBefore(lastDayOfYear.add(Duration(days: 1)));
            day = day.add(Duration(days: 1))) {
          final booking = profileController!
              .venueAnalytics.value!.data.longTermBooking
              .firstWhereOrNull((element) =>
                  element.bookingDate!.day == day.day &&
                  element.bookingDate!.month == day.month &&
                  element.bookingDate!.year == day.year);

          if (booking != null) {
            yearlyBookingCount += booking.bookingCount;
          }
        }
        fiveYearSpotList
            .add(FlSpot((yearIndex).toDouble(), yearlyBookingCount.toDouble()));
      }

      longTermSpots = fiveYearSpotList;
    } else if (selectedFilter == 'Max') {
      final bookingData =
          profileController!.venueAnalytics.value!.data.longTermBooking;

      if (bookingData.isEmpty) return;

      int minYear = bookingData
          .map((e) => e.bookingDate!.year)
          .reduce((a, b) => a < b ? a : b);
      int maxYear = bookingData
          .map((e) => e.bookingDate!.year)
          .reduce((a, b) => a > b ? a : b);

      List<FlSpot> spotList = [];
      Map<int, int> yearlyBookingCount = {};

      for (int year = minYear; year <= maxYear; year++) {
        yearlyBookingCount[year] = 0;
      }
      for (var booking in bookingData) {
        int year = booking.bookingDate!.year;
        yearlyBookingCount[year] =
            (yearlyBookingCount[year] ?? 0) + booking.bookingCount;
      }
      int index = 0;
      yearlyBookingCount.forEach((year, count) {
        spotList.add(FlSpot(index.toDouble(), count.toDouble()));
        index++;
      });
      longTermSpots = spotList;
    }

    setState(() {});
  }

  Widget bottomTitleWidgetsz(double value, TitleMeta meta) {
    if (selectedFilter == "1W") {
      final today = DateTime(2025, 2, 23);
      final date = today.subtract(Duration(days: (6 - value).toInt()));
      final style = TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 12,
      );
      return SideTitleWidget(
        axisSide: meta.axisSide,
        child: Text(DateFormat('E').format(date), style: style),
      );
    } else if (selectedFilter == '1M') {
      return SideTitleWidget(
        axisSide: meta.axisSide,
        child: Text(
          'Week ${(value + 1).toInt()}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      );
    } else if (selectedFilter == '6M') {
      final today = DateTime.now();

      final monthDate =
          DateTime(today.year, today.month - (5 - value.toInt()), 1);

      return SideTitleWidget(
        axisSide: meta.axisSide,
        child: Text(
          DateFormat('MMM').format(monthDate),
          style: TextStyle(
            color: Colors.grey[600],
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      );
    } else if (selectedFilter == '1Y') {
      final today = DateTime.now();
      final currentQuarter = ((today.month - 1) ~/ 3) + 1;

      List<String> quarterLabels = [];
      for (int i = 0; i < 4; i++) {
        int quarterNumber = ((currentQuarter - i - 1 + 4) % 4) + 1;
        String label = quarterNumber == 1
            ? 'Jan-Mar'
            : quarterNumber == 2
                ? 'Apr-Jun'
                : quarterNumber == 3
                    ? 'Jul-Sep'
                    : 'Oct-Dec';
        quarterLabels.add(label);
      }

      quarterLabels = quarterLabels.reversed.toList();

      return SideTitleWidget(
        axisSide: meta.axisSide,
        child: Text(
          quarterLabels[value.toInt()],
          style: TextStyle(
            color: Colors.grey[600],
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      );
      // }
    } else if (selectedFilter == '5Y') {
      final int currentYear = DateTime.now().year;
      final int year =
          currentYear - (4 - value.toInt()); // Mapping index to year

      return SideTitleWidget(
        axisSide: meta.axisSide,
        child: Text(
          '$year',
          style: TextStyle(
            color: Colors.grey[600],
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      );
    } else {
      final bookingData =
          profileController!.venueAnalytics.value!.data.shortTermBooking;

      if (bookingData.isEmpty) return SizedBox();

      List<int> years =
          bookingData.map((e) => e.bookingDate!.year).toSet().toList();
      years.sort();

      if (value.toInt() < 0 || value.toInt() >= years.length) return SizedBox();

      return SideTitleWidget(
        axisSide: meta.axisSide,
        child: Text(
          '${years[value.toInt()]}',
          style: TextStyle(
            color: Colors.grey[600],
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      );
    }
  }

  Widget leftTitleWidgetsz(double value, TitleMeta meta) {
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        value.toInt().toString(),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final myEarnings =
        profileController.venueEarnings.value?.data?.myEarning?.data ?? [];
    var longBookings =
        myEarnings.where((item) => item.bookingType == "long").toList();
    var shortBookings =
        myEarnings.where((item) => item.bookingType == "short").toList();

    int totalBookings = longBookings.length + shortBookings.length;

    final List<BookingData> allBookings = [
      ...(profileController.longBookings.value!.bookings == null
          ? []
          : profileController.longBookings!.value!.bookings!.data),
      ...(profileController.shortBookings.value!.bookings == null
          ? []
          : profileController.shortBookings!.value!.bookings!.data)
    ];
    print(
        "TotalBookings: ${totalBookings} allBooking: ${allBookings.length}, shortBookings: ${shortBookings.length} longBookins:${longBookings.length}, len: ${profileController.venueAnalytics.value!.data.shortTermBooking.length}");

    return Container(
      width: 350,
      height: 350,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Booking Comparison",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          _buildTimeFilterButtons(),
          const SizedBox(height: 8),
          Expanded(child: LineChart(_mainChartData(totalBookings.toDouble()))),
          const SizedBox(height: 8),
          _buildLegend(),
        ],
      ),
    );
  }

  Widget _buildTimeFilterButtons() {
    List<String> filters = ["1W", "1M", "6M", "1Y", "5Y", "Max"];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: filters.map((filter) {
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedFilter = filter;
              getShortSpots();
              getLongSpots();
            });
          },
          child: Text(
            filter,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: selectedFilter == filter ? Colors.black : Colors.grey,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LegendItem(color: longTermColor, text: "Long term"),
        SizedBox(width: 16),
        LegendItem(color: shortTermColor, text: "Short term"),
      ],
    );
  }

  LineChartData _mainChartData(double totalBookings) {
    return LineChartData(
      backgroundColor: Colors.transparent,
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        drawVerticalLine: false,
        horizontalInterval: 20,
        getDrawingHorizontalLine: (value) {
          if (value == 0 || value == 120) {
            return FlLine(
              color: Colors.grey.withOpacity(0.8),
              strokeWidth: 2,
            );
          }
          return FlLine(
            color: Colors.grey.withOpacity(0.5),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) => Text(
              value.toStringAsFixed(0),
              style: TextStyle(fontSize: 12),
            ),
          ),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: bottomTitleWidgetsz,
            interval: 1,
            reservedSize: 22,
          ),
        ),
        rightTitles:
            const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),
      borderData: FlBorderData(show: false),
      minX: 0,
      maxX: selectedFilter == '1Y'
          ? 3
          : selectedFilter == '6M'
              ? 5
              : selectedFilter == '1M'
                  ? 3
                  : selectedFilter == '1Y'
                      ? 4
                      : selectedFilter == '5Y'
                          ? 4
                          : 6,
      minY: 0,
      maxY: totalBookings,
      lineBarsData: [
        // LineChartBarData(
        //   // spots: profileController.myVenues.value!.data!.venue.map((e) => FlSpot(e.id.toDouble(), e.longTermBooking.toDouble())).toList(),
        //   spots: shortTermBookings!.map((e) => FlSpot(e.bookingCount.toDouble(), e.bookingCount.toDouble())).toList(),
        //   isCurved: true,
        //   color: longTermColor,
        //   barWidth: 3,
        //   isStrokeCapRound: true,
        //   belowBarData: BarAreaData(show: false, color: longTermColor.withOpacity(0.1)),
        //   dotData: FlDotData(
        //     show: true,
        //     getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
        //       radius: 4,
        //       color: Colors.white,
        //       strokeWidth: 2,
        //       strokeColor: longTermColor,
        //     ),
        //   ),
        // ),
        _lineData(shortTermSpots, shortTermColor),
        _lineData(longTermSpots, longTermColor),
        // _lineData(getLongFlSpots(), longTermColor),
      ],
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          getTooltipColor: (touchedSpot) {
            return Colors.white;
          }, // Ensure tooltip background is white
          getTooltipItems: (List<LineBarSpot> touchedSpots) {
            return touchedSpots.map((touchedSpot) {
              return LineTooltipItem(
                  '', // Unicode bullet for dot effect
                  TextStyle(
                    color: touchedSpot
                        .bar.color, // Apply the dot color to the text
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: '• ',
                      style: TextStyle(
                        color: touchedSpot
                            .bar.color, // Dot color matches line color
                        fontSize: 25, // Slightly larger to mimic a circle
                      ),
                    ),
                    TextSpan(
                      children: [
                        TextSpan(
                          text: touchedSpot.y.toStringAsFixed(0), // Data value
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ]);
            }).toList();
          },
        ),
      ),
    );
  }

  LineChartBarData _lineData(List<FlSpot> spots, Color color) {
    return LineChartBarData(
      spots: spots,
      isCurved: true,
      color: color,
      barWidth: 3,
      isStrokeCapRound: true,
      belowBarData: BarAreaData(show: false, color: color.withOpacity(0.1)),
      dotData: FlDotData(
        show: true,
        getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
          radius: 4,
          color: Colors.white,
          strokeWidth: 2,
          strokeColor: color,
        ),
      ),
    );
  }

  Widget _bottomTitleWidgets(double value, TitleMeta meta) {
    List<String> labels = [
      "1 Jan",
      "2 Jan",
      "3 Jan",
      "4 Jan",
      "5 Jan",
      "6 Jan",
      "7 Jan"
    ];
    // List<String> labels = uniqueDates.map((date) => DateFormat("d MMM").format(date).toString()).toList();
    String text = value.toInt() >= 0 && value.toInt() < labels.length
        ? labels[value.toInt()]
        : '';
    return Text(text, style: const TextStyle(fontSize: 10));
  }
}

class LegendItem extends StatelessWidget {
  final Color color;
  final String text;

  const LegendItem({required this.color, required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 5),
        Text(text, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
