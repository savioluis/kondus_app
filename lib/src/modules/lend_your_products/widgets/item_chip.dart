import 'package:flutter/material.dart';
import 'package:kondus/core/theme/app_theme.dart';

class ItemChip extends StatefulWidget {
  const ItemChip({
    required this.text,
    required this.onTap,
    this.isSelected = false,
    super.key,
  });

  final String text;
  final VoidCallback onTap;
  final bool isSelected;

  @override
  _ItemChipState createState() => _ItemChipState();
}

class _ItemChipState extends State<ItemChip> {
  late bool _isSelected;

  @override
  void initState() {
    super.initState();
    _isSelected = widget.isSelected;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
        });
        widget.onTap();
      },
      child: Container(
        // margin: const EdgeInsets.only(right: 8.0),
        child: Chip(
          label: Text(widget.text.toUpperCase()),
          backgroundColor: _isSelected ? context.blueColor : context.surfaceColor,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: context.lightGreyColor.withOpacity(0.1),
            ),
            borderRadius: BorderRadius.circular(18),
          ),
          labelStyle: TextStyle(
            color: _isSelected ? context.whiteColor : context.primaryColor,
          ),
        ),
      ),
    );
  }
}
