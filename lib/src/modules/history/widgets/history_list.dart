import 'package:flutter/material.dart';
import 'package:kondus/src/modules/history/widgets/history_tile.dart';
import 'package:kondus/core/theme/app_theme.dart';
import '../domain/history_model.dart';

class HistoryList extends StatelessWidget {
  final List<HistoryServiceModel> models;
  const HistoryList({super.key, required this.models});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24,right: 24),
      child: ListView.builder(
          itemCount: models.length + 1,
          itemBuilder: (itemBuilderContext, idx) {
            if (idx == 0) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Text("Histórico", style: context.displaySmall),
              );
            }

            final model = models[idx - 1];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _formatDate(model.date),
                  style: context.titleSmall,
                ),
                const SizedBox(height: 10),
                HistoryTile(model: model),
                const SizedBox(height: 30)
              ],
            );
          }),
    );
  }
}

String _formatDate(DateTime date) {
  String formatPortugueseMonth(DateTime date) => switch (date.month) {
        1 => "janeiro",
        2 => "fevereiro",
        3 => "março",
        4 => "abril",
        5 => "maio",
        6 => "junho",
        7 => "julho",
        8 => "agosto",
        9 => "setembro",
        10 => "outubro",
        11 => "novembro",
        12 => "dezembro",
        _ => "",
      };
  String formatPortugueseWeekDay(DateTime date) => switch (date.weekday) {
        DateTime.monday => "Segunda",
        DateTime.tuesday => "Terça",
        DateTime.wednesday => "Quarta",
        DateTime.thursday => "Quinta",
        DateTime.friday => "Sexta",
        DateTime.saturday => "Sábado",
        DateTime.sunday => "Domingo",
        _ => "",
      };
  String formatDay(DateTime date) =>
      date.day > 10 ? "${date.day}" : "0${date.day}";

  final month = formatPortugueseMonth(date);
  final weekDayAbreviation = formatPortugueseWeekDay(date).substring(0, 3);
  final day = formatDay(date);
  return "$weekDayAbreviation. $day $month de ${date.year}";
}
