// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:kondus/src/modules/register/presentation/register_controller.dart';
import 'package:kondus/src/modules/shared/theme/app_theme.dart';
import 'package:kondus/src/modules/shared/widgets/kondus_app_bar.dart';
import 'package:kondus/src/modules/shared/widgets/header_section.dart';
import 'package:kondus/src/modules/shared/widgets/kondus_elevated_button.dart';
import 'package:kondus/src/modules/shared/widgets/kondus_text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final pageController = RegisterController();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: KondusAppBar(),
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderSection(
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
                Text('Nome Completo'),
                SizedBox(height: screenHeight * 0.01),
                KondusTextFormField(
                  hintText: 'Digite seu nome completo',
                ),
                SizedBox(height: screenHeight * 0.02),
                Text('E-mail'),
                SizedBox(height: screenHeight * 0.01),
                Padding(
                  padding: EdgeInsets.only(right: screenWidth * 0.1),
                  child: KondusTextFormField(
                    hintText: 'Digite seu email',
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Text('Data de nascimento'),
                SizedBox(height: screenHeight * 0.01),
                Padding(
                  padding: EdgeInsets.only(right: screenWidth * 0.1),
                  child: KondusTextFormField(
                    hintText: 'Dia/Mês/Ano',
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Text('Senha'),
                SizedBox(height: screenHeight * 0.01),
                Padding(
                  padding: EdgeInsets.only(right: screenWidth * 0.1),
                  child: KondusTextFormField(
                    hintText: 'Digite sua senha',
                    isObscure: true,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Text('Confirmar senha'),
                SizedBox(height: screenHeight * 0.01),
                Padding(
                  padding: EdgeInsets.only(right: screenWidth * 0.1),
                  child: KondusTextFormField(
                    hintText: 'Confirme sua senha',
                    isObscure: true,
                  ),
                ),
                SizedBox(height: screenHeight * 0.08),
                Align(
                  alignment: Alignment.centerRight,
                  child: KondusButton(
                    onPressed: pageController.validateForm,
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
