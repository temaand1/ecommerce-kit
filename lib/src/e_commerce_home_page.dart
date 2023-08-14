// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_commerce_ui_kit/e_commerce_ui_kit.dart';
import 'package:e_commerce_ui_kit/src/widgets/e_commerce_promo_widget.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_ui_kit/src/utils/dimensions.dart';
import 'package:e_commerce_ui_kit/src/utils/font_sizes.dart';
import 'package:e_commerce_ui_kit/src/utils/strings.dart';
import 'package:e_commerce_ui_kit/src/widgets/e_commerce_app_bar.dart';

/// Home page
class EComHomePage extends StatelessWidget {
  /// Page title.
  final String pageTitle;

  /// The callback that is called when user tap on "back" button
  final VoidCallback onBackTap;

  /// The callback that is called when user tap on "more" button
  final VoidCallback onMoreTap;

  /// Callback which is invoked after user clicks on the Promo
  final VoidCallback onBannerClick;

  /// The callback that is called when user select product
  final ValueChanged<ProductItem> onProductTap;

  /// The callback that is called when user add product to favorite
  final ValueChanged<ProductItem> onProductAddToFavorite;

  /// The callback that is called when user tap on See all
  final ValueChanged<ProductCategory> onSeeAllTap;

  /// Called after tapping on tag
  final ValueChanged<int> onTagSelected;

  /// Page background color. Default [Colors.white]
  final Color backgroundColor;

  /// Items to display on page
  final List<ProductCategory> items;

  /// Tags
  final List<String> tags;

  /// Selected tags
  final List<String> selectedTags;

  /// Items to display under tags
  final List<ProductItem> filteredItems;

  /// Content of the Promo
  final List<String> bannerImages;

  const EComHomePage({
    Key? key,
    required this.pageTitle,
    required this.onBackTap,
    required this.onMoreTap,
    required this.items,
    required this.filteredItems,
    required this.onProductTap,
    required this.onProductAddToFavorite,
    required this.onSeeAllTap,
    required this.onBannerClick,
    required this.bannerImages,
    required this.onTagSelected,
    required this.tags,
    required this.selectedTags,
    this.backgroundColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: backgroundColor,
      child: SafeArea(
        bottom: false,
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
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.marginDefault,
            ),
            child: CustomScrollView(
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      EComPromoWidget(
                        onBannerClick: onBannerClick,
                        bannerImages: bannerImages,
                      ),
                      const SizedBox(height: Dimensions.defaultSize),
                      Column(
                        children: [
                          const SizedBox(height: Dimensions.defaultSize),
                          ...items
                              .map(
                                (e) => _HomePageCategoryRow(
                                  category: e,
                                  onProductAddToFavorite:
                                      onProductAddToFavorite,
                                  onProductTap: onProductTap,
                                  onSeeAllTap: onSeeAllTap,
                                ),
                              )
                              .toList(),
                          const SizedBox(height: Dimensions.defaultSize),
                        ],
                      ),
                      EComSlidableTags(
                        tags: tags,
                        onTagSelected: onTagSelected,
                        selectedTags: selectedTags,
                      ),
                      const SizedBox(height: Dimensions.defaultSize),
                    ],
                  ),
                ),
                _FilteredItems(
                  items: filteredItems,
                  onProductTap: onProductTap,
                  onProductAddToFavorite: onProductAddToFavorite,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HomePageCategoryRow extends StatelessWidget {
  final ProductCategory category;
  final ValueChanged<ProductItem> onProductTap;
  final ValueChanged<ProductItem> onProductAddToFavorite;
  final ValueChanged<ProductCategory> onSeeAllTap;

  const _HomePageCategoryRow({
    Key? key,
    required this.category,
    required this.onProductTap,
    required this.onProductAddToFavorite,
    required this.onSeeAllTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3.5,
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(
            height: Dimensions.bigSize,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  category.categoryName,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: FontSizes.sizeL,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () => onSeeAllTap(category),
                  child: const Text(
                    Strings.seeAll,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: FontSizes.sizeM,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: Dimensions.microSize),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: category.categoryItems.length,
              itemBuilder: (context, i) => InkWell(
                onTap: () => onProductTap(category.categoryItems[i]),
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: Dimensions.marginDefault,
                  ),
                  child: EComProductPreview(
                    product: category.categoryItems[i],
                    onAddToFavoriteTap: () =>
                        onProductAddToFavorite(category.categoryItems[i]),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FilteredItems extends StatelessWidget {
  final List<ProductItem> items;
  final ValueChanged<ProductItem> onProductTap;
  final ValueChanged<ProductItem> onProductAddToFavorite;

  const _FilteredItems({
    Key? key,
    required this.items,
    required this.onProductTap,
    required this.onProductAddToFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 10,
        childAspectRatio: 2.0,
        crossAxisCount: 2,
        crossAxisSpacing: Dimensions.marginDefault,
        mainAxisExtent: 200,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, i) {
          return InkWell(
            onTap: () => onProductTap(items[i]),
            child: EComProductPreview(
              product: items[i],
              onAddToFavoriteTap: () => onProductAddToFavorite(items[i]),
            ),
          );
        },
        childCount: items.length,
      ),
    );
  }
}
