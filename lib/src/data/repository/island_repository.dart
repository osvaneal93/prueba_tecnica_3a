class IslandRepository {
  getIslands(List<List<int>> matrix) {
    //tomamos las dimensiones de la matriz y generamos una matriz que servira
    //de auxiliar
    int rows = matrix.length;
    int cols = matrix[0].length;
    List<List<bool>> auxMatrix = <List<bool>>[];

    //generamos los arrays de direcciones para las matrices que tome
    //arriba, abajo, izquierda y derecha
    final rowNbr = [-1, 0, 0, 1];
    final colNbr = [0, -1, 1, 0];

    //validamos que el elemento del array tenga las caracteristicas para
    //ser una isla
    bool putIsland(matrix, int row, int col, auxMatrix) {
      return (row >= 0) &&
          (row < rows) &&
          (col >= 0) &&
          (col < cols) &&
          (matrix[row][col] == 1 && !auxMatrix[row][col]);
    }

    //revisamos los adyacentes del elemento dentro de la matriz y recorremos
    //sobre el camino de los que tengan el mismo elemento, en este caso el '1'
    roveMatrix(
      List<List<int>> matrix,
      int row,
      int col,
      List<List<bool>> auxMatrix,
    ) {
      auxMatrix[row][col] = true;

      for (var k = 0; k < 4; ++k) {
        if (putIsland(matrix, row + rowNbr[k], col + colNbr[k], auxMatrix)) {
          roveMatrix(matrix, row + rowNbr[k], col + colNbr[k], auxMatrix);
        }
      }
    }

    //le damos valor false a todos los elementos de la matriz auxiliar,
    //nos servirá para saber los elementos que se han recorrido ya anteriormente
    for (var i = 0; i < rows; i++) {
      List<bool> list = <bool>[];

      for (var i = 0; i < cols; i++) {
        list.add(false);
      }
      auxMatrix.add(list);
    }

    //el contador de islas sumará una isla cada que haga un ciclo for
    int islandCount = 0;

    //vamos a recorrer todos los campos a la par de la matriz auxiliar,
    // en el algoritmo comaramos que el elemento sea 1 y no haya sido
    //visitado anteriormente, en caso de que se cumplan las condiciones,
    //se suma una isla
    for (var i = 0; i < rows; ++i) {
      for (var j = 0; j < cols; ++j) {
        if (matrix[i][j] == 1 && !auxMatrix[i][j]) {
          roveMatrix(matrix, i, j, auxMatrix);
          islandCount++;
        }
      }
    }

    print(auxMatrix);
    print(islandCount);

    //retornamos la cantidad de islas que se contaron en la matriz
    return islandCount;
  }

  // final List<List<int>> matrix = [
  //   [1, 1, 0, 1, 1],
  //   [1, 1, 0, 0, 0],
  //   [0, 1, 0, 0, 0],
  //   [0, 1, 0, 0, 1],
  //   [1, 1, 0, 1, 1]
  // ];
}
