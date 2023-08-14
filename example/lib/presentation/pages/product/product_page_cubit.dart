import 'package:e_commerce_ui_kit/e_commerce_ui_kit.dart';
import 'package:example/presentation/pages/product/product_page_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductPageCubit extends Cubit<ProductPageState> {
  ProductPageCubit()
      : super(
          const ProductPageState(
            isFavorite: false,
            itemCount: 0,
          ),
        );

  void init(ProductItem item) {
    _setFavourite(item);
  }

  void _setFavourite(ProductItem item) {
    emit(
      state.copyWith(isFavorite: item.isFavorite),
    );
  }

  void changeFavourite() {
    emit(
      state.copyWith(isFavorite: !state.isFavorite),
    );
  }

  void changeItemCount(int count) {
    emit(
      state.copyWith(itemCount: count),
    );
  }
}
