
import 'package:flutter/material.dart';
import 'package:kondus/src/modules/register/presentation/register_controller.dart';
import 'package:kondus/core/widgets/kondus_app_bar.dart';
import 'package:kondus/core/widgets/header_section.dart';
import 'package:kondus/core/widgets/kondus_elevated_button.dart';
import 'package:kondus/core/widgets/kondus_text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final pageController = RegisterController();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: const KondusAppBar(),
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeaderSection(
                  title: 'Informe seus dados',
                  titleSize: 28,
                  subtitle: [
                    TextSpan(text: 'como '),
                    TextSpan(
                      text: 'Morador',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.05),
                const Text('Nome Completo'),
                SizedBox(height: screenHeight * 0.01),
                const KondusTextFormField(
                  hintText: 'Digite seu nome completo',
                ),
                SizedBox(height: screenHeight * 0.02),
                const Text('E-mail'),
                SizedBox(height: screenHeight * 0.01),
                Padding(
                  padding: EdgeInsets.only(right: screenWidth * 0.1),
                  child: const KondusTextFormField(
                    hintText: 'Digite seu email',
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                const Text('Data de nascimento'),
                SizedBox(height: screenHeight * 0.01),
                Padding(
                  padding: EdgeInsets.only(right: screenWidth * 0.1),
                  child: const KondusTextFormField(
                    hintText: 'Dia/Mês/Ano',
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                const Text('Senha'),
                SizedBox(height: screenHeight * 0.01),
                Padding(
                  padding: EdgeInsets.only(right: screenWidth * 0.1),
                  child: const KondusTextFormField(
                    hintText: 'Digite sua senha',
                    isObscure: true,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                const Text('Confirmar senha'),
                SizedBox(height: screenHeight * 0.01),
                Padding(
                  padding: EdgeInsets.only(right: screenWidth * 0.1),
                  child: const KondusTextFormField(
                    hintText: 'Confirme sua senha',
                    isObscure: true,
                  ),
                ),
                SizedBox(height: screenHeight * 0.06),
                Padding(
                  padding: const EdgeInsets.only(left: 180, bottom: 48),
                  child: KondusButton(
                    onPressed: () => pageController.registerAccount(context),
                    label: 'FINALIZAR',
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: screenWidth * 0.045,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
