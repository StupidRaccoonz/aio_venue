import 'package:aio_sport/constants/constants.dart';
import 'package:aio_sport/models/venue_reviews_model.dart';
import 'package:aio_sport/services/server_urls.dart';
import 'package:aio_sport/themes/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scaled_size/scaled_size.dart';

import 'image_widget.dart';

class ReviewWidget extends StatelessWidget {
  final ReviewData reviewModel;
  const ReviewWidget({super.key, required this.reviewModel});

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(side: BorderSide(color: CustomTheme.borderColor), borderRadius: BorderRadius.circular(8.br)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(25.0),
                  child: ImageWidget(
                    imageurl: "${ServerUrls.mediaUrl}${reviewModel.reviewedByRole.toLowerCase()}/${reviewModel.profilePicture}",
                    height: 50.0,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 3,
                            child: Text(
                              reviewModel.name,
                              style: Get.textTheme.bodySmall,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Flexible(flex: 2, child: Text(Constants.getFormattedDate(reviewModel.date), style: Get.textTheme.displaySmall)),
                        ],
                      ),
                      SizedBox(
                          height: 30,
                          child: ListView.builder(
                            itemCount: 5,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 2.0),
                                child: Icon(
                                  (index + 1) <= reviewModel.rating
                                      ? Icons.star_rounded
                                      : reviewModel.rating == (index + 1.5)
                                          ? Icons.star_half_outlined
                                          : Icons.star_border_rounded,
                                  color: Colors.yellow,
                                ),
                              );
                            },
                          )),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.rh),
            Text(reviewModel.comment, style: Get.textTheme.labelSmall!.copyWith(color: CustomTheme.appColor)),
          ],
        ),
      ),
    );
  }
}
