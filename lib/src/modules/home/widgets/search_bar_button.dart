import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:kondus/app/routing/app_routes.dart';
import 'package:kondus/app/routing/route_arguments.dart';
import 'package:kondus/core/providers/navigator/navigator_provider.dart';
import 'package:kondus/core/theme/app_theme.dart';

class SearchBarButton extends StatelessWidget {
  const SearchBarButton({
    required this.onTap,
    super.key,
  });

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: GestureDetector(
            onTap: onTap,
            child: AbsorbPointer(
              child: TextField(
                decoration: context.textFieldDecoration.copyWith(
                  filled: false,
                  fillColor: context.surfaceColor,
                  hintText: 'Buscar produtos ou serviços...',
                  prefixIcon: const Icon(Icons.search),
                  prefixIconColor: context.secondaryColor,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(18)),
                    borderSide: BorderSide(
                        width: 1,
                        color: context.lightGreyColor.withOpacity(0.2)),
                  ),
                ),
                controller: TextEditingController(),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 1,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () async {
                NavigatorProvider.navigateTo(
                  AppRoutes.shareYourItems,
                  arguments: RouteArguments<VoidCallback?>(null),
                );
              },
              borderRadius: BorderRadius.circular(12),
              child: Ink(
                height: 56,
                decoration: BoxDecoration(
                  color: context.blueColor.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Icon(
                    HugeIcons.strokeRoundedAdd01,
                    color: context.whiteColor,
                    size: 32,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
