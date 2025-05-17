import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kondus/core/theme/app_theme.dart';

class MessageBubble extends StatelessWidget {
  final String text;
  final Timestamp timestamp;
  final bool isMe;
  final bool hasBeenRead;

  const MessageBubble({
    required this.text,
    required this.timestamp,
    required this.isMe,
    this.hasBeenRead = false,
    super.key,
  });

  String _formatTime(Timestamp timestamp) {
    final date = timestamp.toDate();
    final hourStr = date.hour.toString();
    final minuteStr = date.minute < 10 ? '0${date.minute}' : '${date.minute}';
    return '$hourStr:$minuteStr';
  }

  @override
  Widget build(BuildContext context) {
    final timeString = _formatTime(timestamp);

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeOutQuart,
          margin: const EdgeInsets.symmetric(vertical: 6),
          padding: const EdgeInsets.only(
            left: 12,
            right: 12,
            top: 12,
            bottom: 8,
          ),
          decoration: BoxDecoration(
            border: isMe || hasBeenRead
                ? null
                : Border(
                    left: BorderSide(
                      color: context.blueColor.withOpacity(0.3),
                      width: 2,
                    ),
                    bottom: BorderSide(
                      color: context.blueColor.withOpacity(0.3),
                      width: 2,
                    ),
                  ),
            color: isMe
                ? context.blueColor.withOpacity(0.10)
                : hasBeenRead
                    ? context.lightGreyColor.withOpacity(0.05)
                    : context.lightGreyColor.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                text,
                style: context.bodyMedium!.copyWith(fontSize: 16),
              ),
              const SizedBox(height: 6),
              Text(
                timeString,
                style: TextStyle(
                  fontSize: 10,
                  color: context.lightGreyColor,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.right,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
