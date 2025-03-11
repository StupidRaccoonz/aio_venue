import 'package:aio_sport/themes/custom_theme.dart';
import 'package:aio_sport/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmptyBoxWidget extends StatelessWidget {
  final double width, height;
  final String? text;
  final bool isVenue;
  final Function()? onJoinMatch, onCreateMatch;
  const EmptyBoxWidget({super.key, required this.width, required this.height, this.text, required this.isVenue, this.onJoinMatch, this.onCreateMatch});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(isVenue ? "assets/icons/no_bookings.png" : "assets/icons/no_match.png", height: height * 0.35, width: width, fit: BoxFit.fitHeight),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
          child: Text(
            isVenue
                ? "You have no Bookings for today. Hope your business is growing well. Have a good day."
                : "You have not participated in any events at the moment. To join or create refer the below link.",
            textAlign: TextAlign.center,
            style: Get.textTheme.headlineSmall!.copyWith(color: Colors.white70, fontWeight: FontWeight.w300),
          ),
        ),
        isVenue
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: MyButton(
                            text: "Join match",
                            bgColor: CustomTheme.iconColor,
                            onPressed: onJoinMatch,
                            horizontalPadding: 4.0,
                          ),
                        )),
                    Flexible(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: MyButton(
                            text: "Create match",
                            onPressed: onCreateMatch,
                            horizontalPadding: 4.0,
                          ),
                        )),
                  ],
                ),
              )
      ],
    );
  }
}
