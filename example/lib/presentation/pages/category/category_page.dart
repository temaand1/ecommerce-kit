import 'package:e_commerce_ui_kit/e_commerce_ui_kit.dart';
import 'package:example/presentation/app/injector.dart';
import 'package:example/presentation/app/router/routes.dart';
import 'package:example/presentation/pages/category/category_page_cubit.dart';
import 'package:example/presentation/pages/category/category_page_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CategoryPage extends StatefulWidget {
  final List<ProductItem> items;

  const CategoryPage({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final cubit = i.get<CategoryPageCubit>();

  @override
  void initState() {
    super.initState();
    cubit.init(widget.items);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryPageCubit, CategoryPageState>(
        bloc: cubit,
        builder: (context, state) {
          return EComCategoryPage(
            pageTitle: state.products.first.categoryName ?? 'Category Page',
            onBackTap: () => context.pop(),
            onMoreTap: () {},
            items: state.products,
            onProductTap: (productItem) => context.go(
              '${GoRouter.of(context).location}/${Routes.productPage}${productItem.id}',
              extra: state.products,
            ),
            onProductAddToFavorite: cubit.addProductToFavorite,
          );
        });
  }
}
