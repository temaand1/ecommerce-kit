import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

class ProductItem extends Equatable {
  /// Product id
  final String id;

  /// Product name
  final String productName;

  /// Product category. This name displaying under [productName] on Product page
  final String? categoryName;

  /// Product tags
  final List<String>? productTags;

  /// It may be product available sizes, colors  and etc.
  final List<Widget>? productVariants;

  /// Product description
  final String description;

  /// Product price
  final String price;

  /// Optional price, use it when product in on discount
  final String? discountPrice;

  /// List of product images url
  final List<String> productAssets;

  /// Is item added to favorite
  final bool isFavorite;

  const ProductItem({
    required this.id,
    required this.productName,
    required this.description,
    required this.price,
    required this.productAssets,
    this.productTags,
    this.categoryName,
    this.productVariants,
    this.discountPrice,
    this.isFavorite = false,
  });

  ProductItem copyWith({
    String? id,
    String? productName,
    String? categoryName,
    List<String>? productTags,
    List<Widget>? productVariants,
    String? description,
    String? price,
    String? discountPrice,
    List<String>? productAssets,
    bool? isFavorite,
  }) {
    return ProductItem(
      id: id ?? this.id,
      productName: productName ?? this.productName,
      categoryName: categoryName ?? this.categoryName,
      productTags: productTags ?? this.productTags,
      productVariants: productVariants ?? this.productVariants,
      description: description ?? this.description,
      price: price ?? this.price,
      discountPrice: discountPrice ?? this.discountPrice,
      productAssets: productAssets ?? this.productAssets,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object?> get props => [
        id,
        productName,
        description,
        price,
        productAssets,
        productTags,
        categoryName,
        productVariants,
        discountPrice,
        isFavorite,
      ];
}
