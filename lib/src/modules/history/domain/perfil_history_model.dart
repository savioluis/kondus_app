enum ServiceType{ purchase, rent }
enum ServiceStatus{ InProgress, Completed, Cancelled }

final class PerfilHistoryServiceModel{
  final String ownerName;
  final ServiceStatus status;
  final int id;
  final String name;
  final ServiceType type;
  final DateTime date;
  PerfilHistoryServiceModel({required this.ownerName, required this.status, required this.id, required this.name, required this.type, required this.date});
}