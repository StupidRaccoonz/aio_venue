import 'dart:developer';

import 'package:aio_sport/controllers/profile_controller.dart';
// import 'package:aio_sport/models/add_ground_req_model.dart';
import 'package:aio_sport/themes/custom_theme.dart';
import 'package:aio_sport/widgets/input_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scaled_size/scaled_size.dart';

import 'addon_form_widget.dart';
import 'select_time_widget.dart';

class GroundInfoWidget extends StatefulWidget {
  final int index;
  const GroundInfoWidget({super.key, required this.index});

  @override
  State<GroundInfoWidget> createState() => _GroundInfoWidgetState();
}

class _GroundInfoWidgetState extends State<GroundInfoWidget> with AutomaticKeepAliveClientMixin {
  List<String> units = List.generate(20, (index) => "${index + 1}");

  final unitController = TextEditingController();
  final sizeController = TextEditingController();
  final nameController = TextEditingController();
  final rentController = TextEditingController();
  final profileController = Get.find<ProfileController>();
  final pageController = PageController();
  int selectedAddon = 0;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LayoutBuilder(builder: (context, constraints) {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20.0),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 20.0), child: Text("Ground details", style: Get.textTheme.titleLarge)),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 20.0), child: Text("Ground type", style: Get.textTheme.displaySmall)),
            // starting of form
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Form(
                key: _formKey,
                child: Obx(() {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: constraints.maxWidth * 0.4,
                            child: RadioListTile<bool>(
                              value: true,
                              title: Text("Indoor", style: Get.textTheme.labelMedium),
                              groupValue: profileController.addGroundFormsList[widget.index].value.isIndoor,
                              onChanged: (value) {
                                profileController.addGroundFormsList[widget.index].value.isIndoor = value ?? true;
                                profileController.addGroundFormsList[widget.index].refresh();
                              },
                            ),
                          ),
                          SizedBox(
                            width: constraints.maxWidth * 0.4,
                            child: RadioListTile<bool>(
                              value: false,
                              title: Text("Outdoor", style: Get.textTheme.labelMedium),
                              groupValue: profileController.addGroundFormsList[widget.index].value.isIndoor,
                              onChanged: (value) {
                                profileController.addGroundFormsList[widget.index].value.isIndoor = value ?? false;
                                profileController.addGroundFormsList[widget.index].refresh();
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      InputFieldWidget(
                        label: "Ground name",
                        textEditingController: nameController,
                        validate: (value) => value == null ? "Ground name is reuqired" : null,
                        onChange: (value) {
                          profileController.addGroundFormsList[profileController.addGroundFormSelectedGround.value].value.groundName = value;
                        },
                      ),
                      const SizedBox(height: 16.0),
                      // Drop downs
                      Row(
                        children: [
                          Flexible(flex: 2, fit: FlexFit.tight, child: Text("Ground size", style: Get.textTheme.labelMedium)),
                          Flexible(flex: 1, fit: FlexFit.tight, child: Text("Units", style: Get.textTheme.labelMedium)),
                        ],
                      ),
                      Row(
                        children: [
                          Flexible(
                            flex: 2,
                            child: Obx(() {
                              return profileController.selectedSportsList.isNotEmpty
                                  ? DropdownButtonFormField<String>(
                                      value: profileController.addGroundFormsList[widget.index].value.groundSize,
                                      hint: const Text("select ground size"),
                                      style: Get.textTheme.labelMedium,
                                      items: profileController.selectedSportsList[profileController.addFormSelectedSport.value].sportsizes
                                          .map<DropdownMenuItem<String>>((value) {
                                        return DropdownMenuItem<String>(
                                          value: value.size,
                                          child: Text(value.size),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        if (value != null) {
                                          profileController.addGroundFormsList[widget.index].value.groundSize = value;

                                          profileController.addGroundFormsList.refresh();
                                        }
                                      },
                                    )
                                  : const Material();
                            }),
                          ),
                          const SizedBox(width: 24.0),
                          Flexible(
                            flex: 1,
                            child: DropdownButtonFormField<String>(
                              value: profileController.addGroundFormsList[widget.index].value.groundUnits,
                              items: units.map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  profileController.addGroundFormsList[profileController.addGroundFormSelectedGround.value].value.groundUnits = value;
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      InputFieldWidget(
                        label: "Ground hourly rent",
                        textEditingController: rentController,
                        inputType: TextInputType.number,
                        prefixText: "OMR\t",
                        onChange: (value) {
                          profileController.addGroundFormsList[profileController.addGroundFormSelectedGround.value].value.hourlyRent = value;
                        },
                        validate: (value) => value == null ? "Rent field is reuqired" : null,
                      ),
                      const SizedBox(height: 16.0),
                    ],
                  );
                }),
              ),
            ),
            Divider(color: CustomTheme.textColorLight.withOpacity(0.5), height: 2.0),
            SizedBox(
              height: 45.rh,
              child: Obx(() {
                return Row(
                  children: [
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: ListView.builder(
                        itemCount: 1,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: selectedAddon == index
                                ? BoxDecoration(border: Border(bottom: BorderSide(width: 1.5, color: CustomTheme.textColorLight)))
                                : null,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: InkWell(
                                onTap: () {
                                  if (selectedAddon != index) {
                                    selectedAddon = index;
                                    pageController.animateToPage(index, duration: const Duration(milliseconds: 200), curve: Curves.ease);
                                    setState(() {});
                                  }
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("Item ${index + 1}", style: Get.textTheme.labelMedium),
                                    selectedAddon == index
                                        ? InkWell(
                                            onTap: () {
                                              // profileController.addGroundFormsList[widget.index].value.addOn.removeAt(index);
                                              profileController.addGroundFormsList[widget.index].refresh();
                                            },
                                            child: Icon(Icons.close, size: 20.rh),
                                          )
                                        : const SizedBox()
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Material(
                      color: CustomTheme.iconColor,
                      elevation: 4.0,
                      borderRadius: const BorderRadius.horizontal(left: Radius.circular(16.0)),
                      child: InkWell(
                        borderRadius: const BorderRadius.horizontal(left: Radius.circular(16.0)),
                        onTap: () {
                          // profileController.addGroundFormsList[widget.index].value.addOn.add(AddOn(quality: "", itemName: "", rentPrice: ""));
                          profileController.addGroundFormsList[widget.index].refresh();
                          print("add Item =============================>");
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Icon(Icons.add, size: 25.rh, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
            Divider(color: CustomTheme.textColorLight.withOpacity(0.5), height: 2.0),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
              child: Text("Add ons", style: Get.textTheme.displayMedium),
            ),
            Obx(() {
              return SizedBox(
                height: 145.rh,
                child: PageView.builder(
                  controller: pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    // return AddonFormWidget(index: index, groundIndex: profileController.addGroundFormSelectedGround.value);
                    return AddonFormWidget(index: index);
                  },
                ),
              );
            }),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
              child: Text("Ground availability", style: Get.textTheme.displayMedium),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text("Ante meridiem (AM)", style: Get.textTheme.displaySmall),
            ),
            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SizedBox(
                  height: 60.rh,
                  child: SelectTimeWidget(
                    itemCount: 6,
                    startingIndexValue: 6,
                    removingZeroAtIndex: 4,
                    callback: (List<String> val) {
                      log("morning selected time $val");
                      profileController.addGroundFormsList[profileController.addGroundFormSelectedGround.value].value.morningTiming = val;
                    },
                  )),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text("Post meridiem (PM)", style: Get.textTheme.displaySmall),
            ),
            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SizedBox(
                  height: 124.rfs,
                  child: SelectTimeWidget(
                    itemCount: 10,
                    startingIndexValue: 0,
                    removingZeroAtIndex: 5,
                    callback: (List<String> val) {
                      log("evening selected time $val");
                      profileController.addGroundFormsList[profileController.addGroundFormSelectedGround.value].value.eveningTiming = val;
                    },
                  )),
            ),

            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "We have selected ground availability automatically as per your opening and closing time you can modify them as per your liking.",
                style: Get.textTheme.displaySmall,
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      );
    });
  }

  void checkFormData() {
    _formKey.currentState!.validate();
  }

  @override
  bool get wantKeepAlive => true;
}
