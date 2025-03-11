import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  final double rating;
  final int starCount;
  final double starSize;

  const RatingStars({
    Key? key,
    required this.rating,
    this.starCount = 5,
    this.starSize = 30.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(starCount, (index) {
        double starValue = index + 1;
        if (rating >= starValue) {
          // Full star
          return Icon(Icons.star, color: Color(0xffFC6B21), size: starSize);
        } else if (rating >= starValue - 0.5) {
          // Half star
          return Icon(Icons.star_half, color: Color(0xffFC6B21), size: starSize);
        } else {
          // Empty star
          return Icon(Icons.star, color: Color(0xff9FA1A6), size: starSize);
        }
      }),
    );
  }
}
