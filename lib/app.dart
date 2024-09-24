import 'package:flutter/material.dart';
import 'package:kondus/pages/home_page.dart';

class KondusApp extends StatefulWidget {
  const KondusApp({super.key});

  @override
  State<KondusApp> createState() => _KondusAppState();
}

class _KondusAppState extends State<KondusApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: const HomePage(),
    );
  }
}