import 'package:e_commerce_ui_kit/e_commerce_ui_kit.dart';
import 'package:example/presentation/app/router/routes.dart';
import 'package:example/presentation/pages/cart/cart_page.dart';
import 'package:example/presentation/pages/category/category_page.dart';
import 'package:example/presentation/pages/home/home_page.dart';
import 'package:example/presentation/pages/product/product_page.dart';
import 'package:example/presentation/pages/tabs/tabs.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: Routes.homePage,
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => Tabs(tab: child),
      routes: <RouteBase>[
        GoRoute(
          path: Routes.homePage,
          builder: (BuildContext context, GoRouterState state) =>
              const HomePage(),
          routes: <RouteBase>[
            GoRoute(
              path: Routes.productPage,
              builder: (BuildContext context, GoRouterState state) =>
                  ProductPage(
                item: state.extra as ProductItem,
              ),
            ),
            GoRoute(
              path: Routes.categoryPage,
              builder: (BuildContext context, GoRouterState state) =>
                  CategoryPage(
                items: state.extra as List<ProductItem>,
              ),
              routes: <RouteBase>[
                GoRoute(
                    path: '${Routes.productPage}:id',
                    builder: (BuildContext context, GoRouterState state) {
                      final items = state.extra as List<ProductItem>;
                      final item = items.firstWhere(
                        (item) => item.id == state.params['id'],
                      );
                      return ProductPage(
                        item: item,
                      );
                    }),
              ],
            ),
          ],
        ),
        GoRoute(
          path: Routes.cartPage,
          builder: (BuildContext context, GoRouterState state) =>
              const CartPage(),
        ),
      ],
    ),
  ],
);
