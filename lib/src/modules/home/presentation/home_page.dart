import 'package:flutter/material.dart';
import 'package:kondus/src/modules/home/widgets/header.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 80, left: 32, right: 32),
          child: Column(
            children: [
              Header(username: 'Sávio'),
            ],
          ),
        ),
      ),
    );
  }
}
