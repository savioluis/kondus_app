// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kondus/core/error/kondus_error.dart';

import 'package:kondus/core/providers/http/error/http_error.dart';
import 'package:kondus/core/services/auth/session_manager.dart';
import 'package:kondus/core/theme/app_theme.dart';
import 'package:kondus/core/widgets/kondus_app_bar.dart';
import 'package:kondus/core/widgets/kondus_elevated_button.dart';

class ErrorStateWidget extends StatelessWidget {
  final KondusFailure error;
  final VoidCallback onRetryPressed;
  final VoidCallback? onBackButtonPressed;

  const ErrorStateWidget({
    required this.error,
    required this.onRetryPressed,
    this.onBackButtonPressed,
    super.key,
  });

  Widget _buildErrorButton(Exception error) {

    if (error is HttpError && error.type == HttpErrorType.unauthorized) {
      return KondusButton(
        label: 'Sair',
        onPressed: () async => GetIt.instance<SessionManager>().logout(),
      );
    }
    return KondusButton(
      label: 'Tentar novamente',
      onPressed: onRetryPressed,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: onBackButtonPressed != null
          ? KondusAppBar(onBackButtonPressed: onBackButtonPressed)
          : null,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline_outlined,
              color: context.errorColor,
              size: 64,
            ),
            const SizedBox(height: 12),
            Text(
              error.failureMessage,
              style: context.labelLarge!.copyWith(fontSize: 28),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            _buildErrorButton(error),
          ],
        ),
      ),
    );
  }
}
