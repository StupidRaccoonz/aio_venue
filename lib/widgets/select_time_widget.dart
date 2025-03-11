import 'package:aio_sport/themes/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scaled_size/scaled_size.dart';

typedef MyCallback = void Function(List<String> val);

class SelectTimeWidget extends StatefulWidget {
  final int itemCount;
  final int startingIndexValue;
  final int removingZeroAtIndex;
  final MyCallback callback;
  const SelectTimeWidget({super.key, required this.itemCount, required this.startingIndexValue, required this.removingZeroAtIndex, required this.callback});

  @override
  State<SelectTimeWidget> createState() => _SelectTimeWidgetState();
}

class _SelectTimeWidgetState extends State<SelectTimeWidget> {
  List<int> selectedTimes = [];
  List<String> timesList = [];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Material(
        child: GridView.builder(
          itemCount: widget.itemCount,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: constraints.maxWidth * 0.31,
            crossAxisSpacing: 16.0,
            mainAxisExtent: 25.rfs,
            mainAxisSpacing: 8.0,
          ),
          itemBuilder: (context, index) {
            String time =
                "${index < widget.removingZeroAtIndex ? '0' : ''}${index + widget.startingIndexValue}:00 - ${index < (widget.removingZeroAtIndex - 1) ? '0' : ''}${index + (widget.startingIndexValue + 1)}:00";
            if (widget.startingIndexValue == 0 && index == 0) {
              String value = "12:00 - 01:00";
              return InkWell(
                onTap: () {
                  if (!selectedTimes.contains(index)) {
                    selectedTimes.add(index);
                    timesList.add(value);
                    setState(() {});
                  } else {
                    selectedTimes.removeWhere((element) => element == index);
                    timesList.removeWhere((element) => element == value);
                    setState(() {});
                  }
                  widget.callback(timesList);
                },
                child: Material(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: selectedTimes.contains(index) ? CustomTheme.iconColor : CustomTheme.borderColor, width: 2.0),
                    borderRadius: BorderRadius.circular(5.br),
                  ),
                  color: selectedTimes.contains(index) ? CustomTheme.iconColor : Colors.white,
                  child: Center(
                    child: Text(
                      value,
                      style: Get.textTheme.headlineSmall!
                          .copyWith(color: selectedTimes.contains(index) ? Colors.white : CustomTheme.textColor, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              );
            }
            return InkWell(
              onTap: () {
                if (!selectedTimes.contains(index)) {
                  selectedTimes.add(index);
                  timesList.add(time);
                  setState(() {});
                } else {
                  selectedTimes.removeWhere((element) => element == index);
                  timesList.removeWhere((element) => element == time);
                  setState(() {});
                }
                widget.callback(timesList);
              },
              child: Material(
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: selectedTimes.contains(index) ? CustomTheme.iconColor : CustomTheme.borderColor),
                  borderRadius: BorderRadius.circular(5.br),
                ),
                color: selectedTimes.contains(index) ? CustomTheme.iconColor : Colors.white,
                child: Center(
                  child: Text(
                    time,
                    style: Get.textTheme.headlineSmall!
                        .copyWith(color: selectedTimes.contains(index) ? Colors.white : CustomTheme.textColor, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
