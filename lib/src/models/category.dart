// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:e_commerce_ui_kit/e_commerce_ui_kit.dart';

class ProductCategory extends Equatable {
  /// Product id
  final String id;

  /// ProductCategory name
  final String categoryName;

  /// ProductCategory Items
  final List<ProductItem> categoryItems;

  const ProductCategory({
    required this.id,
    required this.categoryName,
    required this.categoryItems,
  });

  ProductCategory copyWith({
    String? id,
    String? categoryName,
    List<ProductItem>? categoryItems,
  }) {
    return ProductCategory(
      id: id ?? this.id,
      categoryName: categoryName ?? this.categoryName,
      categoryItems: categoryItems ?? this.categoryItems,
    );
  }

  @override
  List<Object?> get props => [id, categoryName, categoryItems];
}
