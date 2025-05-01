import 'package:flutter/material.dart';
import 'package:kondus/core/theme/app_theme.dart';
import 'package:kondus/core/widgets/error_state_widget.dart';
import 'package:kondus/core/widgets/kondus_app_bar.dart';
import 'package:kondus/src/modules/profile/domain/profile_viewmodel.dart';
import 'package:kondus/src/modules/profile/widgets/profile_banner.dart';
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
    return ValueListenableBuilder(
      valueListenable: viewModel.state,
      builder: (context, state, child) {
        if (state is ProfileLoadingState) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is ProfileErrorState) {
          return ErrorStateWidget(
            error: state.error,
            onRetryPressed: () {},
          );
        } else if (state is ProfileSuccessState) {
          return Scaffold(
            appBar: const KondusAppBar(),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  ProfileBanner(model: state.model),
                  const SizedBox(height: 24),
                  Divider(thickness: 0.5, color: context.lightGreyColor),
                  const SizedBox(height: 48),
                  const ProfileOptions(),
                  // const SizedBox(height: 100)
                ],
              ),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
