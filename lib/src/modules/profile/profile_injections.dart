import 'package:kondus/src/modules/profile/domain/get_profile_usecase.dart';
import 'package:kondus/src/modules/profile/domain/profile_viewmodel.dart';

import '../../../app/injections.dart';

Future profileInjections() async{
  getIt.registerLazySingleton(() => GetProfileUsecase());
  getIt.registerLazySingleton(() => ProfileViewModel(getIt()));
}