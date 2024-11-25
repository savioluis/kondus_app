import 'package:flutter/material.dart';
import 'package:kondus/src/modules/history/domain/perfil_history_viewmodel.dart';
import 'package:kondus/src/modules/history/widgets/history_list.dart';
import 'package:kondus/src/modules/shared/theme/app_theme.dart';

import '../../../../app/injections.dart';

class PerfilHistoryPage extends StatefulWidget {
  const PerfilHistoryPage({super.key});

  @override
  State<PerfilHistoryPage> createState() => _PerfilHistoryPageState();
}

class _PerfilHistoryPageState extends State<PerfilHistoryPage> {
  final viewmodel = getIt<PerfilHistoryViewModel>();

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
                PerfilHistoryIdleState() => const SizedBox(),
                PerfilHistoryLoadingState() => const Center(
                    child: CircularProgressIndicator(),
                  ),
                PerfilHistoryErrorState(message: final message) =>
                  Center(child: Text(message, style: context.bodyLarge)),
                PerfilHistorySuccessState(data: final data) =>
                  HistoryList(models: data)
              };
            }),
      );
}
