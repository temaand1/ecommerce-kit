import 'package:e_commerce_ui_kit/e_commerce_ui_kit.dart';
import 'package:example/presentation/app/injector.dart';
import 'package:example/presentation/app/router/routes.dart';
import 'package:example/presentation/pages/home/home_page_cubit.dart';
import 'package:example/presentation/pages/home/home_page_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final cubit = i.get<HomePageCubit>();

  @override
  void initState() {
    super.initState();
    cubit.init();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageCubit, HomePageState>(
      bloc: cubit,
      builder: (context, state) {
        return EComHomePage(
          pageTitle: 'Home Page',
          onBackTap: () {},
          onMoreTap: () {},
          items: state.categories,
          onProductTap: (productItem) => context.go(
            '${Routes.homePage}/${Routes.productPage}',
            extra: productItem,
          ),
          onProductAddToFavorite: cubit.addProductToFavorite,
          onSeeAllTap: (productCategory) => context.go(
            '${GoRouter.of(context).location}/${Routes.categoryPage}',
            extra: productCategory.categoryItems,
          ),
          onBannerClick: () {},
          bannerImages: state.bannerImages,
          filteredItems: cubit.filteredItems(),
          onTagSelected: cubit.selectUnselectTag,
          tags: state.tags,
          selectedTags: state.selectedTags,
        );
      },
    );
  }
}
