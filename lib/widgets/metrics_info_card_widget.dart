import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatCard extends StatelessWidget {
  final String label;
  final String value;

  StatCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10,horizontal: MediaQuery.of(context).size.width * 0.02),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.068,
                  width: MediaQuery.of(context).size.width * 0.02,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)
                  ),
                ),
              ],
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.03),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value,style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.024,fontWeight: FontWeight.bold,color: Color(0xff15192C))),
                SizedBox(height: MediaQuery.of(context).size.height * 0.021),
                Text(label,style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.022,fontWeight: FontWeight.bold,color: Color(0xff6E6F73))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}