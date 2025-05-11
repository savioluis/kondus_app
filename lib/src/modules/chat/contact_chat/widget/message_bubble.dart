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
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 6),
          padding: const EdgeInsets.only(
            left: 12,
            right: 12,
            top: 12,
            bottom: 8,
          ),
          decoration: BoxDecoration(
            color: isMe
                ? context.blueColor.withOpacity(0.15)
                : hasBeenRead
                    ? context.lightGreyColor.withOpacity(0.15)
                    : context.lightGreyColor.withOpacity(0.30),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end, // <- esse é o segredo
            children: [
              Text(
                text,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 6),
              Text(
                timeString,
                style: TextStyle(
                  fontSize: 10,
                  color: context.lightGreyColor,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.right, // <-- alinhamento final
              ),
            ],
          ),
        ),
      ),
    );
  }
}
