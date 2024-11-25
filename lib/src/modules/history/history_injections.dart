import 'package:kondus/src/modules/history/domain/history_usecase.dart';
import 'package:kondus/src/modules/history/domain/history_viewmodel.dart';

import '../../../app/injections.dart';

Future<void> historyInjections() async{
  getIt.registerLazySingleton<HistoryUsecase>(() => HistoryUsecase());
  getIt.registerLazySingleton<HistoryViewModel>( () =>
    HistoryViewModel(getIt())
  );
}