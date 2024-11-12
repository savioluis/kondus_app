import 'package:flutter/material.dart';
import 'package:kondus/src/modules/shared/widgets/kondus_fullwidth_button.dart';
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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipPath(
              clipper: _LoginClipPath(),
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xff05ACC1),
                ),
                width: double.infinity,
                height: screenHeight * 0.28,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: screenHeight * 0.12,
                    left: screenWidth * 0.08,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Entrar',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.1,
                        ),
                      ),
                      Text(
                        'Acesse sua conta',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: screenWidth * 0.045,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.05,
                horizontal: screenWidth * 0.08,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('E-mail'),
                  SizedBox(height: screenHeight * 0.015),
                  const KondusTextFormField(hintText: 'ex: email@email.com'),
                  SizedBox(height: screenHeight * 0.03),
                  const Text('Senha'),
                  SizedBox(height: screenHeight * 0.015),
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
                  SizedBox(height: screenHeight * 0.06),
                  KondusFillWidthButton(label: 'entrar'.toUpperCase()),
                  SizedBox(height: screenHeight * 0.20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Não possui uma conta ?',
                          style: TextStyle(color: Color(0xff757575))),
                      InkWell(
                        borderRadius: BorderRadius.circular(8),
                        child: const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                          child: Text(
                            'Criar conta',
                            style: TextStyle(color: Color(0xff05ACC1)),
                          ),
                        ),
                        onTap: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoginClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.moveTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.5);
    path.quadraticBezierTo(
        size.width * 0.6, size.height * 1.2, 0, size.height * 0.9);
    path.lineTo(0, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}