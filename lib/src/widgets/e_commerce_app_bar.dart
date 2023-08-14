import 'package:e_commerce_ui_kit/src/utils/dimensions.dart';
import 'package:e_commerce_ui_kit/src/utils/font_sizes.dart';
import 'package:flutter/material.dart';

class EComAppBar extends StatelessWidget {
  /// AppBar title
  final String title;

  /// The callback that is called when user tap on "back" button
  final VoidCallback onBackTap;

  /// The callback that is called when "more" button
  final VoidCallback onMoreTap;

  const EComAppBar({
    super.key,
    required this.title,
    required this.onBackTap,
    required this.onMoreTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.microSize),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            onPressed: onBackTap,
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(Dimensions.marginSmall),
            ),
            child: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          ),
          Text(
            title,
            style: const TextStyle(fontSize: FontSizes.sizeXL, fontWeight: FontWeight.bold),
          ),
          ElevatedButton(
            onPressed: onMoreTap,
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(Dimensions.marginSmall),
            ),
            child: const Icon(Icons.more_horiz, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
