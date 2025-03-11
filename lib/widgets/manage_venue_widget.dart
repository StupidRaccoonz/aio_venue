import 'package:aio_sport/services/server_urls.dart';
import 'package:aio_sport/themes/custom_theme.dart';
import 'package:aio_sport/widgets/image_widget.dart';
import 'package:aio_sport/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageVenueWidget extends StatefulWidget {
  final String imageUrl, venueName, venueCity;
  final int index;
  // final void Function() onDelete;

  const ManageVenueWidget({super.key, required this.imageUrl, required this.venueName, required this.venueCity, required this.index, // required this.onDelete
  });

  @override
  State<ManageVenueWidget> createState() => _ManageVenueWidgetState();
}

class _ManageVenueWidgetState extends State<ManageVenueWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          print("vivek ========>");
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: ImageWidget(
                  imageurl: "${ServerUrls.mediaUrl}venue/${widget.imageUrl}",
                  height: 50.0,
                  width: 50.0,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.venueName,
                      style: Get.textTheme.labelSmall!.copyWith(color: CustomTheme.appColor),
                    ),
                    Text(
                      widget.venueCity,
                      style: Get.textTheme.displaySmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return SimpleDialog(
                        title: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Image.asset('assets/icons/remove_venue.png',height: 80,width: 80,),
                              SizedBox(height: 15),
                              Text("Remove Venue",style:TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                              SizedBox(height: 10),
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(text:"We will stop any future booking but currently you will have booking till ",
                                  style: TextStyle(color: Colors.grey,fontSize: 17),
                                  children: [
                                    TextSpan(
                                      text: '12 Nov 2022; 03:00 PM.',
                                      style: TextStyle(color: Colors.black87)
                                    ),
                                    TextSpan(
                                        text: 'your venue will stay active til this date and will be deleted after ',
                                    ),
                                    TextSpan(
                                        text: '12 Nov 2022; 03:00 PM.',
                                        style: TextStyle(color: Colors.black87)
                                    ),
                                  ]
                                ),
                              ),
                              SizedBox(height: 25),
                              Container(
                                height: MediaQuery.of(context).size.height * 0.06,
                                width: MediaQuery.of(context).size.width * 1,
                                decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Center(
                                  child: Text("Remove venue",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.only(),
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'Not now',
                                      style: TextStyle(
                                          color: Colors.orange,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );

                },
                padding: const EdgeInsets.all(12.0),
                icon: Icon(Icons.delete_outline_rounded, color: CustomTheme.appColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
