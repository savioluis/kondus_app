import 'package:flutter/material.dart';
import 'package:kondus/widgets/bottom_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      bottomNavigationBar: BottomNavBar(),
      body: Center(
        child: Text('Kondus'),
      ),
    );
  }
}
