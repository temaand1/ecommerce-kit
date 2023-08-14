import 'package:e_commerce_ui_kit/e_commerce_ui_kit.dart';
import 'package:e_commerce_ui_kit/src/utils/dimensions.dart';
import 'package:e_commerce_ui_kit/src/widgets/e_commerce_app_bar.dart';
import 'package:flutter/material.dart';

/// Category page
class EComCategoryPage extends StatefulWidget {
  /// Page title.
  final String pageTitle;

  /// The callback that is called when user tap on "back" button
  final VoidCallback onBackTap;

  /// The callback that is called when user tap on "more" button
  final VoidCallback onMoreTap;

  /// The callback that is called when user select product
  final Function(ProductItem) onProductTap;

  /// The callback that is called when user add product to favorite
  final Function(ProductItem) onProductAddToFavorite;

  /// Page background color. Default [Colors.white]
  final Color backgroundColor;

  /// Items to display on page
  final List<ProductItem> items;

  const EComCategoryPage({
    Key? key,
    required this.pageTitle,
    required this.onBackTap,
    required this.onMoreTap,
    required this.items,
    required this.onProductTap,
    required this.onProductAddToFavorite,
    this.backgroundColor = Colors.white,
  }) : super(key: key);

  @override
  State<EComCategoryPage> createState() => _EComCategoryPageState();
}

class _EComCategoryPageState extends State<EComCategoryPage> {
  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: widget.backgroundColor,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size(
              double.infinity,
              MediaQuery.of(context).size.height / 9,
            ),
            child: EComAppBar(
              title: widget.pageTitle,
              onBackTap: widget.onBackTap,
              onMoreTap: widget.onMoreTap,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(Dimensions.marginBig),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: Dimensions.marginDefault,
                mainAxisExtent: 200,
              ),
              itemCount: widget.items.length,
              itemBuilder: (context, i) => InkWell(
                onTap: () => widget.onProductTap(widget.items[i]),
                child: EComProductPreview(
                  product: widget.items[i],
                  onAddToFavoriteTap: () => widget.onProductAddToFavorite(widget.items[i]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
