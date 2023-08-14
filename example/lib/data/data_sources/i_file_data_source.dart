import 'package:e_commerce_ui_kit/e_commerce_ui_kit.dart';
import 'package:example/entities/page.dart';

abstract class IFileDataSource {
  Future<List<ProductCategory>> get categories;

  Future<List<ProductItem>> get products;

  Future<List<Page>> get pages;
}
