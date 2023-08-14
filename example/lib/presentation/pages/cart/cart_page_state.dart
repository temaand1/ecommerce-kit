import 'package:e_commerce_ui_kit/e_commerce_ui_kit.dart';

class CartPageState {
  final List<ProductItem> products;
  final String subtotalValue;
  final String deliveryFeeValue;
  final String totalValue;

  const CartPageState({
    required this.subtotalValue,
    required this.deliveryFeeValue,
    required this.totalValue,
    required this.products,
  });

  CartPageState copyWith({
    List<ProductItem>? products,
    String? subtotalValue,
    String? deliveryFeeValue,
    String? totalValue,
  }) {
    return CartPageState(
      products: products ?? this.products,
      subtotalValue: subtotalValue ?? this.subtotalValue,
      deliveryFeeValue: deliveryFeeValue ?? this.deliveryFeeValue,
      totalValue: totalValue ?? this.totalValue,
    );
  }
}
