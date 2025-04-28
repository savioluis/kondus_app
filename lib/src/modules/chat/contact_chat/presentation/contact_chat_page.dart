import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kondus/core/services/chat/chat_service.dart';
import 'package:kondus/core/theme/app_theme.dart';
import 'package:kondus/core/widgets/kondus_app_bar.dart';
import 'package:kondus/core/widgets/kondus_text_field.dart';
import 'package:kondus/src/modules/chat/contact_chat/presentation/contact_chat_controller.dart';

class ContactChatPage extends StatelessWidget {
  final String uid;
  final String name;
  final String apartment;

  ContactChatPage({
    required this.uid,
    required this.name,
    required this.apartment,
    super.key,
  });

  final ChatService _chatService = GetIt.instance<ChatService>();
  final controller = ContactChatController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KondusAppBar(title: name),
      body: Column(
        children: [
          Expanded(
              child: StreamBuilder<List<MessageModel>>(
            stream: _chatService.getMessages(uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(
                    child:
                        Text('Erro ao carregar mensagens: ${snapshot.error}'));
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('Nenhuma mensagem ainda.'));
              }

              final messages = snapshot.data!;

              return ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  final isUserMessage = message.toId == uid;

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
          )),

          // Campo de texto e botão de envio
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 48),
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
                    await controller.sendMessage(
                      toId: uid,
                    );
                  },
                  icon: const Icon(Icons.send),
                  color: Colors.blue,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
