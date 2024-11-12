// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

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
            children: const [
              Text(
                'Você possui algum desses itens para compartilhar com seus vizinhos ?',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 34),
              ),
              Row(
                children: [
                  Text(
                    'Compartilhe seus ',
                    style: TextStyle(fontWeight: FontWeight.w200),
                  ),
                  Text(
                    'serviços ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'e ',
                    style: TextStyle(fontWeight: FontWeight.w200),
                  ),
                  Text(
                    'produtos',
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
