import 'package:flutter/material.dart';
import 'package:kondus/app/routing/app_routes.dart';
import 'package:kondus/app/routing/route_arguments.dart';
import 'package:kondus/core/providers/navigator/navigator_provider.dart';
import 'package:kondus/src/modules/chat/contact_chat/presentation/contact_chat_page.dart';
import 'package:kondus/src/modules/chat/contact_list/model/contact_model.dart';
import 'package:kondus/src/modules/home/widgets/contact/contact_item.dart';
import 'package:kondus/core/theme/app_theme.dart';
import 'package:kondus/core/theme/theme_data/colors/color_utils.dart';

class ContactItemSlider extends StatelessWidget {
  const ContactItemSlider({
    required this.contacts,
    required this.itemCount,
    super.key,
  });

  final int itemCount;
  final List<ContactModel> contacts;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return ContactItem(
            onPressed: () {
              NavigatorProvider.navigateTo(
                AppRoutes.contactChat,
                arguments: RouteArguments<List<String>>(
                  [contacts[index].id, contacts[index].name],
                ),
              );
            },
            name: contacts[index].name,
            iconColor: context.whiteColor,
            backgroundColor: ColorUtils.generateTonalColors(
              baseColor: context.blueColor,
              count: itemCount,
            ).toList()[index].withOpacity(0.38),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(
          width: 12,
        ),
        itemCount: itemCount,
      ),
    );
  }
}
