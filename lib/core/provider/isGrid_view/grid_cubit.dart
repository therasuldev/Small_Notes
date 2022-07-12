import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smallnotes/core/service/grid_service.dart';

import 'grid_state.dart';

class GridCubit extends Cubit<GridState> {
  GridCubit() : super(GridState());

  Future<void> initApp() async {
    final firstView = await currentView;
    emit(state.copyWith(isGrid: firstView));
  }

  Future<bool?> get currentView async {
    final view = await GridService.gridService.get('grid');

    return view ?? true;
  }

  Future<void> changeView(bool grid) async {
    try {
      await GridService.gridService.put('grid', grid);
      emit(state.copyWith(isGrid: grid));
    } catch (e) {
      log(e.toString());
    }
  }
}
