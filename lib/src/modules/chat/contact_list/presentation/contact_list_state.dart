import 'package:equatable/equatable.dart';

abstract class ContactListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ContactListInitial extends ContactListState {}

class ContactListLoading extends ContactListState {}

class ContactListSuccess extends ContactListState {
  final List<Map<String, String>> contacts;

  ContactListSuccess(this.contacts);

  @override
  List<Object?> get props => [contacts];
}

class ContactListFailure extends ContactListState {
  final String errorMessage;

  ContactListFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
