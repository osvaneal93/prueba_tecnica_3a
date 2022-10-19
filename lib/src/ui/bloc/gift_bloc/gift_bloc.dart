import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:prueba_tecnica_3a/src/data/repository/gift_repo.dart';

part 'gift_event.dart';
part 'gift_state.dart';

class GiftBloc extends Bloc<GiftEvent, GiftState> {
  final GithyRepo _giftRepo;
  int pageIndex = 0;
  PageController pageController = PageController();
  GiftBloc(this._giftRepo) : super(GiftInitial()) {
    on<GiftEvent>((event, emit) async {
      final giftList = await _giftRepo.getGit();
      emit(GiftLoadedState(giftList));
    });
  }
}
