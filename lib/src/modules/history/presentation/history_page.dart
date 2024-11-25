import 'package:flutter/material.dart';
import 'package:kondus/src/modules/history/domain/history_viewmodel.dart';
import 'package:kondus/src/modules/history/widgets/history_list.dart';
import 'package:kondus/src/modules/shared/theme/app_theme.dart';

import '../../../../app/injections.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _PerfilHistoryPageState();
}

class _PerfilHistoryPageState extends State<HistoryPage> {
  final viewmodel = getIt<HistoryViewModel>();

  @override
  void initState() {
    viewmodel.getHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(),
        body: ValueListenableBuilder(
            valueListenable: viewmodel.state,
            builder: (context, state, widget) {
              return switch (state) {
                HistoryIdleState() => const SizedBox(),
                HistoryLoadingState() => const Center(
                    child: CircularProgressIndicator(),
                  ),
                HistoryErrorState(message: final message) =>
                  Center(child: Text(message, style: context.bodyLarge)),
                HistorySuccessState(data: final data) =>
                  HistoryList(models: data)
              };
            }),
      );
}
