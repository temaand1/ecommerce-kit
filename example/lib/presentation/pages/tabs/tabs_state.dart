import 'package:example/entities/page.dart';

class TabsState {
  final List<Page> pages;

  const TabsState({required this.pages});

  TabsState copyWith({
    List<Page>? pages,
  }) {
    return TabsState(
      pages: pages ?? this.pages,
    );
  }
}
