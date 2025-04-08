import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:kondus/core/services/auth/auth_service.dart';
import 'package:kondus/core/services/items/items_service.dart';
import 'package:kondus/src/modules/home/models/item_model.dart';
import 'package:kondus/src/modules/home/models/user_model.dart';
import 'package:kondus/src/modules/home/presentation/home_state.dart';

class HomeController extends ChangeNotifier {
  final AuthService _authService = GetIt.instance<AuthService>();
  final ItemsService _itemsService = GetIt.instance<ItemsService>();

  HomeState _state = HomeInitialState();

  HomeState get state => _state;

  Future<void> loadInitialData() async {
    _emitState(HomeLoadingState());
    try {
      final userData = await loadUserData();

      if (userData == null) {
        _emitState(HomeFailureState(
            message: 'Falha ao recuperar os dados do usuário.'));
        return;
      }

      final itemsData = await loadItems();

      if (itemsData == null) {
        _emitState(HomeFailureState(message: 'Falha ao recuperar os items.'));
        return;
      }

      _emitState(
        HomeSuccessState(
          user: userData,
          items: itemsData,
        ),
      );
    } catch (e) {
      _emitState(HomeFailureState(message: e.toString()));
    }
  }

  Future<UserModel?> loadUserData() async {
    try {
      final userInfoResponse = await _authService.getLoggedUserInfo();

      if (userInfoResponse != null) {
        final userInfo = userInfoResponse.toModel();
        return userInfo;
      }

      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ItemModel>?> loadItems() async {
    try {
      final itemsResponse = await _itemsService.getAllItems();

      if (itemsResponse != null) {
        final items = ItemModel.getItemsfromDTO(itemsResponse);
        return items;
      }

      return null;
    } catch (e) {
      rethrow;
    }
  }

  void _emitState(HomeState newState) {
    _state = newState;
    notifyListeners();
    log('Estado emitido: $newState');
  }
}
