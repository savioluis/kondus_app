import 'package:flutter/material.dart';
import 'package:kondus/src/modules/home/widgets/contact_widget.dart';
import 'package:kondus/src/modules/home/widgets/header.dart';
import 'package:kondus/src/modules/shared/widgets/kondus_search_bar.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();

  final controller = TextEditingController();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                Header(username: 'Sávio'),
                SizedBox(height: 24),
                KonduSearchBar(
                  controller: widget.controller,
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    const Text('Ultimas conversas'),
                    IconButton(
                        iconSize: 12,
                        onPressed: () {},
                        icon: const Icon(
                          Icons.subdirectory_arrow_right,
                          size: 12,
                        ))
                  ],
                ),
                // ListView.builder(
                //   shrinkWrap: true,
                //   physics: const NeverScrollableScrollPhysics(),
                //   scrollDirection: Axis.horizontal,
                //   itemBuilder: (context, index) => ContactWidget(name: 'Bob'),
                //   itemCount: 5,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
