import 'package:flutter/material.dart';
import 'package:kondus/src/modules/shared/theme/app_theme.dart';
import 'package:kondus/src/modules/shared/widgets/kondus_app_bar.dart';
import 'package:kondus/src/modules/shared/widgets/kondus_text_field.dart';
import 'contact_chat_controller.dart';
import 'contact_chat_state.dart';

class ContactChatPage extends StatefulWidget {
  final String uid;
  final String name;
  final String apartment;

  const ContactChatPage({
    super.key,
    required this.uid,
    required this.name,
    required this.apartment,
  });

  @override
  State<ContactChatPage> createState() => _ContactChatPageState();
}

class _ContactChatPageState extends State<ContactChatPage> {
  final ContactChatController controller = ContactChatController();

  @override
  void initState() {
    super.initState();
    controller.loadMessages(widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KondusAppBar(title: widget.name),
      body: AnimatedBuilder(
        animation: controller,
        builder: (context, _) {
          final state = controller.state;

          if (state is ContactChatLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ContactChatFailure) {
            return Center(child: Text('Erro: ${state.errorMessage}'));
          } else if (state is ContactChatSuccess) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemCount: state.messages.length,
                    itemBuilder: (context, index) {
                      final message = state.messages[index];
                      final isUserMessage = message['isUserMessage'];
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
                            message['text'],
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 24, right: 24, bottom: 48),
                  child: Row(
                    children: [
                      Expanded(
                        child: KondusTextFormField(
                          controller: controller.textController,
                          decoration: const InputDecoration(
                            hintText: 'Digite sua mensagem...',
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        onPressed: () {
                          controller.sendMessage(widget.uid);
                        },
                        icon: const Icon(Icons.send),
                        color: Colors.blue,
                      ),
                    ],
                  ),
                ),
              ],
            );
          }

          return const Center(child: Text('Bem-vindo ao chat!'));
        },
      ),
    );
  }
}
