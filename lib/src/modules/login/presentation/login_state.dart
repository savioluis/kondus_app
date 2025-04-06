sealed class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  LoginSuccessState({required this.authToken});
  final String authToken;
}

class LoginFailureState extends LoginState {
  LoginFailureState({required this.message});
  final String message;
}