import 'package:e_commerce_ui_kit/e_commerce_ui_kit.dart';
import 'package:example/presentation/app/injector.dart';
import 'package:example/presentation/pages/cart/cart_page_cubit.dart';
import 'package:example/presentation/pages/cart/cart_page_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatefulWidget {
  const CartPage({
    Key? key,
  }) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final cubit = i.get<CartPageCubit>();

  @override
  void initState() {
    super.initState();
    cubit.init();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartPageCubit, CartPageState>(
      bloc: cubit,
      builder: (context, state) {
        return EComCartPage(
          subtotalValue: state.subtotalValue,
          deliveryFeeValue: state.deliveryFeeValue,
          totalValue: state.totalValue,
          onBackTap: () {},
          onCheckoutTap: () {},
          onMoreTap: () {},
          items: state.products,
          onDeleteItem: cubit.onDeleteItem,
        );
      },
    );
  }
}
