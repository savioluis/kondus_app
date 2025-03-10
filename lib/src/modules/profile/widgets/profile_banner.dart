import 'package:flutter/material.dart';
import 'package:kondus/src/modules/profile/domain/profile_viewmodel.dart';
import 'package:kondus/core/theme/app_theme.dart';

class ProfileBanner extends StatelessWidget {
  final ValueNotifier<ProfileState> state;
  const ProfileBanner({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 100),
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.lightGreyColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(18),
      ),
      child: ValueListenableBuilder(
        valueListenable: state,
        builder: (context, state, widget) => switch (state) {
          ProfileIdleState() => const SizedBox(),
          ProfileErrorState() => const SizedBox(),
          ProfileLoadingState() => const Center(
              child: CircularProgressIndicator(),
            ),
          ProfileSuccessState(model: final model) => Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.owner,
                    style: context.headlineLarge,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    "Residência: ${model.address}",
                    style: context.bodyLarge,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    model.complement, style: context.labelMedium,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  )
                ],
              ),
            ),
        },
      ),
    );
  }
}
