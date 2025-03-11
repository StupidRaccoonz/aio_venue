import 'package:aio_sport/controllers/profile_controller.dart';
import 'package:aio_sport/models/sports_data_model.dart';
import 'package:aio_sport/themes/custom_theme.dart';
import 'package:aio_sport/widgets/input_field_widget.dart';
import 'package:aio_sport/widgets/my_button.dart';
import 'package:aio_sport/widgets/selection_chip_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scaled_size/scaled_size.dart';

class SportsBottomSheet extends StatefulWidget {
  final List<Sport> selectedList;
  const SportsBottomSheet({super.key, required this.selectedList});

  @override
  State<SportsBottomSheet> createState() => _SportsBottomSheetState();
}

class _SportsBottomSheetState extends State<SportsBottomSheet> {
  final profileController = Get.find<ProfileController>();
  List<Sport> selectedList = [];
  List<Sport> selectedPopularSports = [];
  // Constants.popularSportsList.map((e) => SelectedSportModel(isSelected: false, sportName: e, sportImage: "sportImage")).toList();
  List<Sport> selectedFitnessSports = [];
  // Constants.fitnessSportsList.map((e) => SelectedSportModel(isSelected: false, sportName: e, sportImage: "sportImage")).toList();
  List<Sport> selectedWaterSports = [];
  // Constants.waterSportsList.map((e) => SelectedSportModel(isSelected: false, sportName: e, sportImage: "sportImage")).toList();

  final GlobalKey<TooltipState> tooltipKey1 = GlobalKey<TooltipState>();
  final GlobalKey<TooltipState> tooltipKey2 = GlobalKey<TooltipState>();
  final GlobalKey<TooltipState> tooltipKey3 = GlobalKey<TooltipState>();

  @override
  void initState() {
    selectedList.assignAll(widget.selectedList);
    for (Sport? sport in profileController.sportsList) {
      if (sport!.id >= 1 && sport.id <= 5) {
        selectedPopularSports.add(sport);
      }
      if (sport.id >= 6 && sport.id <= 9) {
        selectedFitnessSports.add(sport);
      }
      if (sport.id >= 10) {
        selectedWaterSports.add(sport);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.vertical(top: Radius.circular(10.br)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            Column(
              children: [
                const InputFieldWidget(label: "Search sports", leadingIcon: Icon(Icons.search)),
                SizedBox(height: 10.rh),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Row(
                        children: [
                          Text(
                            "Popular Sports",
                            style: Get.textTheme.displayMedium?.copyWith(color: CustomTheme.textColor, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(width: 5,),
                          Tooltip(
                            margin: EdgeInsets.only(left: 20,right: 20),
                            key: tooltipKey1,
                            message: 'This is a suggestion text.',
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            preferBelow: false,
                            child: InkWell(
                              onTap: () {
                                tooltipKey1.currentState?.ensureTooltipVisible();
                              },
                              child: const Icon(
                                CupertinoIcons.exclamationmark_circle_fill,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text("Select the sport you want to coach", style: Get.textTheme.bodyMedium),
                      SizedBox(height: 5.rh),
                      SizedBox(
                        height: getheight(selectedPopularSports.length) + 16,
                        child: GridView.builder(
                          itemCount: selectedPopularSports.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return SelectionChip(
                                isAdded: false,
                                sportModel: selectedPopularSports[index],
                                isSelected: selectedList.contains(selectedPopularSports[index]),
                                callBack: (val) {
                                  if (val) {
                                    selectedList.addIf(val, selectedPopularSports[index]);
                                  } else {
                                    selectedList.remove(selectedPopularSports[index]);
                                  }
                                });
                          },
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 3 / 4,
                            mainAxisExtent: 40.rh,
                            mainAxisSpacing: 6.0,
                            crossAxisSpacing: 4.0,
                          ),
                        ),
                      ),
                      SizedBox(height: 2.rh),
                      Row(
                        children: [
                          Text(
                            "Fitness Sports",
                            style: Get.textTheme.displayMedium?.copyWith(color: CustomTheme.textColor, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(width: 5,),
                          Tooltip(
                            margin: EdgeInsets.only(left: 20,right: 20),
                            key: tooltipKey2,
                            message: 'This is a suggestion text.',
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            preferBelow: false,
                            child: InkWell(
                              onTap: () {
                                tooltipKey2.currentState?.ensureTooltipVisible();
                              },
                              child: const Icon(
                                CupertinoIcons.exclamationmark_circle_fill,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text("Select the sport you want to coach", style: Get.textTheme.bodyMedium),
                      SizedBox(
                        height: getheight(selectedFitnessSports.length) + 16,
                        child: GridView.builder(
                          itemCount: selectedFitnessSports.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return SelectionChip(
                                isAdded: false,
                                sportModel: selectedFitnessSports[index],
                                isSelected: selectedList.contains(selectedFitnessSports[index]),
                                callBack: (val) {
                                  if (val) {
                                    selectedList.addIf(val, selectedFitnessSports[index]);
                                  } else {
                                    selectedList.remove(selectedFitnessSports[index]);
                                  }
                                });
                          },
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 3 / 4,
                            mainAxisExtent: 40.rh,
                            mainAxisSpacing: 6.0,
                            crossAxisSpacing: 4.0,
                          ),
                        ),
                      ),
                      SizedBox(height: 2.rh),
                      Row(
                        children: [
                          Text(
                            "Water Sports",
                            style: Get.textTheme.displayMedium?.copyWith(color: CustomTheme.textColor, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(width: 5,),
                          Tooltip(
                            margin: EdgeInsets.only(left: 20,right: 20),
                            key: tooltipKey3,
                            message: 'This is a suggestion text.',
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            preferBelow: false,
                            child: InkWell(
                              onTap: () {
                                tooltipKey3.currentState?.ensureTooltipVisible();
                              },
                              child: const Icon(
                                CupertinoIcons.exclamationmark_circle_fill,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text("Select the sport you want to coach", style: Get.textTheme.bodyMedium),
                      SizedBox(height: 1.rh),
                      SizedBox(
                        height: getheight(selectedWaterSports.length) + 16,
                        child: GridView.builder(
                          itemCount: selectedWaterSports.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return SelectionChip(
                                isAdded: false,
                                sportModel: selectedWaterSports[index],
                                isSelected: selectedList.contains(selectedWaterSports[index]),
                                callBack: (val) {
                                  if (val) {
                                    selectedList.addIf(val, selectedWaterSports[index]);
                                  } else {
                                    selectedList.remove(selectedWaterSports[index]);
                                  }
                                });
                          },
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 3 / 4,
                            mainAxisExtent: 40.rh,
                            mainAxisSpacing: 6.0,
                            crossAxisSpacing: 4.0,
                          ),
                        ),
                      ),
                      SizedBox(height: 60.rh)
                    ]),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 16.0,
              right: 0.0,
              left: 0.0,
              child: MyButton(
                text: "ADD",
                onPressed: () {
                  Get.back(result: selectedList);
                  print("selected sports ------>");
                  print("${selectedList.length} ---->");
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  double getheight(int length) {
    if (length.isEven) {
      return (length * 50.rh) / 2;
    }

    return ((length + 1) * 50.rh) / 2;
  }
}
