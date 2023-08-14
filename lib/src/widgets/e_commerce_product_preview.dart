// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:e_commerce_ui_kit/src/models/product_item.dart';
import 'package:e_commerce_ui_kit/src/utils/dimensions.dart';
import 'package:e_commerce_ui_kit/src/utils/font_sizes.dart';

/// Product Preview
class EComProductPreview extends StatelessWidget {
  /// Item to display
  final ProductItem product;

  /// The callback that is called when user add product to favorite
  final VoidCallback onAddToFavoriteTap;

  const EComProductPreview({
    super.key,
    required this.product,
    required this.onAddToFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2.5,
      height: MediaQuery.of(context).size.height / 4.5,
      child: Column(
        children: [
          _ProductImage(imagePath: product.productAssets.first),
          _ProductDescription(
            product: product,
            onAddToFavoriteTap: onAddToFavoriteTap,
          ),
        ],
      ),
    );
  }
}

class _ProductDescription extends StatelessWidget {
  final ProductItem product;
  final VoidCallback onAddToFavoriteTap;

  const _ProductDescription({
    Key? key,
    required this.product,
    required this.onAddToFavoriteTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: Dimensions.marginMicro),
          child: Text(
            product.productName,
            style: const TextStyle(fontSize: FontSizes.sizeM, fontWeight: FontWeight.bold),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (product.categoryName != null)
                  Text(
                    product.categoryName!,
                    style: const TextStyle(color: Colors.grey),
                  ),
                (product.discountPrice != null)
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            product.discountPrice!,
                            style: const TextStyle(
                              fontSize: FontSizes.sizeS,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: Dimensions.microSize / 2),
                          Text(
                            product.price,
                            style: const TextStyle(
                              fontSize: FontSizes.sizeS,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      )
                    : Text(
                        product.price,
                        style: const TextStyle(
                          fontSize: FontSizes.sizeS,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ],
            ),
            SizedBox(
              height: Dimensions.largeSize,
              width: Dimensions.largeSize,
              child: IconButton(
                onPressed: onAddToFavoriteTap,
                icon: Icon(product.isFavorite ? Icons.favorite : Icons.favorite_border),
              ),
            )
          ],
        ),
      ],
    );
  }
}

class _ProductImage extends StatelessWidget {
  final String imagePath;

  const _ProductImage({
    Key? key,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.smallCircularRadius),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(imagePath),
        ),
      ),
    );
  }
}
