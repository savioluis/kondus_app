import 'package:flutter/material.dart';
import 'package:kondus/core/error/kondus_error.dart';
import 'package:kondus/core/services/chat/chat_service.dart';
import 'package:kondus/core/theme/app_theme.dart';
import 'package:kondus/core/widgets/kondus_app_bar.dart';
import 'package:kondus/core/widgets/kondus_text_field.dart';
import 'package:kondus/src/modules/chat/contact_chat/presentation/contact_chat_controller.dart';

class ContactChatPage extends StatefulWidget {
  final String targetId;
  final String name;

  const ContactChatPage({
    required this.targetId,
    required this.name,
    super.key,
  });

  @override
  State<ContactChatPage> createState() => _ContactChatPageState();
}

class _ContactChatPageState extends State<ContactChatPage> {
  late final ContactChatController controller;

  @override
  void initState() {
    super.initState();
    controller = ContactChatController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KondusAppBar(title: widget.name),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<MessageModel>>(
              stream: controller.getMessages(widget.targetId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  final error = snapshot.error;
                  String errorMessage = error.toString();

                  if (error is KondusFailure)
                    errorMessage = error.failureMessage;

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Center(
                      child: Text(
                        'Erro ao carregar mensagens: $errorMessage',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Nenhuma mensagem ainda.'));
                }

                controller.scrollToBottom();

                final messages = snapshot.data!;

                final unreadMessages =
                    messages.where((message) => !message.hasBeenRead).toList();

                if (unreadMessages.isNotEmpty) {
                  controller.markMessagesAsRead(widget.targetId);
                }

                return ListView.builder(
                  controller: controller.scrollController,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final isUserMessage = message.toId == widget.targetId;

                    return Align(
                      alignment: isUserMessage
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isUserMessage
                              ? context.blueColor.withOpacity(0.15)
                              : context.lightGreyColor.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Text(
                          message.text,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),

          // Campo de texto e botão de envio
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 36),
            child: Row(
              children: [
                Expanded(
                  child: KondusTextFormField(
                    controller: controller.textController,
                    decoration: const InputDecoration(
                      hintText: 'Digite sua mensagem...',
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () async {
                    await controller.sendMessage(targetId: widget.targetId);
                  },
                  icon: const Icon(Icons.send),
                  color: context.blueColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
