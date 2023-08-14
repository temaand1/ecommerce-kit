import 'dart:math';

import 'package:e_commerce_ui_kit/src/utils/dimensions.dart';
import 'package:e_commerce_ui_kit/src/utils/font_sizes.dart';
import 'package:flutter/material.dart';

/// Profile pictures of users who liked the product
class EComFavoriteCounter extends StatelessWidget {
  /// Profile pictures
  final List<String> imageURLs;

  /// Text to the right of the pictures
  final String? text;

  /// Style of the [text]
  final TextStyle textStyle;

  /// Color of the image Border
  final Color borderColor;

  /// Maximum number of images
  final int imageCount;

  final int _maxImageCount;

  EComFavoriteCounter({
    Key? key,
    required this.imageURLs,
    this.text,
    this.textStyle = const TextStyle(
      fontSize: FontSizes.sizeS,
      color: Colors.grey,
    ),
    this.borderColor = const Color(0xFFFCFCFC),
    this.imageCount = 5,
  })  : _maxImageCount = min(imageCount, imageURLs.length - 1),
        super(key: key);

  double _imagePadding(int index) {
    final double padding = index * (Dimensions.middleCircularRadius + 4);
    return padding;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.marginDefaultPlus,
      ),
      child: Row(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              for (int i = _maxImageCount; i >= 0; i--)
                _Image(
                  padding: _imagePadding(i),
                  imageURL: imageURLs[i],
                  borderColor: borderColor,
                ),
            ],
          ),
          if (text != null)
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: Dimensions.marginSmall,
                ),
                child: Text(
                  text!,
                  style: textStyle,
                  overflow: TextOverflow.clip,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _Image extends StatelessWidget {
  final Color borderColor;
  final String imageURL;
  final double padding;

  const _Image({
    Key? key,
    required this.borderColor,
    required this.imageURL,
    required this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: padding,
      ),
      child: CircleAvatar(
        backgroundColor: borderColor,
        radius: Dimensions.middleCircularRadius,
        child: CircleAvatar(
          backgroundColor: borderColor,
          backgroundImage: NetworkImage(imageURL),
          radius: Dimensions.smallCircularRadius,
        ),
      ),
    );
  }
}
