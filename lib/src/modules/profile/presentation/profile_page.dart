import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kondus/src/modules/profile/domain/profile_viewmodel.dart';
import 'package:kondus/src/modules/profile/widgets/profile_options.dart';

import '../../../../app/injections.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final viewModel = getIt<ProfileViewModel>();

  @override
  void initState() {
    viewModel.getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ValueListenableBuilder(
              valueListenable: viewModel.state,
              builder: (context, state, widget) => switch(state){
                ProfileSuccessState() => throw UnimplementedError(),
                ProfileIdleState() => throw UnimplementedError(),
                ProfileErrorState() => throw UnimplementedError(),
                ProfileLoadingState() => throw UnimplementedError(),
              },
            ),
            const ProfileOptions()
          ],
        ),
      ),
    );
  }
}
