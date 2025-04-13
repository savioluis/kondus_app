import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kondus/app/routing/app_routes.dart';
import 'package:kondus/app/routing/route_arguments.dart';
import 'package:kondus/core/providers/navigator/navigator_provider.dart';
import 'package:kondus/core/services/dtos/product_dto.dart';
import 'package:kondus/core/theme/app_theme.dart';
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
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return AnnouncementItem(
                          item: state.items[index],
                          onTap: () async => NavigatorProvider.navigateTo(
                            AppRoutes.productDetails,
                            arguments: RouteArguments<int>(
                              state.items[index].id,
                            ),
                          ),
                          onRemove: () {
                            
                          },
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 12,
                      ),
                      itemCount: state.items.length,
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
