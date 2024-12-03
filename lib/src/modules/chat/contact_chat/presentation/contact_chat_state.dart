import 'package:equatable/equatable.dart';

abstract class ContactChatState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ContactChatInitial extends ContactChatState {}

class ContactChatLoading extends ContactChatState {}

class ContactChatSuccess extends ContactChatState {
  final List<Map<String, dynamic>> messages;

  ContactChatSuccess(this.messages);

  @override
  List<Object?> get props => [messages];
}

class ContactChatFailure extends ContactChatState {
  final String errorMessage;

  ContactChatFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
