import 'package:example/data/converters/product_converter.dart';
import 'package:example/data/data_sources/i_file_data_source.dart';
import 'package:example/data/data_sources/file_data_source.dart';
import 'package:example/data/repositories/interfaces/i_pages_repository.dart';
import 'package:example/data/repositories/pages_repository.dart';
import 'package:example/presentation/pages/category/category_page_cubit.dart';
import 'package:example/presentation/pages/home/home_page_cubit.dart';
import 'package:example/presentation/pages/product/product_page_cubit.dart';
import 'package:example/presentation/pages/tabs/tabs_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:example/presentation/pages/cart/cart_page_cubit.dart';
import 'package:example/data/repositories/interfaces/i_product_repository.dart';
import 'package:example/data/repositories/product_repository.dart';

final i = GetIt.instance;

void initInjector() {
  //converter
  i.registerSingleton<ProductConverter>(
    ProductConverter(),
  );

  //data source
  i.registerSingleton<IFileDataSource>(
    FileDataSource(i.get()),
  );

  //repositories
  i.registerSingleton<IPagesRepository>(
    PagesRepository(i.get()),
  );
  i.registerSingleton<IProductsRepository>(
    ProductsRepository(i.get()),
  );

  //cubits
  i.registerSingleton<TabsCubit>(
    TabsCubit(i.get()),
  );
  i.registerSingleton<HomePageCubit>(
    HomePageCubit(i.get()),
  );
  i.registerSingleton<CartPageCubit>(
    CartPageCubit(i.get()),
  );
  i.registerSingleton<ProductPageCubit>(
    ProductPageCubit(),
  );
  i.registerSingleton<CategoryPageCubit>(
    CategoryPageCubit(),
  );
}
