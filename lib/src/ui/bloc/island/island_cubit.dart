import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math';

import 'package:prueba_tecnica_3a/src/data/repository/island_repository.dart';

part 'island_state.dart';

class MatrixCubit extends Cubit<MatrixState> {
  MatrixCubit(this._islandRepository)
      : super(const MatrixState(totalIslands: 0));

  final TextEditingController textController = TextEditingController();
  final IslandRepository _islandRepository;

  createMatrix() {
    final maxRows = int.parse(textController.text);
    final maxColumns = int.parse(textController.text);
    final rand = Random();
    var matrix = [
      for (var row = 0; row < maxRows; row += 1)
        [
          for (var column = 0; column < maxColumns; column += 1) rand.nextInt(2)
        ],
    ];

    emit(MatrixState(
        matrix: matrix, totalIslands: _islandRepository.getIslands(matrix)));
  }

  changeItem(int x, int y) {
    if (state.matrix![x][y] == 0) {
      state.matrix![x][y] = 1;
    } else if (state.matrix![x][y] == 1) {
      state.matrix![x][y] = 0;
    }

    emit(state.copyWith(
        matrix: state.matrix,
        totalIslands: _islandRepository.getIslands(state.matrix!)));
  }
}
