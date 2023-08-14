import 'dart:convert';
import 'package:e_commerce_ui_kit/e_commerce_ui_kit.dart';
import 'package:example/data/converters/product_converter.dart';
import 'package:example/data/data_sources/i_file_data_source.dart';
import 'package:example/entities/page.dart';
import 'package:flutter/services.dart';

class FileDataSource implements IFileDataSource {
  final ProductConverter _converter;

  FileDataSource(this._converter);

  @override
  Future<List<ProductCategory>> get categories async {
    final categoriesString = await rootBundle.loadString(
      'assets/products.json',
    );
    final Map<String, dynamic> parsedCategories = jsonDecode(categoriesString);
    final categories = parsedCategories['categories']
        .map<ProductCategory>((json) => _converter.categoryFromJson(json))
        .toList();
    return categories;
  }

  @override
  Future<List<ProductItem>> get products async {
    final products = <ProductItem>[];
    for (final category in await categories) {
      products.addAll(category.categoryItems);
    }
    return products;
  }

  @override
  Future<List<Page>> get pages async {
    final pagesString = await rootBundle.loadString(
      'assets/pages.json',
    );
    final Map<String, dynamic> parsedPages = jsonDecode(pagesString);
    final pages =
        parsedPages['pages'].map<Page>((json) => Page.fromJson(json)).toList();
    return pages;
  }
}
