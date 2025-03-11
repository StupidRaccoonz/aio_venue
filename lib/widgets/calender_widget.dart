import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CalenderWidget extends StatefulWidget {
  final DateTime selectedDate;
  const CalenderWidget({super.key, required this.selectedDate});

  @override
  State<CalenderWidget> createState() => _CalenderWidgetState();
}

class _CalenderWidgetState extends State<CalenderWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(children: [
        Center(child: Text("${widget.selectedDate.year}", style: Get.textTheme.displaySmall)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"].map((e) => Text(e)).toList(),
        ),
      ]),
    );
  }
}
