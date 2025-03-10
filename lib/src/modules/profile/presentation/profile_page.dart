import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kondus/app/app.dart';
import 'package:kondus/src/modules/profile/domain/profile_viewmodel.dart';
import 'package:kondus/src/modules/profile/widgets/profile_banner.dart';
import 'package:kondus/src/modules/profile/widgets/profile_options.dart';
import 'package:kondus/core/theme/app_theme.dart';

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
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ProfileBanner(state: viewModel.state),
            const ProfileOptions(),
            const SizedBox(height: 100)
          ],
        ),
      ),
    );
  }
}
