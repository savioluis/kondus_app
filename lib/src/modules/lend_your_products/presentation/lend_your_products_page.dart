// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:kondus/src/modules/shared/widgets/header_section.dart';

class LendYourProductsPage extends StatefulWidget {
  const LendYourProductsPage({super.key});

  @override
  State<LendYourProductsPage> createState() => _LendYourProductsPageState();
}

class _LendYourProductsPageState extends State<LendYourProductsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              HeaderSection(
                titleSize: 34,
                subTitleSize: 16,
                title:
                    'Você possui algum desses itens para compartilhar com seus vizinhos?',
                subtitle: [
                  TextSpan(text: 'Compartilhe seus '),
                  TextSpan(
                    text: 'serviços ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: 'e '),
                  TextSpan(
                    text: 'produtos',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
