part of 'bottom_bar_cubit.dart';

class BottomBarState extends Equatable {
  final int? index;
  const BottomBarState({this.index});

  @override
  List<Object> get props => [index!];

  BottomBarState copyWith({int? index}) {
    return BottomBarState(index: index ?? this.index);
  }
}
