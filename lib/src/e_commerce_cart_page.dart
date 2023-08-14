// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_commerce_ui_kit/e_commerce_ui_kit.dart';
import 'package:e_commerce_ui_kit/src/utils/dimensions.dart';
import 'package:e_commerce_ui_kit/src/utils/strings.dart';
import 'package:e_commerce_ui_kit/src/widgets/e_commerce_app_bar.dart';
import 'package:flutter/material.dart';

/// User cart page
class EComCartPage extends StatefulWidget {
  /// Page title. Default ['Cart Page']
  final String pageTitle;

  /// Items in cart
  final List<ProductItem> items;

  /// Checkout button title. Default ['Checkout']
  final String checkoutButtonTitle;

  /// Subtotal field value
  final String subtotalValue;

  /// Delivery Fee field value
  final String deliveryFeeValue;

  /// Duscount field value (optional)
  final String? discountValue;

  /// Total field value
  final String totalValue;

  /// The callback that is called when user tap on "back" button
  final VoidCallback onBackTap;

  /// The callback that is called when user tap on "more" button
  final VoidCallback onMoreTap;

  /// The callback that is called when user tap on Checkout button
  final VoidCallback onCheckoutTap;

  /// The callback that is called when user remove item from cart
  final Function(ProductItem) onDeleteItem;

  /// Page background color. Default [Colors.white]
  final Color backgroundColor;

  const EComCartPage({
    Key? key,
    required this.subtotalValue,
    required this.deliveryFeeValue,
    required this.totalValue,
    required this.onBackTap,
    required this.onCheckoutTap,
    required this.onMoreTap,
    required this.items,
    required this.onDeleteItem,
    this.discountValue,
    this.backgroundColor = Colors.white,
    this.pageTitle = Strings.cart,
    this.checkoutButtonTitle = Strings.checkout,
  }) : super(key: key);

  @override
  State<EComCartPage> createState() => _EComCartPageState();
}

class _EComCartPageState extends State<EComCartPage> {
  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: widget.backgroundColor,
      child: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size(
              double.infinity,
              MediaQuery.of(context).size.height / 9,
            ),
            child: EComAppBar(
              title: widget.pageTitle,
              onBackTap: widget.onBackTap,
              onMoreTap: widget.onMoreTap,
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: widget.items.length,
                  itemBuilder: (context, index) => EComCartProductWidget(
                    productItem: widget.items[index],
                    onDeleteItem: widget.onDeleteItem,
                  ),
                ),
              ),
              _CheckoutData(
                subtotalValue: widget.subtotalValue,
                deliveryFeeValue: widget.deliveryFeeValue,
                totalValue: widget.totalValue,
                discountValue: widget.discountValue,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.marginLarge,
                ),
                child: FilledButton(
                  onPressed: widget.onCheckoutTap,
                  child: Text(
                    widget.checkoutButtonTitle,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _CheckoutData extends StatelessWidget {
  final String subtotalValue;
  final String deliveryFeeValue;
  final String? discountValue;
  final String totalValue;

  const _CheckoutData({
    Key? key,
    required this.subtotalValue,
    required this.deliveryFeeValue,
    required this.totalValue,
    this.discountValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 5,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(Dimensions.mediumCircularRadius),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.marginLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: Dimensions.microSize),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(Strings.subtotal),
              Text(
                subtotalValue,
                style: const TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
          const SizedBox(height: Dimensions.microSize),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(Strings.delivery),
              Text(
                deliveryFeeValue,
                style: const TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
          if (discountValue != null) ...[
            const SizedBox(height: Dimensions.microSize),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(Strings.discount),
                Text(
                  discountValue!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                )
              ],
            ),
          ],
          const SizedBox(height: Dimensions.largeSize),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(Strings.total),
              Text(
                totalValue,
                style: const TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
        ],
      ),
    );
  }
}
