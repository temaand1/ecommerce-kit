import 'package:e_commerce_ui_kit/e_commerce_ui_kit.dart';
import 'package:e_commerce_ui_kit/src/utils/dimensions.dart';
import 'package:e_commerce_ui_kit/src/utils/font_sizes.dart';
import 'package:e_commerce_ui_kit/src/utils/strings.dart';
import 'package:e_commerce_ui_kit/src/widgets/e_commerce_app_bar.dart';
import 'package:e_commerce_ui_kit/src/widgets/e_commerce_read_more.dart';
import 'package:flutter/material.dart';

/// Product details page
class EComProuductPage extends StatelessWidget {
  /// Page title.
  final String pageTitle;

  /// The callback that is called when user tap on "back" button
  final VoidCallback onBackTap;

  /// The callback that is called when user tap on "more" button
  final VoidCallback onMoreTap;

  /// The callback that is called when user tap on images carousel
  final VoidCallback onImageTap;

  /// Product item count
  final int itemCount;

  /// The callback that is called when user changes product value
  final ValueChanged<int> onValueCountChange;

  /// The callback that is called when user add product to cart
  final VoidCallback onAddToCartTap;

  /// The callback that is called when user select product variant
  final VoidCallback onProductVariantTap;

  /// The callback that is called when user add product to favorite
  final VoidCallback onAddToFavoriteTap;

  /// Is value added to favorite
  final bool isFavoriteItem;

  /// Page background color. Default [Colors.white]
  final Color backgroundColor;

  /// Item to display on page
  final ProductItem item;

  /// Photos of users who liked the product
  final List<String> imageURLs;

  /// Text to the right of the photos of users
  final String likesText;

  const EComProuductPage({
    Key? key,
    required this.pageTitle,
    required this.onBackTap,
    required this.onMoreTap,
    required this.item,
    required this.itemCount,
    required this.onValueCountChange,
    required this.onAddToCartTap,
    required this.onProductVariantTap,
    required this.onAddToFavoriteTap,
    required this.isFavoriteItem,
    required this.imageURLs,
    required this.likesText,
    required this.onImageTap,
    this.backgroundColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: backgroundColor,
      child: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size(
              double.infinity,
              MediaQuery.of(context).size.height / 9,
            ),
            child: EComAppBar(
              title: pageTitle,
              onBackTap: onBackTap,
              onMoreTap: onMoreTap,
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      GestureDetector(
                        onTap: onImageTap,
                        child: EComImagesCarousel(
                          imageURLs: item.productAssets,
                        ),
                      ),
                      _ProductDescription(
                        product: item,
                        onProductVariantTap: onProductVariantTap,
                        onAddToFavoriteTap: onAddToFavoriteTap,
                        isFavoriteItem: isFavoriteItem,
                      ),
                      EComFavoriteCounter(
                        imageURLs: imageURLs,
                        text: likesText,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(
                  Dimensions.marginDefaultPlus,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    EComCounter(
                      count: itemCount,
                      onChange: onValueCountChange,
                      size: Dimensions.largeSize,
                    ),
                    const SizedBox(width: Dimensions.microSize),
                    Expanded(
                      child: FilledButton(
                        onPressed: onAddToCartTap,
                        child: const Text(
                          Strings.addToCart,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProductDescription extends StatelessWidget {
  final ProductItem product;
  final VoidCallback onProductVariantTap;
  final VoidCallback onAddToFavoriteTap;
  final bool isFavoriteItem;

  const _ProductDescription({
    Key? key,
    required this.product,
    required this.onProductVariantTap,
    required this.onAddToFavoriteTap,
    required this.isFavoriteItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.marginDefault),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.productName,
                    style: const TextStyle(
                      fontSize: FontSizes.sizeXL,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (product.categoryName != null)
                    Text(
                      product.categoryName!,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  const SizedBox(height: Dimensions.microSize / 2),
                  (product.discountPrice != null)
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              product.discountPrice!,
                              style: const TextStyle(
                                fontSize: FontSizes.sizeL,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: Dimensions.microSize),
                            Text(
                              product.price,
                              style: const TextStyle(
                                fontSize: FontSizes.sizeM,
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
                            fontSize: FontSizes.sizeL,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ],
              ),
              FilledButton.tonal(
                onPressed: onAddToFavoriteTap,
                style: ButtonStyle(
                  shape: MaterialStateProperty.resolveWith<OutlinedBorder>((_) {
                    return const CircleBorder();
                  }),
                ),
                child: Icon(
                  isFavoriteItem ? Icons.favorite : Icons.favorite_border,
                  color: Colors.red,
                ),
              )
            ],
          ),
          if (product.productVariants != null) ...[
            const SizedBox(height: Dimensions.microSize),
            SizedBox(
              height: Dimensions.defaultSize,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: product.productVariants?.length ?? 0,
                itemBuilder: (context, i) => InkWell(
                  onTap: onProductVariantTap,
                  child: product.productVariants![i],
                ),
              ),
            ),
          ],
          const SizedBox(height: Dimensions.microSize),
          ReadMoreText(
            product.description,
            trimLines: 3,
          )
        ],
      ),
    );
  }
}
