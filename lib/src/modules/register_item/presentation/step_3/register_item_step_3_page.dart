import 'package:flutter/material.dart';
import 'package:kondus/core/services/items/models/items_filter_model.dart';

class RegisterItemStep3Page extends StatefulWidget {
  const RegisterItemStep3Page({
    this.itemType,
    super.key,
    required this.name,
    required this.price,
    required this.description,
    required this.type,
    required this.categories,
  });

  final ItemType? itemType;
  final String name;
  final String price;
  final String description;
  final String type;
  final List<String> categories;

  @override
  State<RegisterItemStep3Page> createState() => _RegisterItemStep3PageState();
}

class _RegisterItemStep3PageState extends State<RegisterItemStep3Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.name),
            Text(widget.price),
            Text(widget.description),
            Text(widget.type),
            Text(widget.categories.toString()),
          ],
        ),
      ),
    );
  }
}
