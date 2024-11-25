
import 'package:kondus/src/modules/history/domain/history_model.dart';
import 'package:kondus/src/modules/history/domain/history_viewmodel.dart';

final class HistoryUsecase{
   Future<HistoryState> call() async{
    final now = DateTime.now();
    final models = [
          HistoryServiceModel(
              ownerName: "Pedro Silva",
              status: ServiceStatus.Completed,
              id: 9813,
              name: "1 Bolo de laranja",
              type: ServiceType.purchase,
              date: now
          ),
          HistoryServiceModel(
              ownerName: "Gabriel Martins",
              status: ServiceStatus.InProgress,
              id: 7182,
              name: "Livro Harry Potter",
              type: ServiceType.rent,
              date: now
          ),
          HistoryServiceModel(
              ownerName: "Antonio Chico",
              status: ServiceStatus.Cancelled,
              id: 6809,
              name: "1 Bolo de laranja",
              type: ServiceType.purchase,
              date: now
          ),
          HistoryServiceModel(
              ownerName: "José Claudio",
              status: ServiceStatus.Completed,
              id: 7182,
              name: "Livro Hobbit",
              type: ServiceType.rent,
              date: now
          ),
        ];
    final state = HistorySuccessState(data: models);
    return state;
  }
}