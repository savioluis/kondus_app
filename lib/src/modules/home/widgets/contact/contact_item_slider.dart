import 'package:flutter/material.dart';
import 'package:kondus/src/modules/home/widgets/contact/contact_item.dart';
import 'package:kondus/src/modules/shared/theme/app_theme.dart';
import 'package:kondus/src/modules/shared/theme/theme_data/colors/color_utils.dart';

class ContactItemSlider extends StatelessWidget {
  const ContactItemSlider({
    required this.contactNames,
    required this.itemCount,
    super.key,
  });

  final int itemCount;
  final List<String> contactNames;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: 110,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => ContactItem(
          name: contactNames[index],
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
