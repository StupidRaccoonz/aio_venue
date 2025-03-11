import 'dart:io';

import 'package:aio_sport/models/add_venue_details_request_model.dart';
import 'package:aio_sport/models/venue_booking_response.dart';
import 'package:aio_sport/models/venue_create_activity_reponse.dart' as activityModel;
import 'package:aio_sport/themes/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:scaled_size/scaled_size.dart';

class Constants {
  static final popularSportsList = <String>["Football", "Tennis", "Badminton", "Cricket", "Basketball", "Billiards"];
  static final waterSportsList = <String>["Swimming", "Kayaking", "Sailing"];
  static final fitnessSportsList = <String>["Boxing", "Cick Boxing", "Kung Fu", "Dance", "Aerobics"];
  // static final bookingTimeList = <String>["All bookings", "Yesterday's booking", "Last week bookings", "Last month Bookings", "Custom"];
  static final bookingTimeList = <String>["Today's bookings", "Upcoming bookings", "New bookings", "Next week bookings", "Past bookings", "All bookings"];
  static final activityTimeList = <String>["Today's activities", "Upcoming activities", "New activities", "Next week activities", "Past activities", "All activities"];
  static const String isLoggedIn = "LOGGED_IN";
  static const String isNewAccount = "IS_NEW_ACCOUNT";
  static const String lastPage = "LAST_PAGE";
  static const String acountTypeCoach = "COACH";
  static const String acountTypePlayer = "PLAYER";
  static const String acountTypeVenue = "VENUE";
  static List<WorkingDay> workingDays = [
    WorkingDay.fromJson({"day": "Monday", "status": "false"}),
    WorkingDay.fromJson({"day": "Tuesday", "status": "false"}),
    WorkingDay.fromJson({"day": "Wednesday", "status": "false"}),
    WorkingDay.fromJson({"day": "Thursday", "status": "false"}),
    WorkingDay.fromJson({"day": "Friday", "status": "false"}),
    WorkingDay.fromJson({"day": "Saturday", "status": "false"}),
    WorkingDay.fromJson({"day": "Sunday", "status": "false"})
  ];

  static double getheight(int length, {double? mainSize}) {
    if (length.isEven) {
      return (length * (mainSize ?? 50.rh)) / 2;
    }

    return ((length + 1) * (mainSize ?? 50.rh)) / 2;
  }

  static BoxDecoration backgroundDecoration = const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/background.jpg'), fit: BoxFit.cover));

  static String getFormattedDateWithTime(DateTime dateTime) {
    return "${dateTime.day} ${monthToString(dateTime.month).substring(0, 3)}, ${dateTime.year} ${dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour}:${dateTime.minute} ${dateTime.hour >= 12 ? 'PM' : 'AM'}";
  }

  static String getFormattedDateTimeInShort(DateTime dateTime) {
    String formattedDate = DateFormat("d MMM").format(dateTime);
    String formattedTime = DateFormat("h:mm a").format(dateTime).toLowerCase();
    return "$formattedDate ; $formattedTime";
  }

  static String getFormattedTime(TimeOfDay time) {
    return "${time.hourOfPeriod}:${time.minute <= 9 ? "0${time.minute}" : "${time.minute}"} ${time.period.name.toUpperCase()}";
  }

  static String getFormattedDate(DateTime dateTime) {
    return "${dateTime.day} ${monthToString(dateTime.month).substring(0, 3)}, ${dateTime.year}";
  }

  static String getYearToDateFomattedDate(DateTime dateTime) {
    return "${dateTime.year}-${dateTime.month > 9 ? '${dateTime.month}' : '0${dateTime.month}'}-${dateTime.day > 9 ? '${dateTime.day}' : '0${dateTime.day}'}";
  }

