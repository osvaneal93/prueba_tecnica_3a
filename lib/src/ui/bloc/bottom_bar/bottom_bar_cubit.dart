import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bottom_bar_state.dart';

class BottomBarCubit extends Cubit<BottomBarState> {
  BottomBarCubit() : super(const BottomBarState(index: 1));

  void changePage(int index) {
    emit(const BottomBarState().copyWith(index: index));
  }
}
