import 'package:e_commerce_ui_kit/src/utils/dimensions.dart';
import 'package:e_commerce_ui_kit/src/widgets/e_commerce_image_slideshow.dart';
import 'package:flutter/material.dart';

class EComPromoWidget extends StatelessWidget {
  /// Content of the Promo
  final List<String> bannerImages;

  /// Callback which is invoked after user clicks on the Promo
  final VoidCallback onBannerClick;

  /// The color to paint the indicator.
  final Color indicatorColor;

  /// The color to paint behind the indicator.
  final Color indicatorBackgroundColor;

  /// Optional parameter which sets the height of the Promo
  final double height;

  const EComPromoWidget({
    required this.onBannerClick,
    required this.bannerImages,
    this.height = Dimensions.promoHeight,
    this.indicatorColor = Colors.white,
    this.indicatorBackgroundColor = Colors.grey,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(Dimensions.standardCircularRadius),
        ),
        child: EComImageSlideshow(
          indicatorColor: Colors.white,
          indicatorBackgroundColor: Colors.grey,
          imageURLs: bannerImages,
          imageFit: BoxFit.cover,
        ),
      ),
    );
  }
}
