import 'dart:math';

import 'package:e_commerce_ui_kit/e_commerce_ui_kit.dart';
import 'package:example/data/repositories/interfaces/i_product_repository.dart';
import 'package:example/presentation/pages/home/home_page_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageCubit extends Cubit<HomePageState> {
  final IProductsRepository _productRepository;

  HomePageCubit(this._productRepository)
      : super(
          const HomePageState(
            products: [],
            categories: [],
            bannerImages: [],
            tags: [],
            selectedTags: [],
          ),
        );

  void init() async {
    await _setProducts();
    await _setCategories();
    _setBannerImages();
    _setTags();
  }

  Future<void> _setProducts() async {
    final products = await _productRepository.products;
    products.shuffle();
    emit(
      state.copyWith(products: products),
    );
  }

  Future<void> _setCategories() async {
    final categories = await _productRepository.categories;
    emit(
      state.copyWith(categories: categories),
    );
  }

  void _setBannerImages() {
    final imagesCount = min(state.products.length, 3);
    final bannerImages = state.products
        .getRange(0, imagesCount)
        .map((product) => product.productAssets.first)
        .toList();
    emit(
      state.copyWith(bannerImages: bannerImages),
    );
  }

  void _setTags() {
    final tags = <String>[];
    for (final category in state.categories) {
      tags.add(category.categoryName);
    }
    emit(
      state.copyWith(tags: tags),
    );
  }

  void selectUnselectTag(int index) {
    final selectedTag = state.tags[index];
    List<String> selectedTags = state.selectedTags;
    if (state.selectedTags.contains(selectedTag)) {
      selectedTags.remove(selectedTag);
    } else {
      selectedTags = [...state.selectedTags, selectedTag];
    }
    emit(
      state.copyWith(selectedTags: selectedTags),
    );
  }

  List<ProductItem> filteredItems() {
    Iterable<ProductItem> filteredItems = [];
    if (state.selectedTags.isEmpty) {
      filteredItems = state.products;
    } else {
      filteredItems = state.products.where(
          (product) => state.selectedTags.contains(product.categoryName));
    }
    return filteredItems.toList();
  }

  void addProductToFavorite(ProductItem product) {
    _updateCategories(product);
    _updateProducts(product);
  }

  void _updateCategories(ProductItem product) {
    final newProduct = product.copyWith(isFavorite: !product.isFavorite);
    final categories = state.categories;
    for (int i = 0; i < categories.length; i++) {
      final products = categories[i].categoryItems;
      final index = products.indexOf(product);
      if (index >= 0) {
        products[index] = newProduct;
        final newCategory = categories[i].copyWith(categoryItems: products);
        categories[i] = newCategory;
        break;
      }
    }
    emit(
      state.copyWith(categories: categories),
    );
  }

  void _updateProducts(ProductItem product) {
    final newProduct = product.copyWith(isFavorite: !product.isFavorite);
    final products = state.products;
    final index = products.indexOf(product);
    if (index >= 0) {
      products[index] = newProduct;
    }
    emit(
      state.copyWith(products: products),
    );
  }
}
