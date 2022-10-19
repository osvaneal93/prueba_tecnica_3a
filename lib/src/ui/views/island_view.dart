import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:prueba_tecnica_3a/src/data/repository/island_repository.dart';
import 'package:prueba_tecnica_3a/src/ui/bloc/island/island_cubit.dart';

class IslandView extends StatelessWidget {
  const IslandView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MatrixCubit(IslandRepository()),
      child: BlocBuilder<MatrixCubit, MatrixState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                'Island Matrix',
                style: TextStyle(color: Colors.white, fontSize: 28),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  _buildMatrixBody(context, state.matrix),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Write matrix dimension:',
                        style: TextStyle(color: Colors.green, fontSize: 20),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: SizedBox(
                          height: 40,
                          width: 80,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller:
                                context.read<MatrixCubit>().textController,
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.only(bottom: 2, left: 10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Total Islands: ${state.totalIslands}',
                        style:
                            const TextStyle(color: Colors.green, fontSize: 26),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      _getMatrixButton(context),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MaterialButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/nasa');
                    },
                    color: Colors.brown,
                    child: const Text(
                      'Go to Restaurant',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  MaterialButton _getMatrixButton(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        if (context.read<MatrixCubit>().textController.text.isEmpty ||
            context.read<MatrixCubit>().textController.text == '0') {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: const Text('Debe ingresar un número válido'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('Por favor, vuelva a intentarlo'),
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Ok'),
                        ),
                      ],
                    ),
                  ));
        } else {
          context.read<MatrixCubit>().createMatrix();
        }
      },
      color: Colors.green,
      child: const Text(
        'Get matrix',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

Widget _buildMatrixBody(BuildContext context, List<List<int>>? matrix) {
  int gridStateLength = matrix!.length;
  return Column(children: <Widget>[
    AspectRatio(
      aspectRatio: 1.0,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(8.0),
        decoration:
            BoxDecoration(border: Border.all(color: Colors.green, width: 2.0)),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: gridStateLength,
          ),
          itemBuilder: (context, index) =>
              _buildGridItems(context, index, matrix),
          itemCount: gridStateLength * gridStateLength,
        ),
      ),
    ),
  ]);
}

Widget _buildGridItems(BuildContext context, int index, matrix) {
  int gridStateLength = matrix.length;
  int x, y = 0;
  x = (index / gridStateLength).floor();
  y = (index % gridStateLength);
  return GestureDetector(
    onTap: () => _gridItemTapped(x, y, matrix, context),
    child: GridTile(
      child: Container(
        decoration:
            BoxDecoration(border: Border.all(color: Colors.black, width: 0.5)),
        child: BlocBuilder<MatrixCubit, MatrixState>(
          builder: (context, state) {
            return Center(
              child: _buildGridItem(x, y, state, context),
            );
          },
        ),
      ),
    ),
  );
}

_gridItemTapped(int x, int y, matrix, BuildContext context) {
  return context.read<MatrixCubit>().changeItem(x, y);
}

Widget _buildGridItem(int x, int y, MatrixState state, BuildContext context) {
  if (context.read<MatrixCubit>().state.matrix![x][y] == 0) {
    return Container(
      color: Colors.blue.withOpacity(.7),
      padding: const EdgeInsets.all(20),
      child: SvgPicture.asset('assets/svg/sea.svg'),
    );
  } else {
    return Container(
      padding: const EdgeInsets.all(10),
      color: Colors.brown.withOpacity(.6),
      child: SvgPicture.asset('assets/svg/island.svg'),
    );
  }
  // return Text(context.read<MatrixCubit>().state.matrix![x][y].toString());
}
