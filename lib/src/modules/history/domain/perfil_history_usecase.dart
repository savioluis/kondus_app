
import 'package:kondus/src/modules/history/domain/perfil_history_model.dart';
import 'package:kondus/src/modules/history/domain/perfil_history_viewmodel.dart';

final class PerfilHistoryUsecase{
   Future<PerfilHistoryState> call() async{
    final now = DateTime.now();
    final models = [
          PerfilHistoryServiceModel(
              ownerName: "Pedro Silva",
              status: ServiceStatus.Completed,
              id: 9813,
              name: "1 Bolo de laranja",
              type: ServiceType.purchase,
              date: now
          ),
          PerfilHistoryServiceModel(
              ownerName: "Gabriel Martins",
              status: ServiceStatus.InProgress,
              id: 7182,
              name: "Livro Harry Potter",
              type: ServiceType.rent,
              date: now
          ),
          PerfilHistoryServiceModel(
              ownerName: "Antonio Chico",
              status: ServiceStatus.Cancelled,
              id: 6809,
              name: "1 Bolo de laranja",
              type: ServiceType.purchase,
              date: now
          ),
          PerfilHistoryServiceModel(
              ownerName: "José Claudio",
              status: ServiceStatus.Completed,
              id: 7182,
              name: "Livro Hobbit",
              type: ServiceType.rent,
              date: now
          ),
        ];
    final state = PerfilHistorySuccessState(data: models);
    return state;
  }
}