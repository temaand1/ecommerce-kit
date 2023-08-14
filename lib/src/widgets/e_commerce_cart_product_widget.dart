import 'package:e_commerce_ui_kit/src/models/product_item.dart';
import 'package:e_commerce_ui_kit/src/utils/dimensions.dart';
import 'package:e_commerce_ui_kit/src/utils/font_sizes.dart';
import 'package:e_commerce_ui_kit/src/widgets/e_commerce_counter.dart';
import 'package:flutter/material.dart';

class EComCartProductWidget extends StatelessWidget {
  ///Product
  final ProductItem productItem;

  ///Item background color
  final Color backgroundColor;

  ///Delete icon and shadow color
  final Color deleteColor;

  ///Style of [ProductItem.productName]
  final TextStyle productNameTextStyle;

  ///Style of [ProductItem.description]
  final TextStyle descriptionTextStyle;

  ///Style of [ProductItem.price]
  final TextStyle priceTextStyle;

  ///Counter for Products
  final EComCounter? itemCounter;

  ///Called after swiping item from left to right
  final ValueChanged<ProductItem> onDeleteItem;

  const EComCartProductWidget({
    super.key,
    required this.productItem,
    required this.onDeleteItem,
    this.itemCounter,
    this.backgroundColor = Colors.white,
    this.deleteColor = const Color(0xFFCC4341),
    this.productNameTextStyle = const TextStyle(
      color: Colors.black,
      fontSize: FontSizes.sizeL,
      fontWeight: FontWeight.bold,
    ),
    this.descriptionTextStyle = const TextStyle(
      color: Colors.grey,
      fontSize: FontSizes.sizeM,
      fontWeight: FontWeight.normal,
    ),
    this.priceTextStyle = const TextStyle(
      color: Colors.black,
      fontSize: FontSizes.sizeM,
      fontWeight: FontWeight.bold,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.startToEnd,
      background: _DeleteIcon(deleteColor: deleteColor),
      onDismissed: (DismissDirection direction) => onDeleteItem(productItem),
      key: ValueKey(productItem.id),
      child: Container(
        padding: const EdgeInsets.all(Dimensions.marginDefaultPlus),
        height: Dimensions.cartProductHeight,
        color: backgroundColor,
        child: Row(
          children: [
            _CartProductImage(
              imageUrl: productItem.productAssets.first,
            ),
            _CartProductText(
              productName: productItem.productName,
              description: productItem.description,
              price: productItem.price,
              productNameTextStyle: productNameTextStyle,
              descriptionTextStyle: descriptionTextStyle,
              priceTextStyle: priceTextStyle,
              itemCounter: itemCounter,
            ),
          ],
        ),
      ),
    );
  }
}

class _DeleteIcon extends StatelessWidget {
  final Color deleteColor;

  const _DeleteIcon({
    Key? key,
    required this.deleteColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width: Dimensions.deleteIconSize,
        height: Dimensions.deleteIconSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: deleteColor.withOpacity(0.3),
              blurRadius: Dimensions.largeCircularRadius,
            ),
          ],
        ),
        child: Icon(
          Icons.delete_rounded,
          color: deleteColor,
        ),
      ),
    );
  }
}

class _CartProductImage extends StatelessWidget {
  final String imageUrl;

  const _CartProductImage({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Dimensions.middleCircularRadius),
      child: Image(
        height: Dimensions.cartImageHeight,
        width: Dimensions.cartImageHeight,
        fit: BoxFit.cover,
        image: NetworkImage(imageUrl),
      ),
    );
  }
}

class _CartProductText extends StatelessWidget {
  final String productName;
  final String description;
  final String price;

  final TextStyle productNameTextStyle;
  final TextStyle descriptionTextStyle;
  final TextStyle priceTextStyle;

  final EComCounter? itemCounter;

  const _CartProductText({
    Key? key,
    required this.productName,
    required this.description,
    required this.price,
    required this.productNameTextStyle,
    required this.descriptionTextStyle,
    required this.priceTextStyle,
    this.itemCounter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: Dimensions.marginDefault),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              productName,
              overflow: TextOverflow.ellipsis,
              style: productNameTextStyle,
            ),
            Text(
              description,
              overflow: TextOverflow.ellipsis,
              style: descriptionTextStyle,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                verticalDirection: VerticalDirection.down,
                children: [
                  Text(
                    price,
                    style: priceTextStyle,
                  ),
                  if (itemCounter != null) itemCounter!,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
