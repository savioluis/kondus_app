import 'package:flutter/material.dart';
import 'package:kondus/src/modules/chat/contact_chat/presentation/contact_chat_page.dart';
import 'package:kondus/src/modules/home/widgets/contact/contact_item.dart';
import 'package:kondus/src/modules/shared/theme/app_theme.dart';
import 'package:kondus/src/modules/shared/theme/theme_data/colors/color_utils.dart';

class ContactItemSlider extends StatelessWidget {
  const ContactItemSlider({
    required this.contacts,
    required this.itemCount,
    super.key,
  });

  final int itemCount;
  final List<Map<String, String>> contacts;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: 110,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => ContactItem(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ContactChatPage(
                  uid: contacts[index]['uid']!,
                  name: contacts[index]['name']!,
                  apartment: contacts[index]['apartment']!,
                ),
              ),
            );
          },
          name: contacts[index]['name']!,
          iconColor: context.whiteColor,
          backgroundColor: ColorUtils.generateTonalColors(
            baseColor: context.blueColor,
            count: itemCount,
          ).toList()[index].withOpacity(0.38),
        ),
        separatorBuilder: (context, index) => const SizedBox(
          width: 12,
        ),
        itemCount: itemCount,
      ),
    );
  }
}
