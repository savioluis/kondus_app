import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get_it/get_it.dart';
import 'package:kondus/core/error/kondus_error.dart';
import 'package:kondus/core/services/auth/auth_service.dart';
import 'package:kondus/core/services/chat/chat_service.dart';
import 'package:kondus/core/theme/app_theme.dart';
import 'package:kondus/core/widgets/kondus_app_bar.dart';
import 'package:kondus/core/widgets/kondus_text_field.dart';
import 'package:kondus/src/modules/chat/contact_chat/presentation/contact_chat_controller.dart';
import 'package:kondus/src/modules/chat/contact_chat/widget/message_bubble.dart';

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
  String? _currentUserId;

  bool _isFirstScroll = true;
  bool _isUserScrolling = false;
  bool _hasMarkedMessagesThisScroll = false;
  

  @override
  void initState() {
    super.initState();
    _loadUserId();
    controller = ContactChatController();
  }

  Future<void> _loadUserId() async {
    final authService = GetIt.instance<AuthService>();
    final id = await authService.getUserId();
    setState(() {
      _currentUserId = id?.toString();
    });
  }

  @override
  void dispose() {
    controller.scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KondusAppBar(
        title: widget.name,
      ),
      bottomNavigationBar: Material(
        color: context.surfaceColor,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 18, bottom: 18, top: 18),
            child: Row(
              children: [
                Expanded(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 86),
                    child: KondusTextFormField(
                      controller: controller.textController,
                      decoration: const InputDecoration(
                        hintText: 'Digite sua mensagem...',
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                      maxLines: null,
                      onChanged: (_) async {
                        final controllerPosition =
                            controller.scrollController.position;

                        final isNearBottom =
                            controllerPosition.hasContentDimensions &&
                                (controllerPosition.maxScrollExtent -
                                        controllerPosition.pixels) <
                                    MediaQuery.sizeOf(context).height / 3;

                        if (controller.lastUnreadCount > 0 && isNearBottom) {
                          await controller.markMessagesAsRead(
                            _currentUserId,
                            widget.targetId,
                          );
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () async {
                    await controller.sendMessage(
                      currentUserId: _currentUserId,
                      targetId: widget.targetId,
                    );
                    if (controller.lastUnreadCount > 0) {
                      await controller.markMessagesAsRead(
                        _currentUserId,
                        widget.targetId,
                      );
                    }
                  },
                  icon: const Icon(Icons.send),
                  color: context.blueColor,
                ),
              ],
            ),
          ),
        ),
      ),
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
                  if (error is KondusFailure) {
                    errorMessage = error.failureMessage;
                  }
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

                final messages = snapshot.data!;
                final unreadMessages =
                    messages.where((message) => !message.hasBeenRead).toList();
                controller.lastUnreadCount = unreadMessages.length;

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (_isUserScrolling) return;

                  final controllerPosition =
                      controller.scrollController.position;
                  final isNearBottom =
                      controllerPosition.hasContentDimensions &&
                          (controllerPosition.maxScrollExtent -
                                  controllerPosition.pixels) <
                              MediaQuery.sizeOf(context).height / 3;

                  if (_isFirstScroll) {
                    controller.jumpToBottom();
                    _isFirstScroll = false;
                  } else if (isNearBottom) {
                    controller.animateToBottom();
                  }
                });

                return NotificationListener<ScrollNotification>(
                  onNotification: (notification) {
                    if (notification is UserScrollNotification) {
                      if (notification.direction != ScrollDirection.idle) {
                        _isUserScrolling = true;

                        if (!_hasMarkedMessagesThisScroll &&
                            controller.lastUnreadCount > 0) {
                          _hasMarkedMessagesThisScroll = true;

                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            controller.markMessagesAsRead(
                              _currentUserId,
                              widget.targetId,
                            );
                          });
                        }
                      } else {
                        _isUserScrolling = false;
                        _hasMarkedMessagesThisScroll = false;
                      }
                    }
                    return false;
                  },
                  child: ListView.builder(
                    controller: controller.scrollController,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      return MessageBubble(
                        text: message.text,
                        timestamp: message.timestamp,
                        isMe: message.fromId == _currentUserId,
                        hasBeenRead: message.hasBeenRead,
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
