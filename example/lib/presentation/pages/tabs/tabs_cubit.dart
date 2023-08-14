import 'package:example/data/repositories/interfaces/i_pages_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:example/presentation/pages/tabs/tabs_state.dart';

class TabsCubit extends Cubit<TabsState> {
  final IPagesRepository _pagesRepository;

  TabsCubit(this._pagesRepository)
      : super(
          const TabsState(
            pages: [],
          ),
        );

  void init() async {
    await _setPages();
  }

  Future<void> _setPages() async {
    final pages = await _pagesRepository.pages;
    emit(
      state.copyWith(pages: pages),
    );
  }
}
