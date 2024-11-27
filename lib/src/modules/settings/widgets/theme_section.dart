import 'package:flutter/material.dart';
import 'package:kondus/src/modules/shared/theme/app_theme.dart';

class ThemeSection extends StatefulWidget {
  const ThemeSection({super.key});

  @override
  State<ThemeSection> createState() => _ThemeSectionState();
}

class _ThemeSectionState extends State<ThemeSection> {
  final List<String> options = ["Claro", "Escuro", "Sistema"];
  late String currentOption;

  @override
  void initState() {
    currentOption = options.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Tema", style: context.titleLarge),
        for (final option in options)
          GestureDetector(
            onTap: () => setState(() => currentOption = option),
            child: ListTile(
              title: Text(option),
              leading: Radio(
                value: option,
                groupValue: currentOption,
                onChanged: (value) =>
                    setState(() => currentOption = value.toString()),
              ),
            ),
          )
      ],
    );
  }
}
