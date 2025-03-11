import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VenueActivityRulesRegulationCardWidget extends StatefulWidget {
  final String rules;
  const VenueActivityRulesRegulationCardWidget({super.key, required this.rules});

  @override
  State<VenueActivityRulesRegulationCardWidget> createState() => _VenueActivityRulesRegulationCardWidgetState();
}

class _VenueActivityRulesRegulationCardWidgetState extends State<VenueActivityRulesRegulationCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xffE9E8EB)),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 3,
          itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(100)
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(child: Text(widget.rules,style: TextStyle(color: Color(0xff6E6F73),fontSize: 20),)),
                  ],
                ),
              ],
            ),
          );
        },),
      ),
    );
  }
}
