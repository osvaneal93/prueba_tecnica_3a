import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_tecnica_3a/src/data/repository/gift_repo.dart';
import 'package:prueba_tecnica_3a/src/ui/bloc/bottom_bar/bottom_bar_cubit.dart';
import 'package:prueba_tecnica_3a/src/ui/bloc/gift_bloc/gift_bloc.dart';
import 'package:prueba_tecnica_3a/src/ui/views/island_view.dart';
import 'package:prueba_tecnica_3a/src/ui/views/nasa_view.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => GithyRepo(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => GiftBloc(GithyRepo())..add(LoadGiftEvent()),
          ),
          BlocProvider(
            create: (context) => BottomBarCubit(),
          ),
        ],
        child: MaterialApp(title: 'Material App', initialRoute: '/', routes: {
          '/': (context) => const IslandView(),
          '/nasa': (context) => const NasaView()
        }),
      ),
    );
  }
}
