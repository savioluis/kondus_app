import 'package:kondus/src/modules/product_details/domain/get_product_details_usecase.dart';
import 'package:kondus/src/modules/product_details/domain/product_details_viewmodel.dart';

import '../../../app/injections.dart';

Future productDetailsInjections() async{
  getIt.registerLazySingleton(()=>GetProductDetailsUsecase());
  getIt.registerLazySingleton(()=>ProductDetailsViewmodel(getIt()));
}