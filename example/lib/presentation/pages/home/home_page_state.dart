import 'package:e_commerce_ui_kit/e_commerce_ui_kit.dart';

class HomePageState {
  final List<ProductItem> products;
  final List<ProductCategory> categories;
  final List<String> bannerImages;
  final List<String> tags;
  final List<String> selectedTags;

  const HomePageState({
    required this.products,
    required this.categories,
    required this.bannerImages,
    required this.tags,
    required this.selectedTags,
  });

  HomePageState copyWith({
    List<ProductItem>? products,
    List<ProductCategory>? categories,
    List<String>? bannerImages,
    List<String>? tags,
    List<String>? selectedTags,
  }) {
    return HomePageState(
      products: products ?? this.products,
      categories: categories ?? this.categories,
      bannerImages: bannerImages ?? this.bannerImages,
      tags: tags ?? this.tags,
      selectedTags: selectedTags ?? this.selectedTags,
    );
  }
}
