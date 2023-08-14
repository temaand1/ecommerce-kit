import 'package:e_commerce_ui_kit/e_commerce_ui_kit.dart';
import 'package:example/data/repositories/interfaces/i_product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:example/presentation/pages/cart/cart_page_state.dart';

class CartPageCubit extends Cubit<CartPageState> {
  final IProductsRepository _productRepository;

  CartPageCubit(this._productRepository)
      : super(
          const CartPageState(
            products: [],
            subtotalValue: '',
            deliveryFeeValue: '§5',
            totalValue: '',
          ),
        );

  void init() async {
    await _setProducts();
    _calculateSubtotalValue();
    _calculateTotalValue();
  }

  Future<void> _setProducts() async {
    final products = await _productRepository.products;
    emit(
      state.copyWith(products: products),
    );
  }

  void _calculateSubtotalValue() {
    double subtotalValue = 0;
    for (final product in state.products) {
      final price = _priceToDouble(product.price);
      subtotalValue += price;
    }
    emit(
      state.copyWith(subtotalValue: '§$subtotalValue'),
    );
  }

  void _calculateTotalValue() {
    final totalValue = _priceToDouble(state.subtotalValue) +
        _priceToDouble(state.deliveryFeeValue);
    emit(
      state.copyWith(totalValue: '§$totalValue'),
    );
  }

  double _priceToDouble(String price) {
    final regex = RegExp('(\\d+)?(\\.||,)(\\d+)');
    final match = regex.firstMatch(price);
    return double.parse(match?.group(0) ?? '');
  }

  void onDeleteItem(ProductItem productItem) {
    final products = state.products;
    products.remove(productItem);
    _calculateSubtotalValue();
    _calculateTotalValue();
    emit(
      state.copyWith(products: products),
    );
  }
}
