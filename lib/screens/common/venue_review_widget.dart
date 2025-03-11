import 'package:aio_sport/screens/common/rating_stars.dart';
import 'package:aio_sport/services/server_urls.dart';
import 'package:aio_sport/themes/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class VenueReviewWidget extends StatelessWidget {
  final String image;
  final String name;
  final double ratingCount;
  final DateTime time;
  final String review;
  const VenueReviewWidget({super.key, required this.image, required this.name, required this.ratingCount, required this.time, required this.review});
  String getTimeAgo(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return "Today";
    } else if (difference.inDays == 1) {
      return "Yesterday";
    } else if (difference.inDays < 7) {
      return "${difference.inDays}d ago";
    } else if (difference.inDays < 30) {
      return "${(difference.inDays / 7).floor()} week${(difference.inDays / 7).floor() > 1 ? 's' : ''} ago";
    } else if (difference.inDays < 365) {
      return "${(difference.inDays / 30).floor()} month${(difference.inDays / 30).floor() > 1 ? 's' : ''} ago";
    } else {
      return "${(difference.inDays / 365).floor()} year${(difference.inDays / 365).floor() > 1 ? 's' : ''} ago";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(width: 1, color: CustomTheme.borderColor)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                    '${ServerUrls.mediaUrl}player/$image',
                    height: 45,
                    width: 45,
                    fit: BoxFit.cover,
                  )),
              const SizedBox(
                width: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: Get.textTheme.bodyMedium!.copyWith(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 4,
                  ),
                  RatingStars(
                    rating: ratingCount,
                    starSize: 16,
                  )
                ],
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(getTimeAgo(time), style: Get.textTheme.bodyMedium!.copyWith(fontSize: 16, color: CustomTheme.grey, fontWeight: FontWeight.bold)),
              )
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Text(review,
              overflow: TextOverflow.ellipsis,
              style: Get.textTheme.bodyMedium!.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.normal,
              ))
        ],
      ),
    );
  }
}
