import 'package:flutter/material.dart';
import 'package:kondus/src/modules/shared/theme/app_theme.dart';
import '../domain/perfil_history_model.dart';
import 'history_info_line.dart';

class HistoryTile extends StatelessWidget {
  final PerfilHistoryServiceModel model;
  const HistoryTile({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: context.primaryColor.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(model.ownerName, style: context.titleMedium),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_forward_ios),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 1,bottom: 1),
              child: Divider(thickness: 0.1, color: context.greyColor),
            ),
            Column(
              children: [
                HistoryInfoLine(
                  icon: _iconFromStatus(model.status, context),
                  text: "${_textFromStatus(model.status)} - N° ${model.id} ",
                ),
                HistoryInfoLine(
                  icon: Icon(
                    Icons.add_shopping_cart_outlined,
                    color: _colorFromStatus(model.status, context),
                  ),
                  text: model.name,
                ),
                HistoryInfoLine(
                  icon: Icon(Icons.shopping_bag_outlined,
                      color: _colorFromStatus(model.status, context)),
                  text: _textFromServiceType(model.type),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _textFromServiceType(ServiceType type) => switch (type) {
        ServiceType.purchase => "Compra",
        ServiceType.rent => "Empréstimo",
      };

  String _textFromStatus(ServiceStatus status) => switch (status) {
        ServiceStatus.InProgress => "Pedido em andamento",
        ServiceStatus.Completed => "Pedido concluído",
        ServiceStatus.Cancelled => "Pedido não efetuado",
      };

  Color _colorFromStatus(ServiceStatus status, BuildContext context) =>
      switch (status) {
        ServiceStatus.InProgress => context.blueColor.withOpacity(0.36),
        ServiceStatus.Completed => context.blueColor,
        ServiceStatus.Cancelled => Colors.red,
      };

  Icon _iconFromStatus(ServiceStatus status, BuildContext context) =>
      switch (status) {
        ServiceStatus.InProgress => Icon(
            Icons.remove_circle_outline,
            color: _colorFromStatus(status, context),
          ),
        ServiceStatus.Completed => Icon(
            Icons.check_circle_outline,
            color: _colorFromStatus(status, context),
          ),
        ServiceStatus.Cancelled => Icon(
            Icons.cancel_outlined,
            color: _colorFromStatus(status, context),
          ),
      };
}