import 'package:aio_sport/controllers/profile_controller.dart';
import 'package:aio_sport/models/form_info.dart';
import 'package:aio_sport/models/sports_data_model.dart';
import 'package:aio_sport/themes/custom_theme.dart';
import 'package:aio_sport/widgets/input_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

typedef MyCallback = void Function(FormInfo value);

class AddGroundForm extends StatefulWidget {
  final Sport sport;
  final FormInfo? oldfFormInfo;
  final MyCallback formInfo;
  const AddGroundForm({super.key, required this.sport, required this.formInfo, this.oldfFormInfo});

  @override
  State<AddGroundForm> createState() => _AddGroundFormState();
}

class _AddGroundFormState extends State<AddGroundForm> {
  final nameController = TextEditingController();
  final rentController = TextEditingController();
  final profile = Get.find<ProfileController>();
  late String groundSize;
  String playerSize = "1";
  Rx<bool> indoor = true.obs;
  List<String> groundSizes = <String>[];
  List<String> playerSizes = List.generate(20, (index) => "${index + 1}");
  FormInfo formData = FormInfo(
    groundName: "", groundSize: "", groundUnits: "", hourlyRent: "", isIndoor: true, sportId: 1, morningTiming: [],
    eveningTiming: [], // addOn: []
  );

  @override
  void initState() {
   // WidgetsBinding.instance.addPostFrameCallback((_) {
      groundSizes.assignAll(widget.sport.sportsizes.map((e) => e.size).where((size) => size != null).toList());
      groundSize = groundSizes.first;
      playerSize = playerSizes.first;
      formData.sportId = widget.sport.id;
      formData.groundSize = groundSize;
      formData.isIndoor = indoor.value;
      widget.formInfo(formData);
      if (widget.oldfFormInfo != null) {
        setFormInfo();
      }
      setState(() {});
    //});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Material(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Ground type", style: Get.textTheme.displaySmall),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: constraints.maxWidth * 0.35,
                      child: InkWell(
                        onTap: () {
                          indoor.value = true;
                          formData.isIndoor = true;
                          widget.formInfo(formData);
                        },
                        child: Row(
                          children: [
                            Radio<bool>(
                              value: true,
                              activeColor: CustomTheme.iconColor,
                              groupValue: indoor.value,
                              onChanged: (value) {
                                if (value != null) {}
                              },
                            ),
                            Text("Indoor", style: Get.textTheme.labelMedium),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: constraints.maxWidth * 0.35,
                      child: InkWell(
                        onTap: () {
                          indoor.value = false;
                          formData.isIndoor = false;
                          widget.formInfo(formData);
                        },
                        child: Row(
                          children: [
                            Radio<bool>(
                              value: false,
                              groupValue: indoor.value,
                              activeColor: CustomTheme.iconColor,
                              onChanged: (value) {
                                if (value != null) {
                                  indoor.value = value;
                                }
                              },
                            ),
                            Text("Outdoor", style: Get.textTheme.labelMedium),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: InputFieldWidget(
                    textEditingController: nameController,
                    label: "Ground name",
                    capitalization: TextCapitalization.words,
                    onChange: (name) {
                      formData.groundName = name;
                      widget.formInfo(formData);
                    },
                  ),
                ),
                Row(
                  children: [
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Ground size", style: Get.textTheme.displaySmall),
                          DropdownButton<String>(
                            value: groundSize,
                            icon: const Icon(Icons.keyboard_arrow_down_rounded),
                            isExpanded: true,
                            elevation: 8,
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            onChanged: (String? value) {
                              // This is called when the user selects an item.
                              if (value != null) {
                                groundSize = value;
                                formData.groundSize = value;
                                widget.formInfo(formData);
                                setState(() {});
                              }
                            },
                            items: groundSizes.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value, style: Get.textTheme.headlineMedium),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Unit", style: Get.textTheme.displaySmall),
                          DropdownButton<String>(
                            value: playerSize,
                            icon: const Icon(Icons.keyboard_arrow_down_rounded),
                            isExpanded: true,
                            elevation: 8,
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            onChanged: (String? value) {
                              // This is called when the user selects an item.
                              if (value != null) {
                                playerSize = value;
                                formData.groundUnits = value;
                                widget.formInfo(formData);
                                setState(() {});
                              }
                            },
                            items: playerSizes.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value, style: Get.textTheme.headlineMedium),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: InputFieldWidget(
                    textEditingController: rentController,
                    label: "Ground hourly rent",
                    inputType: TextInputType.number,
                    prefixText: "OMR",
                    textColor: CustomTheme.green,
                    onChange: (rent) {
                      formData.hourlyRent = rent;
                      widget.formInfo(formData);
                    },
                  ),
                ),
              ],
            );
          }),
        ),
      );
    });
  }

  void setFormInfo() {
    nameController.text = widget.oldfFormInfo!.groundName;
    rentController.text = widget.oldfFormInfo!.hourlyRent;
    groundSize = widget.oldfFormInfo!.groundSize == "N/A" ? groundSizes.first : widget.oldfFormInfo!.groundSize;
    indoor.value = widget.oldfFormInfo!.isIndoor;
    playerSize = widget.oldfFormInfo!.groundUnits == "N/A" ? "1" : widget.oldfFormInfo!.groundUnits;
  }
}
