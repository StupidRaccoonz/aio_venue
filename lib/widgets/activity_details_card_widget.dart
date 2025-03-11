import 'package:flutter/material.dart';

class ActivityDetailsCardWidget extends StatefulWidget {
  final String fees, sport, teamSize, date, time;
  const ActivityDetailsCardWidget({super.key, required this.fees,required this.sport, required this.teamSize, required this.date, required this.time});

  @override
  State<ActivityDetailsCardWidget> createState() => _ActivityDetailsCardWidgetState();
}

class _ActivityDetailsCardWidgetState extends State<ActivityDetailsCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xffE9E8EB)),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Entry fees",style: TextStyle(color: Color(0xff6E6F73),fontSize: 20),),
                Text("\$ ${widget.fees}",style: TextStyle(color: Color(0xff25A70F),fontWeight: FontWeight.bold,fontSize: 24),),
              ],
            ),
            Divider(color: Color(0xffE9E8EB)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Sport",style: TextStyle(color: Color(0xff6E6F73),fontSize: 20),),
                Text(widget.sport,style: TextStyle(color: Color(0xff15192C),fontWeight: FontWeight.bold,fontSize: 24),),
              ],
            ),
            Divider(color: Color(0xffE9E8EB)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Team size",style: TextStyle(color: Color(0xff6E6F73),fontSize: 20),),
                Text(widget.teamSize,style: TextStyle(color: Color(0xff15192C),fontWeight: FontWeight.bold,fontSize: 24),),
              ],
            ),
            Divider(color: Color(0xffE9E8EB)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Date",style: TextStyle(color: Color(0xff6E6F73),fontSize: 20),),
                Text(widget.date,style: TextStyle(color: Color(0xff15192C),fontWeight: FontWeight.bold,fontSize: 24),),
              ],
            ),
            Divider(color: Color(0xffE9E8EB)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Time",style: TextStyle(color: Color(0xff6E6F73),fontSize: 20),),
                Text(widget.time,style: TextStyle(color: Color(0xff15192C),fontWeight: FontWeight.bold,fontSize: 24),),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
