import 'package:flutter/material.dart';
import 'package:kondus/src/modules/shared/theme/app_theme.dart';

class SearchBarButton extends StatelessWidget {
  const SearchBarButton({
    required this.onTap,
    super.key,
  });

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AbsorbPointer(
        child: TextField(
          decoration: context.textFieldDecoration.copyWith(
            filled: false,
            fillColor: context.surfaceColor,
            hintText: 'Pesquise aqui um produto ou serviço',
            prefixIcon: const Icon(Icons.search),
            prefixIconColor: context.secondaryColor,
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(18)),
              borderSide: BorderSide(
                  width: 1, color: context.lightGreyColor.withOpacity(0.2)),
            ),
          ),
          controller: TextEditingController(),
        ),
      ),
    );
  }
}
