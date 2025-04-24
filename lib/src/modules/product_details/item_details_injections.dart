import 'package:kondus/src/modules/product_details/domain/get_item_details_usecase.dart';
import 'package:kondus/src/modules/product_details/domain/item_details_viewmodel.dart';

import '../../../app/injections.dart';

Future productDetailsInjections() async{
  getIt.registerLazySingleton(()=>GetItemDetailsUsecase());
  getIt.registerLazySingleton(()=>ItemDetailsViewmodel(getIt()));
}