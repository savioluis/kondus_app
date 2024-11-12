// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:kondus/src/modules/register/presentation/register_controller.dart';
import 'package:kondus/src/modules/shared/widgets/kondus_custom_button.dart';
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
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 40,
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Informe seus dados',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                ),
                Row(
                  children: [
                    Text(
                      'como ',
                      style: TextStyle(color: Color(0xff555555)),
                    ),
                    Text(
                      'Morador',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff555555)),
                    )
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
                  alignment:Alignment.centerRight,
                  child: KondusCustomButton(
                    onPressed: pageController.validateForm,
                    height: 48,
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
