import 'package:aio_sport/controllers/profile_controller.dart';
import 'package:aio_sport/models/add_ground_req_model.dart';
import 'package:aio_sport/models/venue_details_model.dart';
import 'package:aio_sport/themes/custom_theme.dart';
import 'package:aio_sport/widgets/input_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

typedef MyCallback = void Function(AddOn value);

class AddonFormWidget extends StatefulWidget {
  final int index;
  final MyCallback? addonData;
  final Grounditem? addonOldData;
  const AddonFormWidget({super.key, required this.index, this.addonData, this.addonOldData});

  @override
  State<AddonFormWidget> createState() => _AddonFormWidgetState();
}

class _AddonFormWidgetState extends State<AddonFormWidget> with AutomaticKeepAliveClientMixin {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final quantityController = TextEditingController();
  final profileController = Get.find<ProfileController>();
  final AddOn _addOn = AddOn(itemName: "", quality: "", rentPrice: "");
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.addonOldData != null) {
      nameController.text = widget.addonOldData!.itemName ?? "";
      priceController.text = widget.addonOldData!.rentPrice ?? "0";
      quantityController.text = "${widget.addonOldData!.quality}";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Material(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Form(
              key: _formKey,
              onChanged: () => _formKey.currentState!.validate(),
              child: Column(
                children: [
                  InputFieldWidget(
                    textEditingController: nameController,
                    label: "Item name",
                    inputAction: TextInputAction.next,
                    onChange: (value) {
                      // profileController.addGroundFormsList[widget.groundIndex].value.addOn[widget.index].itemName = value;
                      if (widget.addonData != null) {
                        _addOn.itemName = value;
                        widget.addonData!(_addOn);
                      }
                    },
                    validate: (value) => value != null ? null : "Error",
                  ),
                  Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: InputFieldWidget(
                          textEditingController: priceController,
                          label: "Rent price",
                          prefixText: "OMR\t",
                          inputAction: TextInputAction.next,
                          textColor: CustomTheme.green,
                          onChange: (value) {
                            if (widget.addonData != null) {
                              _addOn.rentPrice = value;
                              widget.addonData!(_addOn);
                            }
                            // profileController.addGroundFormsList[widget.groundIndex].value.addOn[widget.index].rentPrice = value;
                          },
                          inputType: TextInputType.number,
                          validate: (value) => value != null ? null : "Error",
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Flexible(
                        flex: 1,
                        child: InputFieldWidget(
                          textEditingController: quantityController,
                          label: "Quantity",
                          inputType: TextInputType.number,
                          onChange: (value) {
                            if (widget.addonData != null) {
                              _addOn.quality = value;
                              widget.addonData!(_addOn);
                            }
                            // profileController.addGroundFormsList[widget.groundIndex].value.addOn[widget.index].quality = value;
                          },
                          validate: (value) => value != null ? null : "Error",
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  void checkFormData() {
    profileController.addGroundsFormSubmitted.value = false;
    _formKey.currentState!.validate();
    setState(() {});
  }
}
