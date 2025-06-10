import 'package:flutter/material.dart';
import 'package:kondus/core/theme/app_theme.dart';

class DialogHelper {
  static Future<void> showAlert({
    required BuildContext context,
    required String message,
    required String title,
    required String confirmLabel,
    required String cancelLabel,
    required VoidCallback onConfirm,
    required VoidCallback onCancel,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => Dialog(
        backgroundColor: context.surfaceColor,
        insetPadding: const EdgeInsets.symmetric(horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: context.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                  color: context.onSurfaceColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                message,
                style: context.bodyLarge!.copyWith(
                  fontSize: 18,
                  color: context.onSurfaceColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: onCancel,
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        side: BorderSide(color: context.primaryColor),
                        minimumSize: const Size.fromHeight(48),
                        padding: EdgeInsets.zero,
                      ),
                      child: Text(
                        cancelLabel,
                        style: TextStyle(
                          color: context.onSurfaceColor,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onConfirm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: context.errorColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        minimumSize: const Size.fromHeight(48),
                        padding: EdgeInsets.zero,
                      ),
                      child: Text(
                        confirmLabel,
                        style: TextStyle(
                          color: context.onErrorColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
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
