import 'package:e_commerce_ui_kit/e_commerce_ui_kit.dart';
import 'package:example/presentation/app/injector.dart';
import 'package:example/presentation/pages/product/product_page_cubit.dart';
import 'package:example/presentation/pages/product/product_page_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProductPage extends StatefulWidget {
  final ProductItem item;

  const ProductPage({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  static const images = [
    'https://i.pinimg.com/564x/a5/fe/47/a5fe47ea2f8ceff573589114b99df225.jpg',
    'https://i.pinimg.com/564x/bc/a0/9c/bca09cef1910b67e259d89a97a6ac53b.jpg',
    'https://i.pinimg.com/564x/8f/2d/69/8f2d690290325ae1e26e8da634673be7.jpg',
    'https://i.pinimg.com/564x/d6/24/42/d62442c19a34793ae2e0c2c0d6c88ec3.jpg',
  ];
  final cubit = i.get<ProductPageCubit>();

  @override
  void initState() {
    super.initState();
    cubit.init(widget.item);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductPageCubit, ProductPageState>(
      bloc: cubit,
      builder: (context, state) {
        return EComProuductPage(
          pageTitle: 'Product Page',
          likesText: '14 people favourite this',
          onImageTap: () => Navigator.of(context).push(
            PageRouteBuilder(
              opaque: false,
              pageBuilder: (_, __, ___) => EComImagesPageView(
                imageURLs: widget.item.productAssets,
              ),
            ),
          ),
          onBackTap: () => context.pop(),
          onMoreTap: () {},
          item: widget.item,
          itemCount: state.itemCount,
          onValueCountChange: cubit.changeItemCount,
          onAddToCartTap: () {},
          onProductVariantTap: () {},
          onAddToFavoriteTap: cubit.changeFavourite,
          isFavoriteItem: state.isFavorite,
          imageURLs: images,
        );
      },
    );
  }
}
