import 'package:example/entities/page.dart';
import 'package:example/presentation/app/injector.dart';
import 'package:flutter/material.dart' hide Page;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:example/presentation/pages/tabs/tabs_state.dart';
import 'package:example/presentation/pages/tabs/tabs_cubit.dart';

class Tabs extends StatefulWidget {
  final Widget tab;

  const Tabs({Key? key, required this.tab}) : super(key: key);

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  final cubit = i.get<TabsCubit>();

  @override
  void initState() {
    super.initState();
    cubit.init();
  }

  int calculateSelectedIndex(BuildContext context, List<Page> pages) {
    final GoRouter route = GoRouter.of(context);
    final String location = route.location;
    for (final page in pages) {
      if (location.startsWith(page.route)) {
        return pages.indexOf(page);
      }
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabsCubit, TabsState>(
        bloc: cubit,
        builder: (context, state) {
          return Scaffold(
            body: widget.tab,
            bottomNavigationBar: state.pages.isEmpty
                ? null
                : BottomNavigationBar(
                    currentIndex: calculateSelectedIndex(context, state.pages),
                    onTap: (index) => context.go(state.pages[index].route),
                    items: state.pages
                        .map(
                          (page) => BottomNavigationBarItem(
                            icon: Icon(
                              IconData(
                                page.iconCode,
                                fontFamily: 'MaterialIcons',
                              ),
                            ),
                            label: page.label,
                          ),
                        )
                        .toList()
                        .cast<BottomNavigationBarItem>(),
                  ),
          );
        });
  }
}
