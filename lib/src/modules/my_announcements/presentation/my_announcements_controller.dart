import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:kondus/core/error/kondus_error.dart';
import 'package:kondus/core/providers/http/error/http_error.dart';
import 'package:kondus/core/services/items/items_service.dart';
import 'package:kondus/src/modules/my_announcements/presentation/my_announcements_state.dart';

class MyAnnouncementsController extends ChangeNotifier {
  final ItemsService _itemsService = GetIt.instance<ItemsService>();

  MyAnnouncementsState _state = MyAnnouncementsInitialState();

  MyAnnouncementsState get state => _state;

  Future<void> loadAnnouncements() async {
    _emitState(MyAnnouncementsLoadingState());
    try {
      final response = await _itemsService.getMyItems();

      if (response == null) {
        MyAnnouncementsFailureState(
          error: KondusError(
            message: 'Falha a obter seus anúncios.',
            type: KondusErrorType.unknown,
          ),
        );
        return;
      }

      _emitState(MyAnnouncementsSuccessState(items: response));
    } on HttpError catch (e) {
      _emitState(MyAnnouncementsFailureState(error: e));
    }
  }

  Future<void> removeAnnouncement({required int id}) async {
    final successState = state as MyAnnouncementsSuccessState;

    _emitState(MyAnnouncementsLoadingState());
    try {
      await _itemsService.removeItem(id: id);
      
      _emitState(successState.copyWith(hasRemovedItem: true));
    } on HttpError catch (e) {
      _emitState(MyAnnouncementsFailureState(error: e));
    }
  }

  _emitState(MyAnnouncementsState newState) {
    _state = newState;
    notifyListeners();
    log('Novo estado emitido: $newState');
  }
}
