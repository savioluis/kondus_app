import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kondus/app/routing/app_routes.dart';
import 'package:kondus/app/routing/route_arguments.dart';
import 'package:kondus/core/providers/navigator/navigator_provider.dart';
import 'package:kondus/core/services/dtos/product_dto.dart';
import 'package:kondus/core/theme/app_theme.dart';
import 'package:kondus/core/utils/dialog_helper.dart';
import 'package:kondus/core/utils/snack_bar_helper.dart';
import 'package:kondus/core/widgets/error_state_widget.dart';
import 'package:kondus/core/widgets/header_section.dart';
import 'package:kondus/core/widgets/kondus_app_bar.dart';
import 'package:kondus/src/modules/my_announcements/presentation/my_announcements_controller.dart';
import 'package:kondus/src/modules/my_announcements/presentation/my_announcements_state.dart';
import 'package:kondus/src/modules/my_announcements/widgets/announcement_item.dart';

class MyItemsPage extends StatefulWidget {
  const MyItemsPage({super.key});

  @override
  State<MyItemsPage> createState() => _MyItemsPageState();
}

class _MyItemsPageState extends State<MyItemsPage> {
  late final MyAnnouncementsController controller;

  @override
  void initState() {
    super.initState();
    controller = MyAnnouncementsController()..loadAnnouncements();
    controller.addListener(_controllerListener);
  }

  void _controllerListener() {
    final state = controller.state;

    if (state is MyAnnouncementsFailureState) {
      SnackBarHelper.showMessageSnackBar(
          message: state.error.failureMessage,
          context: context,
          duration: const Duration(seconds: 3));
    } else if (state is MyAnnouncementsSuccessState && state.hasRemovedItem) {
      SnackBarHelper.showMessageSnackBar(
          message: 'Item removido com sucesso.',
          context: context,
          duration: const Duration(seconds: 3));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final state = controller.state;
        if (state is MyAnnouncementsLoadingState) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is MyAnnouncementsFailureState) {
          return ErrorStateWidget(
            error: state.error,
            onRetryPressed: () {},
          );
        } else if (state is MyAnnouncementsSuccessState) {
          return Scaffold(
            appBar: const KondusAppBar(),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HeaderSection(
                      title: 'Seus anúncios',
                      subtitle: [
                        TextSpan(
                          text: 'Ajuste suas preferências e configurações',
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    RefreshIndicator(
                      onRefresh: () async =>
                          await controller.loadAnnouncements(),
                      child: state.items.isNotEmpty
                          ? ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return AnnouncementItem(
                                  item: state.items[index],
                                  onTap: () async =>
                                      NavigatorProvider.navigateTo(
                                    AppRoutes.productDetails,
                                    arguments: RouteArguments<int>(
                                      state.items[index].id,
                                    ),
                                  ),
                                  onRemove: () async {
                                    await DialogHelper.showAlert(
                                      context: context,
                                      title: 'Aviso',
                                      confirmLabel: 'REMOVER',
                                      cancelLabel: 'CANCELAR',
                                      onCancel: () =>
                                          NavigatorProvider.goBack(),
                                      onConfirm: () async {
                                        await controller.removeAnnouncement(
                                            id: state.items[index].id);

                                        await controller.loadAnnouncements();

                                        NavigatorProvider.goBack();
                                      },
                                      message:
                                          'Você está prestes a remover o item ${state.items[index].title}. Tem certeza que deseja fazer isso ?',
                                    );
                                  },
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 12,
                              ),
                              itemCount: state.items.length,
                            )
                          : const Padding(
                              padding: EdgeInsets.only(top: 192),
                              child: Center(
                                child: Text(
                                  'Você não possui nenhum item anunciado.',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
