import 'package:flutter/material.dart';
import 'package:kondus/core/widgets/kondus_text_field.dart';

class KonduSearchBar extends StatelessWidget {
  const KonduSearchBar({
    required this.controller,
    super.key,
    this.onCloseButtonPressed,
  });

  final TextEditingController controller;
  final void Function()? onCloseButtonPressed;

  @override
  Widget build(BuildContext context) {
    final text = controller.text;
    return KondusTextFormField(
      controller: controller,
      prefixIcon: const Icon(Icons.search),
      sufixIcon: text.length > 3
          ? IconButton(
              onPressed: onCloseButtonPressed,
              icon: const Icon(Icons.close),
            )
          : null,
    );
  }
}
