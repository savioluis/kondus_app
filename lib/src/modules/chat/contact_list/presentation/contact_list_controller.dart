import 'package:flutter/material.dart';
import 'contact_list_state.dart';

class ContactListController extends ChangeNotifier {
  ContactListState _state = ContactListInitial();

  ContactListState get state => _state;

  void _emitState(ContactListState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> fetchContacts() async {
    _emitState(ContactListLoading());
    try {
      await Future.delayed(const Duration(seconds: 1));
      final contacts = [
        {'uid': '1', 'name': 'Alice', 'apartment': 'Apartamento 1 - Bloco A'},
        {'uid': '2', 'name': 'Bob', 'apartment': 'Apartamento 2 - Bloco D'},
        {'uid': '3', 'name': 'Charlie', 'apartment': 'Apartamento 105 - Bloco B'},
        {'uid': '4', 'name': 'David', 'apartment': 'Apartamento 309 - Bloco J'},
        {'uid': '5', 'name': 'Elias', 'apartment': 'Apartamento  - Bloco H'},
        {'uid': '6', 'name': 'Filipe', 'apartment': 'Casa 3'},
        {'uid': '7', 'name': 'Greg', 'apartment': 'Casa 06'},
        {'uid': '8', 'name': 'Heitor', 'apartment': 'Casa 06'},
        {'uid': '9', 'name': 'Isabel', 'apartment': 'Casa 27'},
        {'uid': '10', 'name': 'Jay', 'apartment': 'Apartamento 48 - Torre 3 - Bloco 1'},
      ];
      _emitState(ContactListSuccess(contacts));
    } catch (e) {
      _emitState(ContactListFailure('Erro ao carregar contatos: $e'));
    }
  }
}
