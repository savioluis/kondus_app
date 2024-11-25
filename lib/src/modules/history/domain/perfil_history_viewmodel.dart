import 'package:flutter/cupertino.dart';
import 'package:kondus/src/modules/history/domain/perfil_history_model.dart';
import 'package:kondus/src/modules/history/domain/perfil_history_usecase.dart';

final class PerfilHistoryViewModel{
  final PerfilHistoryUsecase usecase;
  PerfilHistoryViewModel({required this.usecase});

  ValueNotifier<PerfilHistoryState> state = ValueNotifier(PerfilHistoryIdleState());

  Future getHistory() async{
    state.value = PerfilHistoryLoadingState();
    state.value = await usecase.call();
  }
}

sealed class PerfilHistoryState{}
final class PerfilHistoryIdleState implements PerfilHistoryState{}
final class PerfilHistoryLoadingState implements PerfilHistoryState{}
final class PerfilHistoryErrorState implements PerfilHistoryState{
  final String message;
  PerfilHistoryErrorState({required this.message});
}
final class PerfilHistorySuccessState implements PerfilHistoryState{
  final List<PerfilHistoryServiceModel> data;
  PerfilHistorySuccessState({required this.data});
}