import 'package:flutter/foundation.dart';
import 'package:kondus/src/modules/profile/domain/get_profile_usecase.dart';
import 'package:kondus/src/modules/profile/domain/profile_model.dart';

final class ProfileViewModel{
  final GetProfileUsecase _usecase;
  ProfileViewModel(this._usecase);

  final ValueNotifier<ProfileState> state = ValueNotifier(ProfileIdleState());

  Future getProfile() async{
    state.value = ProfileLoadingState();
    state.value = await _usecase.call();
  }
}

sealed class ProfileState{}
final class ProfileSuccessState implements ProfileState{
  final ProfileModel model;
  ProfileSuccessState({required this.model});
}
final class ProfileIdleState implements ProfileState{}
final class ProfileErrorState implements ProfileState{
  final String message;
  ProfileErrorState({required this.message});
}
final class ProfileLoadingState implements ProfileState{}
