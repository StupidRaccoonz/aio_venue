import 'package:flutter/material.dart';

import 'input_field_widget.dart';

class FormWidget extends StatefulWidget {
  final int groundIndex, addonIndex;
  const FormWidget({super.key, required this.groundIndex, required this.addonIndex});

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> with AutomaticKeepAliveClientMixin {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final quantityController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InputFieldWidget(
              textEditingController: nameController,
              label: "Item name",
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
                    validate: (value) => value != null ? null : "Error",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
