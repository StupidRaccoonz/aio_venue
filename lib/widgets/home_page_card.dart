import 'package:aio_sport/screens/venue/venue_earning_screen.dart';
import 'package:aio_sport/themes/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/venue/venue_metrics.dart';
import 'icon_button_widget.dart';

class HomePageCard extends StatefulWidget {
  final String title, data, image;
  final double width, height;

  const HomePageCard(
      {super.key,
      required this.title,
      required this.data,
      required this.image,
      required this.width,
      required this.height});

  @override
  State<HomePageCard> createState() => _HomePageCardState();
}

class _HomePageCardState extends State<HomePageCard> {
  @override
  Widget build(BuildContext context) {
    return Material(
      // elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
        side: BorderSide(color: CustomTheme.borderColor),
      ),
      child: InkWell(
        onTap: () {
          if (widget.title == "Metrics") {
            print("click Metrics ======================>");
            Get.to(VenueMetricsScreen());
          } else if (widget.title == 'Earnings') {
            print("click Earning ======================>");
            Get.to(VenueEarningScreen());
          } else {
            return null;
          }
        },
        borderRadius: BorderRadius.circular(16.0),
        child: Stack(
          children: [
            SizedBox(width: widget.width, height: widget.height),
            Positioned(
              right: 0,
              bottom: 0,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Image.asset(
                    'assets/icons/ellipse.png',
                    width: MediaQuery.of(context).size.width * 0.2,
                  ),
                  Positioned(
                    bottom: 8.0,
                    right: 8.0,
                    child: Image.asset(
                      'assets/icons/${widget.image}.png',
                      width: MediaQuery.of(context).size.width * 0.1,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: Get.textTheme.headlineSmall!
                        .copyWith(fontWeight: FontWeight.w500, color: CustomTheme.textColor),
                  ),
                  Text(
                    widget.data,
                    style: Get.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24.0),
                  IconButtonWidget(
                    icon: Icons.arrow_forward_rounded,
                    onPressed: () {
                      if (widget.title == "Metrics") {
                        print("click Metrics ======================>");
                        Get.to(() => VenueMetricsScreen());
                      } else if (widget.title == 'Earnings') {
                        print("click Earning ======================>");
                        Get.to(() => VenueEarningScreen());
                      } else {
                        return null;
                      }
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
