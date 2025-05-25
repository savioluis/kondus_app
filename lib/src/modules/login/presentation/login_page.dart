import 'package:flutter/material.dart';
import 'package:kondus/app/routing/app_routes.dart';
import 'package:kondus/app/routing/route_arguments.dart';
import 'package:kondus/core/providers/navigator/navigator_provider.dart';
import 'package:kondus/core/utils/snack_bar_helper.dart';
import 'package:kondus/src/modules/login/presentation/login_controller.dart';
import 'package:kondus/src/modules/login/presentation/login_state.dart';
import 'package:kondus/src/modules/login/widgets/login_app_bar.dart';
import 'package:kondus/core/widgets/kondus_elevated_button.dart';
import 'package:kondus/core/widgets/kondus_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final LoginController controller;
  bool passwordHiddenValue = true;

  @override
  void initState() {
    super.initState();
    controller = LoginController();
    controller.addListener(_controllerListener);
  }

  @override
  void dispose() {
    controller.removeListener(_controllerListener);
    controller.dispose();
    super.dispose();
  }

  void _controllerListener() async {
    final state = controller.state;

    if (state is LoginSuccessState) {
      final prefs = await SharedPreferences.getInstance();

      final bool isUserFirstLogin =
          prefs.getBool('is_user_first_login') ?? true;

      String initialRoute;
      RouteArguments? arguments;

      Future<void> onSkipPressed() async =>
          NavigatorProvider.navigateAndRemoveUntil(AppRoutes.home);

      initialRoute =
          isUserFirstLogin ? AppRoutes.shareYourItems : AppRoutes.home;

      arguments = RouteArguments<VoidCallback?>(onSkipPressed);

      await prefs.setBool('is_user_first_login', false);
      await prefs.setBool('is_user_first_session', false);

      NavigatorProvider.navigateAndRemoveUntil(
        initialRoute,
        arguments: arguments,
      );
    } else if (state is LoginFailureState) {
      SnackBarHelper.showMessageSnackBar(
          message: state.message,
          context: context,
          duration: const Duration(seconds: 3));
    }
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
                      controller: controller.passwordEC,
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
                          final password = controller.passwordEC.value.text;
                          await controller.login(
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
        ],
      ),
    );
  }
}
