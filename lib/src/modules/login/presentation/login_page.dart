import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kondus/app/injections.dart';
import 'package:kondus/app/routers/app_routers.dart';
import 'package:kondus/core/providers/navigator/navigator_provider.dart';
import 'package:kondus/core/repositories/token_repository.dart';
import 'package:kondus/core/services/auth/auth_service.dart';
import 'package:kondus/core/utils/snack_bar_helper.dart';
import 'package:kondus/src/modules/login/presentation/login_controller.dart';
import 'package:kondus/src/modules/login/presentation/login_state.dart';
import 'package:kondus/src/modules/login/widgets/login_app_bar.dart';
import 'package:kondus/src/modules/login/widgets/register_text_widget.dart';
import 'package:kondus/core/widgets/kondus_elevated_button.dart';
import 'package:kondus/core/widgets/kondus_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controller = LoginController();
  bool passwordHiddenValue = true;

  @override
  void initState() {
    super.initState();
    controller.addListener(_controllerListener);
  }

  void _controllerListener() {
    final state = controller.state;

    if (state is LoginSuccessState) {
      NavigatorProvider.navigateTo(AppRoutes.home);
    } else if (state is LoginFailureState) {
      SnackBarHelper.showMessageSnackBar(
        message: state.message,
        context: context,
      );
    }
  }

  @override
  void dispose() {
    controller.removeListener(_controllerListener);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const LoginAppBar(
        title: 'Entrar',
        subtitle: 'Acesse sua conta',
      ),
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
                    KondusTextFormField(
                      hintText: 'ex: email@email.com',
                      controller: controller.emailEC,
                    ),
                    const SizedBox(height: 24),
                    const Text('Senha'),
                    const SizedBox(height: 12),
                    KondusTextFormField(
                      isObscure: passwordHiddenValue,
                      controller: controller.password,
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
                    AnimatedBuilder(
                      animation: controller,
                      builder: (context, child) => KondusButton(
                        label: 'ENTRAR',
                        isLoading: controller.state is LoginLoadingState,
                        onPressed: () async {
                          final email = controller.emailEC.value.text;
                          final password = controller.password.value.text;
                          controller.login(
                            email: email,
                            password: password,
                          );
                        },
                      ),
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
