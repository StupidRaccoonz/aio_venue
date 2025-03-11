import 'package:aio_sport/constants/constants.dart';
import 'package:aio_sport/themes/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scaled_size/scaled_size.dart';
import 'package:aio_sport/models/venue_details_model.dart' as venue_details;

import '../models/venue_details_model.dart';

typedef MyCallback = void Function(List<WorkingDay> val);

class WorkingDayWidget extends StatefulWidget {
  final MyCallback callback;
  final List<venue_details.WorkingDay> venueWorkingDays;
  const WorkingDayWidget({super.key, required this.callback, required this.venueWorkingDays});

  @override
  State<WorkingDayWidget> createState() => _WorkingDayWidgetState();
}

class _WorkingDayWidgetState extends State<WorkingDayWidget> {
  @override
  Widget build(BuildContext context) {
    List<venue_details.WorkingDay> workingDays = widget.venueWorkingDays;
    final daysList = <String>["M", "T", "W", "T", "F", "S", "S"];
    final selectedList = workingDays.map((workingDay) => workingDay.status.toString().toLowerCase() == "true").toList();
    return ListView.builder(
      itemCount: daysList.length,
      scrollDirection: Axis.horizontal,
      itemExtent: 7.0.mv,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
          child: GestureDetector(
            onTap: () {
              selectedList[index] = !selectedList[index];
              workingDays[index].status = "${selectedList[index]}";
              widget.callback(workingDays);

              setState(() {});
            },
            child: Center(
              child: Material(
                color: selectedList[index] ? CustomTheme.iconColor : Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.br), side: BorderSide(color: CustomTheme.iconColor)),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(daysList[index],
                        style: Get.textTheme.headlineSmall?.copyWith(
                            color: selectedList[index] ? Colors.white : CustomTheme.textColor,
                            fontWeight: FontWeight.w300)),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
