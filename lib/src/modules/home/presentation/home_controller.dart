import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kondus/core/error/kondus_error.dart';
import 'package:kondus/core/providers/http/error/http_error.dart';
import 'package:kondus/core/services/auth/auth_service.dart';
import 'package:kondus/core/services/auth/session_manager.dart';
import 'package:kondus/core/services/chat/chat_service.dart';
import 'package:kondus/core/services/items/items_service.dart';
import 'package:kondus/core/services/items/models/items_filter_model.dart';
import 'package:kondus/src/modules/chat/contact_list/model/contact_model.dart';
import 'package:kondus/src/modules/home/models/item_model.dart';
import 'package:kondus/src/modules/home/models/user_model.dart';
import 'package:kondus/src/modules/home/presentation/home_state.dart';

class HomeController extends ChangeNotifier {
  final AuthService _authService = GetIt.instance<AuthService>();
  final ItemsService _itemsService = GetIt.instance<ItemsService>();
  final ChatService _chatService = GetIt.instance<ChatService>();

  HomeState _state = HomeInitialState();

  HomeState get state => _state;

  Future<void> loadInitialData() async {
    _emitState(HomeLoadingState());
    try {
      final userData = await loadUserData();

      if (userData == null) {
        _emitState(
          HomeFailureState(
            error: KondusError(
              message: 'Falha ao obter os dados do usuário',
              type: KondusErrorType.empty,
            ),
          ),
        );
        return;
      }

      final usersIdsWithWhomUserHasChated =
          await _chatService.getUsersIdsContacts(limit: 7);
      final usersFromLocal = await _authService.getUsersInfo();

      final contacts = usersFromLocal.users
          .where(
            (user) =>
                usersIdsWithWhomUserHasChated.contains(user.id.toString()),
          )
          .toList();

      String initialCategory = 'Todos';

      final itemsData = await loadItems(initialCategory);

      if (itemsData == null) {
        _emitState(
          HomeFailureState(
            error: KondusError(
              message: 'Falha ao recuperar os items.',
              type: KondusErrorType.failedToLoad,
            ),
          ),
        );
        return;
      }

      _emitState(
        HomeSuccessState(
            user: userData,
            items: itemsData,
            contacts: ContactModel.fromUserDTOList(contacts)),
      );
    } on HttpError catch (e) {
      _emitState(HomeFailureState(error: e));
    }
  }

  Future<UserModel?> loadUserData() async {
    try {
      final userInfoResponse = await _authService.getLoggedUserInfo();

      if (userInfoResponse == null) return null;

      final userInfo = userInfoResponse.toModel();
      return userInfo;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ItemModel>?> loadItems(String category) async {
    try {
      final type = category.toLowerCase();

      final response = await _itemsService.getAllItems(
        filters: ItemsFiltersModel(
          query: '',
          types: type == 'todos'
              ? []
              : [
                  ItemTypeExtension.fromJsonValue(category),
                ],
          categoriesIds: [],
        ),
      );

      if (response == null) {
        return null;
      }

      final items = ItemModel.getItemsfromDTO(response);

      return items;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> loadItemsWithCategoryFilter(String category) async {
    final currentState = state as HomeSuccessState;

    _emitState(currentState.copyWith(isLoadingMoreItems: true));

    try {
      final items = await loadItems(category);

      if (items == null) {
        _emitState(
          HomeFailureState(
            error: KondusError(
              message: 'Erro ao carregar items',
              type: KondusErrorType.failedToLoad,
            ),
          ),
        );
        return;
      }

      _emitState(currentState.copyWith(items: items));
    } catch (e) {
      rethrow;
    }
  }

  logout() {
    GetIt.instance<SessionManager>().logout();
  }

  void _emitState(HomeState newState) {
    _state = newState;
    notifyListeners();
    log('Estado emitido: $newState');
  }
}
