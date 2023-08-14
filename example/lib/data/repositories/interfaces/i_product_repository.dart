import 'package:e_commerce_ui_kit/e_commerce_ui_kit.dart';

abstract class IProductsRepository {
  Future<List<ProductCategory>> get categories;

  Future<List<ProductItem>> get products;
}
