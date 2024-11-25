import 'package:kondus/src/modules/history/domain/perfil_history_usecase.dart';
import 'package:kondus/src/modules/history/domain/perfil_history_viewmodel.dart';

import '../../../app/injections.dart';

Future<void> historyInjections() async{
  getIt.registerLazySingleton<PerfilHistoryUsecase>(() => PerfilHistoryUsecase());
  getIt.registerLazySingleton<PerfilHistoryViewModel>( () =>
    PerfilHistoryViewModel(usecase: getIt<PerfilHistoryUsecase>())
  );
}