  // static String dateToString(DateTime dateTime, bool isBooking) {
  //   int difference = dateTime.difference(DateTime.now()).inDays;
  //
  //   if (difference == 0) {
  //     return "Today's ${isBooking ? 'bookings' : 'activities'}";
  //   }
  //
  //   if (difference <= 7) {
  //     return "Next week ${isBooking ? 'bookings' : 'activities'}";
  //   }
  //
  //   if (dateTime.isBefore(DateTime.now())) {
  //     return "Past ${isBooking ? 'bookings' : 'activities'}";
  //   }
  //
  //   return "Upcoming ${isBooking ? 'bookings' : 'activities'}";
  // }

  // static String intToString(DateTime dateTime, bool isBooking) {
  //   int difference = dateTime.difference(DateTime.now()).inDays;
  //
  //   if (difference == 0) {
  //     return "Today's ${isBooking ? 'bookings' : 'activities'}";
  //   }
  //
  //   if (difference > 0 && difference < 7) {
  //     return "Next week ${isBooking ? 'bookings' : 'activities'}";
  //   }
  //
  //   if (dateTime.isBefore(DateTime.now())) {
  //     return "Past ${isBooking ? 'bookings' : 'activities'}";
  //   }
  //
  //   return "Upcoming ${isBooking ? 'bookings' : 'activities'}";
  // }

  // static String dateToString(int filter, bool isBooking) {
  //
  //   if (filter == 1){
  //     return "Today's ${isBooking ? 'bookings' : 'activities'}";
  //   }
  //
  //   if (filter == 2){
  //     return "Upcoming ${isBooking ? 'bookings' : 'activities'}";
  //   }
  //
  //   if (filter == 3){
  //     return "New ${isBooking ? 'bookings' : 'activities'}";
  //   }
  //
  //   if (filter == 4){
  //     return "Next week ${isBooking ? 'bookings' : 'activities'}";
  //   }
  //
  //   if (filter == 5){
  //     return "Past ${isBooking ? 'bookings' : 'activities'}";
  //   }
  //
  //   if (filter == 6){
  //     return "All ${isBooking ? 'bookings' : 'activities'}";
  //   }
  //   return '';
  //
  //

  static List<activityModel.CreateActivityMatch> filterMatchesByDate(List<activityModel.CreateActivityMatch> matches, int filterType) {
    if (matches == null) return [];

    DateTime targetDate;
    DateTime now = DateTime.now();

    switch (filterType) {
      case 1: // Today's matches
        targetDate = now;
        return matches.where((m) => isSameDate(m.date, targetDate)).toList();

      case 2: // Upcoming matches (next month)
        targetDate = DateTime(now.year, now.month + 1, 1);
        return matches.where((m) => m.date.isAfter(now)).toList();

      case 3: // Matches booked for today
        targetDate = DateTime(now.year, now.month, now.day);
        return matches.where((m) => isSameDate(m.date, targetDate)).toList();

      case 4: // Matches in the next week
        targetDate = now.add(Duration(days: 7));
        return matches.where((m) => m.date.isAfter(now) && m.date.isBefore(targetDate)).toList();

      case 5: // Past matches
        return matches.where((m) => m.date.isBefore(now)).toList();

      case 6: // All matches (no filter)
        return matches;

      default:
        return matches;
    }
  }

  static List<BookingData> filterBookingsByDate(List<BookingData> matches, int filterType) {
    if (matches == null) return [];

    DateTime targetDate;
    DateTime now = DateTime.now();

    switch (filterType) {
      case 1: // Today's matches
        targetDate = now;
        return matches.where((m) => isSameDate(m.bookingDate, targetDate)).toList();

      case 2: // Upcoming matches (next month)
        targetDate = DateTime(now.year, now.month + 1, 1);
        return matches.where((m) => m.bookingDate.isAfter(now)).toList();

      case 3: // Matches booked for today
        targetDate = DateTime(now.year, now.month, now.day);
        return matches.where((m) => isSameDate(m.bookingDate, targetDate)).toList();

      case 4: // Matches in the next week
        targetDate = now.add(Duration(days: 7));
        return matches.where((m) => m.bookingDate.isAfter(now) && m.bookingDate.isBefore(targetDate)).toList();

      case 5: // Past matches
        return matches.where((m) => m.bookingDate.isBefore(now)).toList();

      case 6: // All matches (no filter)
        return matches;

      default:
        return matches;
    }
  }

