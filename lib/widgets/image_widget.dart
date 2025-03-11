import 'package:aio_sport/themes/custom_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageWidget extends StatefulWidget {
  final String? imageurl;
  final double? width, height, radius;
  final BoxFit? fit;
  final Color? color;
  const ImageWidget({super.key, required this.imageurl, this.width, this.height, this.fit, this.color, this.radius});

  @override
  State<ImageWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.radius ?? 0),
      child: widget.imageurl == null
          ? Image.asset('assets/images/error_image.png', width: widget.width, height: widget.height, fit: widget.fit)
          : CachedNetworkImage(
              imageUrl: widget.imageurl!,
              width: widget.width,
              height: widget.height,
              fit: widget.fit,
              color: widget.color,
              errorWidget: (context, url, error) {
                return Image.asset('assets/images/error_image.png', width: widget.width, height: widget.height, fit: widget.fit);
              },
              progressIndicatorBuilder: (context, url, progress) {
                return Container(
                  width: widget.height,
                  height: widget.width,
                  color: Colors.white,
                  child: Center(child: CircularProgressIndicator(color: CustomTheme.textColorLight)),
                );
              },
              useOldImageOnUrlChange: true,
            ),
    );
  }
}
