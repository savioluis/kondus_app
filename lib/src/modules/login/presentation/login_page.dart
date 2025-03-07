import 'package:flutter/material.dart';
import 'package:kondus/app/routers/app_routers.dart';
import 'package:kondus/core/providers/navigator/navigator_provider.dart';
import 'package:kondus/src/modules/login/widgets/login_app_bar.dart';
import 'package:kondus/src/modules/login/widgets/register_text_widget.dart';
import 'package:kondus/src/modules/shared/widgets/kondus_elevated_button.dart';
import 'package:kondus/src/modules/shared/widgets/kondus_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool passwordHiddenValue = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const LoginAppBar(title: 'Entrar', subtitle: 'Acesse sua conta'),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 24,
                  right: 24,
                  top: 72,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('E-mail'),
                    const SizedBox(height: 12),
                    const KondusTextFormField(hintText: 'ex: email@email.com'),
                    const SizedBox(height: 24),
                    const Text('Senha'),
                    const SizedBox(height: 12),
                    KondusTextFormField(
                      isObscure: passwordHiddenValue,
                      sufixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            passwordHiddenValue = !passwordHiddenValue;
                          });
                        },
                        icon: passwordHiddenValue
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility),
                      ),
                    ),
                    const SizedBox(height: 48),
                    KondusButton(
                      label: 'ENTRAR',
                      onPressed: () {
                        NavigatorProvider.navigateTo(AppRoutes.home);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          RegisterTextWidget(
            message: 'Não possui uma conta?',
            buttonMessage: 'Criar conta',
            onPressed: () {
              NavigatorProvider.navigateTo(AppRoutes.register);
            },
          ),
          const SizedBox(height: 72),
        ],
      ),
    );
  }
}
