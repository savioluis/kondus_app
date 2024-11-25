import 'package:flutter/cupertino.dart';
import 'package:kondus/src/modules/history/domain/history_model.dart';
import 'package:kondus/src/modules/history/domain/history_usecase.dart';

final class HistoryViewModel{
  final HistoryUsecase usecase;
  HistoryViewModel({required this.usecase});

  ValueNotifier<HistoryState> state = ValueNotifier(HistoryIdleState());

  Future getHistory() async{
    state.value = HistoryLoadingState();
    state.value = await usecase.call();
  }
}

sealed class HistoryState{}
final class HistoryIdleState implements HistoryState{}
final class HistoryLoadingState implements HistoryState{}
final class HistoryErrorState implements HistoryState{
  final String message;
  HistoryErrorState({required this.message});
}
final class HistorySuccessState implements HistoryState{
  final List<HistoryServiceModel> data;
  HistorySuccessState({required this.data});
}