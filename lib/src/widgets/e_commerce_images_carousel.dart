import 'package:e_commerce_ui_kit/src/utils/dimensions.dart';
import 'package:flutter/material.dart';

/// Carousel of images
class EComImagesCarousel extends StatefulWidget {
  /// Images for carousel
  final List<String> imageURLs;

  /// Border color of unselected image option
  final Color borderColor;

  /// Border color of selected image option
  final Color selectedBorderColor;

  /// Carousel and selected image height
  final double imagesCarouselHeight;

  const EComImagesCarousel({
    Key? key,
    required this.imageURLs,
    this.borderColor = Colors.white,
    this.selectedBorderColor = const Color(0xFFE4CC6A),
    this.imagesCarouselHeight = Dimensions.imagesCarouselHeight,
  }) : super(key: key);

  @override
  State<EComImagesCarousel> createState() => _EComImagesCarouselState();
}

class _EComImagesCarouselState extends State<EComImagesCarousel> {
  int selectedImageIndex = 0;

  void onImageOptionTap(int index) {
    setState(() {
      selectedImageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.imagesCarouselHeight,
      child: widget.imageURLs.isEmpty
          ? ColoredBox(color: widget.borderColor)
          : Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Image(
                  fit: BoxFit.cover,
                  height: widget.imagesCarouselHeight,
                  width: MediaQuery.of(context).size.width,
                  image: NetworkImage(widget.imageURLs[selectedImageIndex]),
                ),
                SizedBox(
                  height: Dimensions.imageOptionsListHeight,
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.marginDefaultPlus,
                    ),
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.imageURLs.length,
                    itemBuilder: (context, index) => _ImageOption(
                      onImageOptionTap: () => setState(() {
                        selectedImageIndex = index;
                      }),
                      imageURL: widget.imageURLs[index],
                      borderColor: index == selectedImageIndex
                          ? widget.selectedBorderColor
                          : widget.borderColor,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

class _ImageOption extends StatelessWidget {
  final String imageURL;
  final Color borderColor;
  final VoidCallback onImageOptionTap;

  const _ImageOption({
    Key? key,
    required this.imageURL,
    required this.borderColor,
    required this.onImageOptionTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: Dimensions.marginSmall),
      child: GestureDetector(
        onTap: onImageOptionTap,
        child: CircleAvatar(
          backgroundColor: borderColor,
          radius: Dimensions.bigCircularRadius,
          child: CircleAvatar(
            backgroundColor: borderColor,
            backgroundImage: NetworkImage(imageURL),
            radius: Dimensions.imageOptionCircularRadius,
          ),
        ),
      ),
    );
  }
}
