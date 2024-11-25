import 'package:kondus/src/modules/profile/domain/profile_model.dart';
import 'package:kondus/src/modules/profile/domain/profile_viewmodel.dart';

final class GetProfileUsecase {
  Future<ProfileState> call() async{
    return ProfileSuccessState(
      model: ProfileModel(
          owner: "Sávio Luis",
          address: "Vila Serena",
          complement: "Bloco A - Apartamento 2"),
    );
  }
}
