import 'package:flutter/material.dart';
import 'package:kondus/app/routing/app_routes.dart';
import 'package:kondus/core/providers/navigator/navigator_provider.dart';

class RegisterController {
  RegisterController();

  final fullNameEC = TextEditingController();
  final emailEC = TextEditingController();
  final birthDateEC = TextEditingController();
  final passwordEC = TextEditingController();
  final confirmPasswordEC = TextEditingController();

  void registerAccount(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
      'Conta criada com sucesso !',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    )));
    NavigatorProvider.replaceWith(AppRoutes.shareYourItems);
  }
}
