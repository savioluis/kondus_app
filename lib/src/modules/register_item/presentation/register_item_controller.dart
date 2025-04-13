import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kondus/core/services/items/items_service.dart';
import 'package:kondus/src/modules/register_item/presentation/register_item_state.dart';

class RegisterItemController extends ChangeNotifier {

  final ItemsService _itemsService = GetIt.instance<ItemsService>();

  RegisterItemState _state = RegisterItemInitialState();

  RegisterItemState get state => _state;

  final nameEC = TextEditingController();
  final descriptionEC = TextEditingController();

  Future<void> registerItem() async {}
}