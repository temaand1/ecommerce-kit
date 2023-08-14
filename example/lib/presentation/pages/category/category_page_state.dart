import 'package:e_commerce_ui_kit/e_commerce_ui_kit.dart';

class CategoryPageState {
  final List<ProductItem> products;

  const CategoryPageState({
    required this.products,
  });

  CategoryPageState copyWith({
    List<ProductItem>? products,
  }) {
    return CategoryPageState(
      products: products ?? this.products,
    );
  }
}
