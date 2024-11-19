import 'package:flutter/material.dart';
import 'package:kondus/src/modules/shared/widgets/kondus_custom_button.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipPath(
              clipper: GetStartedClipper(),
              child: Container(
                color: const Color(0xff05ACC1),
                height: MediaQuery.of(context).size.height * 0.4,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const FlutterLogo(
                  size: 120,
                ),
                const SizedBox(height: 24),
                const Text(
                  'Kondus',
                  style: TextStyle(
                    fontSize: 32,
                    color: Color(0xff05ACC1),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Acesse tudo sobre seu condomínio em um só lugar.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 48),
                KondusCustomButton(
                  width: MediaQuery.of(context).size.width * 0.7,
                  onPressed: () {},
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'CRIAR CONTA',
                    style: TextStyle(
                      color: Color(0xff05ACC1),
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class GetStartedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    double curveHeight = size.height * 0.2; // Altura da curva

    // Começa no canto superior esquerdo
    path.moveTo(0, 0);

    // Cria a curva suave no topo
    path.quadraticBezierTo(
      size.width / 2,
      curveHeight,
      size.width,
      0,
    );

    // Linha reta até o canto inferior direito
    path.lineTo(size.width, size.height);

    // Linha reta até o canto inferior esquerdo
    path.lineTo(0, size.height);

    // Fecha o caminho
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
