import 'package:e_commerce_ui_kit/e_commerce_ui_kit.dart';
import 'package:example/data/data_sources/i_file_data_source.dart';
import 'package:example/data/repositories/interfaces/i_product_repository.dart';

class ProductsRepository implements IProductsRepository {
  final IFileDataSource _fileDataSource;

  ProductsRepository(this._fileDataSource);

  @override
  Future<List<ProductCategory>> get categories => _fileDataSource.categories;

  @override
  Future<List<ProductItem>> get products => _fileDataSource.products;
}
