import 'dart:math';

import 'package:aio_sport/objectbox.g.dart';
import 'package:aio_sport/screens/venue/long_term_bookings.dart';
import 'package:aio_sport/screens/venue/short_term_bookings.dart';
import 'package:aio_sport/themes/custom_theme.dart';
import 'package:aio_sport/widgets/app_bar_widget.dart';
import 'package:aio_sport/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:scaled_size/scaled_size.dart';

import '../../constants/constants.dart';

class VenueBookingsScreen extends StatefulWidget {
  const VenueBookingsScreen({super.key});

  @override
  State<VenueBookingsScreen> createState() => _VenueBookingsScreenState();
}

class _VenueBookingsScreenState extends State<VenueBookingsScreen> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    super.build(context);
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(double.maxFinite, 10.vh),
          child: const AppbarWidget(
            title: "Bookings",
            //  leading: SizedBox(),
          )),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(labelColor: Colors.black, indicatorColor: Colors.black, unselectedLabelColor: CustomTheme.grey, indicatorSize: TabBarIndicatorSize.tab, tabs: [
              Tab(
                height: 36.rh,
                child: const Text(
                  "Short term",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              Tab(
                  height: 36.rh,
                  child: const Text(
                    "Long term",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  )),
            ]),
            const Expanded(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  ShortTermBookings(),
                  LongTermBookings(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return MyDialog();
              // Dialog(
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(20),
              //   ),
              //   child:
              //   Container(
              //     padding: EdgeInsets.all(20),
              //     width: screenWidth * 0.8,
              //     height: screenHeight * 0.632,
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Container(
              //           height: screenHeight * 0.291,
              //           width: screenWidth * 0.7,
              //           decoration: BoxDecoration(border: Border.all(color: Colors.grey),borderRadius: BorderRadius.circular(10)),
              //           child: Padding(
              //             padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.03),
              //             child: Column(
              //               mainAxisAlignment: MainAxisAlignment.center,
              //               children: _buttonOptions.map(
              //                       (e) => RadioListTile(
              //                           value: e,
              //                           groupValue: _selectValue,
              //                           onChanged: (value) {
              //                               setState(() {
              //                                 _selectValue = value!;
              //                               });
              //                               print("yeeeee :- $_selectValue");
              //                           },
              //                         title: Text("$e"),
              //                       ),
              //               ).toList()
              //             ),
              //           ),
              //         ),
              //         SizedBox(height: screenHeight * 0.01),
              //         TextFormField(
              //           decoration: InputDecoration(
              //             suffixIcon: IconButton(onPressed: (){
              //               showTimePicker(context: context, initialTime: TimeOfDay.now());
              //               // showDatePicker(context: context, firstDate: DateTime.now(), lastDate: DateTime(3000,01,01));
              //             }, icon: Icon(Icons.date_range,color: Color(0xff5640FB),size: screenHeight * 0.03,)),
              //               labelText: "From",
              //               labelStyle: TextStyle(
              //                   fontSize: screenHeight * 0.03,
              //                   color: Color(0xff6E6F73)),
              //               border: UnderlineInputBorder(
              //                   borderSide: BorderSide(
              //                       color: Color(0xff6E6F73),
              //                   ),
              //               ),
              //           ),
              //         ),
              //         TextFormField(
              //           decoration: InputDecoration(
              //             suffixIcon: IconButton(onPressed: (){
              //               showTimePicker(context: context, initialTime: TimeOfDay.now());
              //               // showDatePicker(context: context, firstDate: DateTime.now(), lastDate: DateTime(3000,01,01));
              //               }, icon: Icon(Icons.date_range,color: Color(0xff5640FB),size: screenHeight * 0.03,)),
              //             labelText: "To",
              //             labelStyle: TextStyle(
              //                 fontSize: screenHeight * 0.03,
              //                 color: Color(0xff6E6F73)),
              //             border: UnderlineInputBorder(
              //               borderSide: BorderSide(
              //                 color: Color(0xffE9E8EB),
              //               ),
              //             ),
              //           ),
              //         ),
              //         SizedBox(height: screenHeight * 0.02),
              //         GestureDetector(
              //           onTap: () {
              //             Navigator.pop(context);
              //           },
              //           child: Container(
              //             height: screenHeight * 0.056,
              //             width: double.infinity,
              //             decoration: BoxDecoration(
              //               color: Color(0xffFC6B21),
              //               borderRadius: BorderRadius.circular(50),
              //             ),
              //             child: Center(
              //               child: Text('Download as excel',
              //                 style: TextStyle(
              //                     color: Colors.white,
              //                     fontWeight: FontWeight.bold,
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // );
            },
          );
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.br)),
        backgroundColor: CustomTheme.appColorSecondary,
        splashColor: Colors.white,
        child: const Icon(Icons.file_download_outlined, color: Colors.white),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class MyDialog extends StatefulWidget {
  @override
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();
  int _selectedValue = 1;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return AlertDialog(
      content: Form(
        key: _formKey, // Add the form key
        child: Container(
          padding: EdgeInsets.all(20),
          width: screenWidth * 0.8,
          height: screenHeight * 0.632,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  // height: screenHeight * 0.291,
                  // width: screenWidth * 0.7,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.03),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RadioListTile<int>(
                          title: Text(
                            'Download both',
                            style: TextStyle(fontSize: 20),
                          ),
                          value: 1,
                          groupValue: _selectedValue,
                          onChanged: (int? value) {
                            setState(() {
                              _selectedValue = value!;
                            });
                          },
                        ),
                        RadioListTile<int>(
                          title: Text(
                            'Only long term download',
                            style: TextStyle(fontSize: 20),
                          ),
                          value: 2,
                          groupValue: _selectedValue,
                          onChanged: (int? value) {
                            setState(() {
                              _selectedValue = value!;
                            });
                          },
                        ),
                        RadioListTile<int>(
                          title: Text(
                            'Only long term download',
                            style: TextStyle(fontSize: 20),
                          ),
                          value: 3,
                          groupValue: _selectedValue,
                          onChanged: (int? value) {
                            setState(() {
                              _selectedValue = value!;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                TextFormField(
                  readOnly: true,
                  controller: fromController,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () async {
                        DateTime? selectedDate = await showDatePicker(
                          context: context,
                          firstDate: DateTime(1900, 01, 01),
                          lastDate: DateTime(3000, 12, 31),
                          initialDate: DateTime.now(),
                        );
                        if (selectedDate != null) {
                          setState(() {
                            fromController.text = "${selectedDate.toLocal()}".split(' ')[0];
                          });
                        }
                      },
                      icon: Icon(
                        Icons.date_range,
                        color: Color(0xff5640FB),
                        size: screenHeight * 0.03,
                      ),
                    ),
                    labelText: "From",
                    labelStyle: TextStyle(
                      fontSize: screenHeight * 0.03,
                      color: Color(0xff6E6F73),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff6E6F73),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a "From" date';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  readOnly: true,
                  controller: toController,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () async {
                        DateTime? selectedDate = await showDatePicker(
                          context: context,
                          firstDate: DateTime(1900, 01, 01),
                          lastDate: DateTime(3000, 12, 31),
                          initialDate: DateTime.now(),
                        );
                        if (selectedDate != null) {
                          setState(() {
                            toController.text = "${selectedDate.toLocal()}".split(' ')[0];
                          });
                        }
                      },
                      icon: Icon(
                        Icons.date_range,
                        color: Color(0xff5640FB),
                        size: screenHeight * 0.03,
                      ),
                    ),
                    labelText: "To",
                    labelStyle: TextStyle(
                      fontSize: screenHeight * 0.03,
                      color: Color(0xff6E6F73),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xffE9E8EB),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a "To" date';
                    }
                    return null;
                  },
                ),
                SizedBox(height: screenHeight * 0.02),
                GestureDetector(
                  onTap: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      if (_selectedValue == null) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Please select an option from the radio buttons'),
                        ));
                      } else {
                        Constants.showSnackbar("Download", "Success!!");
                        Navigator.pop(context);
                      }
                    }
                  },
                  child: Container(
                    height: screenHeight * 0.056,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xffFC6B21),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                      child: Text(
                        'Download as excel',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
