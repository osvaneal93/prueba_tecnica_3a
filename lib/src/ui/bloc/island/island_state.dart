part of 'island_cubit.dart';

@immutable
class MatrixState {
  final List<List<int>>? matrix;
  final int? totalIslands;

  const MatrixState(
      {this.matrix = const [
        [0]
      ],
      this.totalIslands = 0});

  MatrixState copyWith(
      {final List<List<int>>? matrix, final int? totalIslands}) {
    return MatrixState(
        matrix: matrix ?? this.matrix,
        totalIslands: totalIslands ?? this.totalIslands);
  }
}
