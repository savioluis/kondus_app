import 'package:get_it/get_it.dart';
import 'package:kondus/src/modules/history/history_injections.dart';

final getIt = GetIt.instance;

Future<void> initInjections() async {
  await historyInjections();
}
