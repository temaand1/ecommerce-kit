import 'package:e_commerce_ui_kit/e_commerce_ui_kit.dart';
import 'package:example/presentation/pages/category/category_page_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryPageCubit extends Cubit<CategoryPageState> {
  CategoryPageCubit()
      : super(
          const CategoryPageState(
            products: [],
          ),
        );

  void init(List<ProductItem> products) {
    _setProducts(products);
  }

  void _setProducts(List<ProductItem> products) {
    products.shuffle();
    emit(
      state.copyWith(products: products),
    );
  }

  void addProductToFavorite(ProductItem product) {
    final newProduct = product.copyWith(isFavorite: !product.isFavorite);
    final index = state.products.indexOf(product);
    final products = state.products;
    products[index] = newProduct;
    emit(
      state.copyWith(products: products),
    );
  }
}
