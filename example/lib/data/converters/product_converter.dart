import 'package:e_commerce_ui_kit/e_commerce_ui_kit.dart';

class ProductConverter {
  ProductCategory categoryFromJson(Map<String, dynamic> json) {
    return ProductCategory(
      id: json['id'] as String,
      categoryName: json['category_name'] as String,
      categoryItems: json['category_items']
          .map<ProductItem>((json) => productFromJson(json))
          .toList() as List<ProductItem>,
    );
  }

  ProductItem productFromJson(Map<String, dynamic> json) {
    return ProductItem(
      id: json['id'] as String,
      productName: json['product_name'] as String,
      description: json['description'] as String,
      price: json['price'] as String,
      categoryName: json['category_name'] as String,
      discountPrice: json['discount_price'] as String,
      isFavorite: json['is_favorite'] as bool,
      productAssets: (json['product_assets'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      productTags: (json['product_tags'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );
  }
}
