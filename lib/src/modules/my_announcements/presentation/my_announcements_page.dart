import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:kondus/app/routing/app_routes.dart';
import 'package:kondus/app/routing/route_arguments.dart';
import 'package:kondus/core/providers/navigator/navigator_provider.dart';
import 'package:kondus/core/theme/app_theme.dart';
import 'package:kondus/core/utils/dialog_helper.dart';
import 'package:kondus/core/utils/snack_bar_helper.dart';
import 'package:kondus/core/widgets/error_state_widget.dart';
import 'package:kondus/core/widgets/kondus_elevated_button.dart';
import 'package:kondus/src/modules/my_announcements/presentation/my_announcements_controller.dart';
import 'package:kondus/src/modules/my_announcements/presentation/my_announcements_state.dart';
import 'package:kondus/src/modules/my_announcements/widgets/announcement_appbar.dart';
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
  
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
            appBar: const AnnouncementAppbar(),
            body: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: state.items.isNotEmpty
                    ? RefreshIndicator(
                        color: context.whiteColor,
                        backgroundColor: context.blueColor,
                        onRefresh: () async => controller.loadAnnouncements(),
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            return AnnouncementItem(
                              item: state.items[index],
                              onTap: () async => NavigatorProvider.navigateTo(
                                AppRoutes.itemDetails,
                                arguments: RouteArguments<List<dynamic>>(
                                  [state.items[index].id, true],
                                ),
                              ),
                              onRemove: () async {
                                await DialogHelper.showAlert(
                                  context: context,
                                  title: 'Aviso',
                                  confirmLabel: 'REMOVER',
                                  cancelLabel: 'CANCELAR',
                                  onCancel: () => NavigatorProvider.goBack(),
                                  onConfirm: () async {
                                    NavigatorProvider.goBack();

                                    await controller.removeAnnouncement(
                                        id: state.items[index].id);

                                    await controller.loadAnnouncements();
                                  },
                                  message:
                                      'Você está prestes a remover o item ${state.items[index].title}. Tem certeza que deseja fazer isso ?',
                                );
                              },
                            );
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 12,
                          ),
                          itemCount: state.items.length,
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(
                            left: 24, right: 24, bottom: 48),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Icon(
                              HugeIcons.strokeRoundedPackage,
                              size: 64,
                              color: context.blueColor.withOpacity(0.8),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Você ainda não anunciou algo',
                              style: context.titleLarge!.copyWith(
                                fontSize: 22,
                                color: context.primaryColor.withOpacity(0.7),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Seus vizinhos podem estar precisando!',
                              style: context.labelMedium!.copyWith(
                                fontSize: 20,
                                color: context.primaryColor.withOpacity(0.3),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 24),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 36),
                              child: KondusButton(
                                label: 'ANUNCIAR',
                                backgroundColor:
                                    context.blueColor.withOpacity(0.8),
                                onPressed: () => NavigatorProvider.navigateTo(
                                  AppRoutes.shareYourItems,
                                  arguments:
                                      RouteArguments<VoidCallback?>(null),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
