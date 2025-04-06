import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:kondus/core/services/auth/auth_service.dart';
import 'package:kondus/core/services/items/items_service.dart';
import 'package:kondus/src/modules/home/presentation/home_state.dart';

class HomeController extends ChangeNotifier {
  final AuthService _authService = GetIt.instance<AuthService>();
  final ItemsService _itemsService = GetIt.instance<ItemsService>();

  final _state = HomeInitialState();

  HomeState get state => _state;

  loadInitialData() {
    loadUserData();
  }

  loadUserData() async {
    final userId = await _authService.getUserId();
  }

  loadItems() async {
    final items = await _itemsService.getAllItems();
  }
}