  static bool isSameDate(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
  }

  static DateTime stringToDate(int filterType) {
    switch (filterType) {
      case 1: // Today's bookings
        return DateTime.now();

      case 2: // Upcoming bookings
        return DateTime(DateTime.now().year, DateTime.now().month + 1, 1);

      case 3: // Booked bookings for today
        return DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

      case 4: // Next week bookings
        return DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().add(Duration(days: 7)).day);

      case 5: // Past bookings
        return DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().subtract(Duration(days: 1)).day);

      case 6: // All bookings
        return DateTime(DateTime.now().year, DateTime.now().month);

      default:
        return DateTime.now(); // Default is today's date if no valid filter is selected
    }
  }

  // static DateTime stringToDate(String value) {
  //   // int difference = dateTime.difference(DateTime.now()).inDays;
  //
  //   if (value == "Today's bookings") {
  //     return DateTime.now();
  //   }
  //
  //   if (value == "Upcoming bookings") {
  //     return DateTime(DateTime.now().year,DateTime.now().month + 1, 1);
  //   }
  //
  //   if (value == "New bookings") {
  //     return DateTime(DateTime.now().year,DateTime.now().month, DateTime.now().day + 1);
  //   }
  //
  //   if (value == "Next week bookings") {
  //     // return DateTime(
  //     //   DateTime.now().year,
  //     //   DateTime.now().month,
  //     //   DateTime.now().day <= 21 ? DateTime.now().day + 7 : DateTime.now().day,
  //     // );
  //     return DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().add(Duration(days: 7)).weekday);
  //   }
  //
  //   if (value == "Past bookings") {
  //     return DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().subtract(Duration(days: 1)).day);
  //      // return DateTime(DateTime.now().year,DateTime.now().month, DateTime.now().day - 1);
  //   }
  //
  //   if (value == 'All') {
  //     return DateTime(DateTime.now().year, DateTime.now().month);
  //     // return DateTime(1990, 1, 1);
  //   }
  //
  //   return DateTime.now();
  // }
  static String intToString(int date, bool isBooking) {
    switch (date) {
      case 1:
        return "Today's ${isBooking ? 'bookings' : 'activities'}";

      case 2:
        return "Upcoming ${isBooking ? 'bookings' : 'activities'}";

      case 3:
        return "New ${isBooking ? 'bookings' : 'activities'}";

      case 4:
        return "Next week ${isBooking ? 'bookings' : 'activities'}";

      case 5:
        return "Past ${isBooking ? 'bookings' : 'activities'}";

      case 6:
        return "All ${isBooking ? 'bookings' : 'activities'}";

      default:
        return "Unknown filter type";
    }
  }

  /*New*/

  static int stringToInt(String filterType) {
    switch (filterType) {
      case "Today's bookings":
        return 1;

      case "Upcoming bookings":
        return 2;

      case "New bookings":
        return 3;

      case "Next week bookings":
        return 4;

      case "Past bookings":
        return 5;

      case "All bookings":
        return 6;

      default:
        return 0;
    }
  }

  static int activityTimeToInt(String filterType) {
    switch (filterType) {
      case "Today's activities":
        return 1;

      case "Upcoming activities":
        return 2;

      case "New activities":
        return 3;

      case "Next week activities":
        return 4;

      case "Past activities":
        return 5;

      case "All activities":
        return 6;

      default:
        return 0;
    }
  }

  static String dateToDayName(int weekday, {bool? longString}) {
    switch (weekday) {
      case 1:
        return "Mo";
      case 2:
        return "Tu";
      case 3:
        return "We";
      case 4:
        return "Th";
      case 5:
        return "Fr";
      case 6:
        return "Sa";
      case 7:
        return "Su";
      default:
        return "Mo";
    }
  }

  static int monthToNumberOfDays(int month, int year) {
    switch (month) {
      case 1:
        return 31;
      case 2:
        return year % 4 == 0 ? 29 : 28;
      case 3:
        return 31;
      case 4:
        return 30;
      case 5:
        return 31;
      case 6:
        return 30;
      case 7:
        return 31;
      case 8:
        return 31;
      case 9:
        return 30;
      case 10:
        return 31;
      case 11:
        return 30;
      case 12:
        return 31;

      default:
        return 31;
    }
  }

  static String monthToString(int month) {
    switch (month) {
      case 1:
        return "January";
      case 2:
        return "February";
      case 3:
        return "March";
      case 4:
        return "April";
      case 5:
        return "May";
      case 6:
        return "June";
      case 7:
        return "July";
      case 8:
        return "August";
      case 9:
        return "September";
      case 10:
        return "October";
      case 11:
        return "November";
      case 12:
        return "December";

      default:
        return "January";
    }
  }

  static void showSnackbar(String title, String message) {
    Get.snackbar(title, message,
        titleText: Text(
          title,
          style: Get.textTheme.labelMedium!.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        messageText: Text(
          message,
          style: Get.textTheme.labelMedium!.copyWith(color: Colors.white),
        ),
        colorText: Colors.white,
        backgroundColor: CustomTheme.appColor,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16.0),
        isDismissible: true,
        dismissDirection: DismissDirection.down,
        forwardAnimationCurve: Curves.fastOutSlowIn,
        animationDuration: const Duration(milliseconds: 500));
  }

  static Future<List<File>> pickImage({ImageSource imSource = ImageSource.gallery, bool multiple = false}) async {
    String? source = await getImageSourceDialog();
    if (source == null) return [];
    final ImagePicker picker = ImagePicker();

    if (!multiple) {
      // Pick an image.
      final XFile? image = await picker.pickImage(source: source == "gallery" ? ImageSource.gallery : ImageSource.camera, requestFullMetadata: false);
      if (image != null) {
        File file = File(image.path);
        return [file];
      } else {
        return [];
      }
    }

    if (source == 'camera') {
      final XFile? image = await picker.pickImage(source: ImageSource.camera, requestFullMetadata: false);
      if (image != null) {
        File file = File(image.path);
        return [file];
      } else {
        return [];
      }
    } else {
      // Pick multiple images.
      final List<XFile> images = await picker.pickMultiImage(requestFullMetadata: false);
      return images.map((e) => File(e.path)).toList();
    }
  }

  static Future<File?> pickVideo({ImageSource source = ImageSource.gallery}) async {
    String? source = await getImageSourceDialog();
    if (source == null) return null;
    final ImagePicker picker = ImagePicker();

    // Pick a video.
    final XFile? video = await picker.pickVideo(source: source == "gallery" ? ImageSource.gallery : ImageSource.camera, maxDuration: const Duration(seconds: 10));
    if (video != null) {
      return File(video.path);
    }
    return null;
  }

  static Future<String?> getImageSourceDialog() async {
    return await Get.dialog<String?>(
      Padding(
        padding: const EdgeInsets.all(40.0),
        child: Center(
          child: Material(
            borderRadius: BorderRadius.circular(16.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: const Text("Camera"),
                    leading: const Icon(Icons.camera_alt_outlined),
                    onTap: () => Get.back(result: "camera"),
                  ),
                  ListTile(
                    title: const Text("Gallery"),
                    leading: const Icon(Icons.image),
                    onTap: () => Get.back(result: "gallery"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static bool isPastMatch(DateTime date, List<String> morningTimes, List<String> eveningTimes) {
    final today = DateTime.now();

    if (eveningTimes.isNotEmpty) {
      final time = TimeOfDay(hour: int.parse(eveningTimes.last.split("-").last.split(":").first), minute: 00);

      final dateTime = DateTime(date.year, date.month, date.day, time.hour, time.minute);

      int hourse = dateTime.difference(today).inHours;

      return hourse < 0;
    } else {
      final time = TimeOfDay(hour: int.parse(morningTimes.last.split("-").last.split(":").first), minute: 00);

      final dateTime = DateTime(date.year, date.month, date.day, time.hour, time.minute);

      int hourse = dateTime.difference(today).inHours;

      return hourse < 0;
    }
  }
}
