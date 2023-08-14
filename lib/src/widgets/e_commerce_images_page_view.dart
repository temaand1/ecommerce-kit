import 'package:dismissible_page/dismissible_page.dart';
import 'package:e_commerce_ui_kit/src/widgets/e_commerce_image_slideshow.dart';
import 'package:flutter/material.dart';

/// Fullscreen image slider
class EComImagesPageView extends StatelessWidget {
  /// Images used in the slider
  final List<String> imageURLs;

  /// Background slider color
  final Color backgroundColor;

  /// The color to paint the indicator.
  final Color indicatorColor;

  /// The color to paint behind the indicator.
  final Color indicatorBackgroundColor;

  const EComImagesPageView({
    Key? key,
    required this.imageURLs,
    this.backgroundColor = const Color(0xAF000000),
    this.indicatorColor = Colors.white,
    this.indicatorBackgroundColor = Colors.grey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: DismissiblePage(
        minRadius: 0,
        backgroundColor: Colors.transparent,
        onDismissed: Navigator.of(context).pop,
        isFullScreen: false,
        child: EComImageSlideshow(
          indicatorColor: indicatorColor,
          indicatorBackgroundColor: indicatorBackgroundColor,
          imageURLs: imageURLs,
          imageFit: BoxFit.contain,
        ),
      ),
    );
  }
}
