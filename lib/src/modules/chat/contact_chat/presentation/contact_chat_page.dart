import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kondus/core/error/kondus_error.dart';
import 'package:kondus/core/providers/navigator/navigator_provider.dart';
import 'package:kondus/core/services/auth/auth_service.dart';
import 'package:kondus/core/services/chat/chat_service.dart';
import 'package:kondus/core/theme/app_theme.dart';
import 'package:kondus/core/widgets/kondus_app_bar.dart';
import 'package:kondus/core/widgets/kondus_text_field.dart';
import 'package:kondus/src/modules/chat/contact_chat/presentation/contact_chat_controller.dart';
import 'package:kondus/src/modules/chat/contact_chat/widget/date_header_widget.dart';
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

    controller.messageFieldFocusNode
        .addListener(controller.handleScrollToBottomWhenKeayboardAppears);

    controller.scrollController.addListener(controller.handleFABVisibility);
  }

  @override
  void dispose() {
    controller.messageFieldFocusNode
        .removeListener(controller.handleScrollToBottomWhenKeayboardAppears);
    controller.scrollController.removeListener(controller.handleFABVisibility);
    controller.dispose();
    super.dispose();
  }

  Future<void> _loadUserId() async {
    final authService = GetIt.instance<AuthService>();
    final id = await authService.getUserId();
    setState(() {
      _currentUserId = id?.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: KondusAppBar(
        title: widget.name,
        onBackButtonPressed: () async {
          NavigatorProvider.goBack();
          if (controller.lastUnreadCount > 0) {
            await controller.markMessagesAsRead(
              _currentUserId,
              widget.targetId,
            );
          }
        },
      ),
      body: Stack(
        children: [
          Column(
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
                      return const Center(
                          child: Text('Nenhuma mensagem ainda.'));
                    }

                    final messages = snapshot.data!;
                    final unreadMessages = messages
                        .where((message) => !message.hasBeenRead)
                        .toList();
                    controller.lastUnreadCount = unreadMessages.length;

                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      controller.scrollToBottomIfNeeded(
                        context: context,
                        isUserScrolling: _isUserScrolling,
                        isFirstScroll: _isFirstScroll,
                        onFirstScrollHandled: () {
                          _isFirstScroll = false;
                        },
                      );
                    });

                    return NotificationListener<ScrollNotification>(
                      onNotification: (notification) {
                        if (notification is UserScrollNotification) {
                          controller.handleUserScrollNotification(
                            notification: notification,
                            markMessagesAsReadCallback: () {
                              controller.markMessagesAsRead(
                                _currentUserId,
                                widget.targetId,
                              );
                            },
                            onStartScroll: () {
                              _isUserScrolling = true;

                              if (!_hasMarkedMessagesThisScroll) {
                                _hasMarkedMessagesThisScroll = true;
                              }
                            },
                            onStopScroll: () {
                              _isUserScrolling = false;
                              _hasMarkedMessagesThisScroll = false;
                            },
                          );
                        }
                        return false;
                      },
                      child: ListView.builder(
                        controller: controller.scrollController,
                        padding: const EdgeInsets.only(
                          left: 16,
                          right: 16,
                          top: 8,
                          bottom: 64,
                        ),
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final message = messages[index];

                          final currentDate = DateTime(
                            message.timestamp.toDate().year,
                            message.timestamp.toDate().month,
                            message.timestamp.toDate().day,
                          );

                          DateTime? previousDate;
                          if (index > 0) {
                            final previousMessage = messages[index - 1];
                            previousDate = DateTime(
                              previousMessage.timestamp.toDate().year,
                              previousMessage.timestamp.toDate().month,
                              previousMessage.timestamp.toDate().day,
                            );
                          }

                          final isFirstOfDay =
                              index == 0 || currentDate != previousDate;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              if (isFirstOfDay)
                                DateHeaderWidget(date: currentDate),
                              MessageBubble(
                                text: message.text,
                                timestamp: message.timestamp,
                                isMe: message.fromId == _currentUserId,
                                hasBeenRead: message.hasBeenRead,
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: context.lightGreyColor, width: 0.2),
                  ),
                ),
                child: SafeArea(
                  bottom: true,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 12,
                      bottom: 18,
                      top: 16,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxHeight: 86),
                            child: KondusTextFormField(
                              focusNode: controller.messageFieldFocusNode,
                              controller: controller.textController,
                              decoration: const InputDecoration(
                                hintText: 'Digite sua mensagem...',
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                              ),
                              maxLines: null,
                              onChanged: (_) async {
                                if (controller.scrollController.hasClients) {
                                  final controllerPosition =
                                      controller.scrollController.position;
                                  final isNearBottom = controllerPosition
                                          .hasContentDimensions &&
                                      (controllerPosition.maxScrollExtent -
                                              controllerPosition.pixels) <
                                          MediaQuery.sizeOf(context).height / 3;
                                  if (controller.lastUnreadCount > 0 &&
                                      isNearBottom) {
                                    await controller.markMessagesAsRead(
                                      _currentUserId,
                                      widget.targetId,
                                    );
                                  }
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
            ],
          ),
          Positioned(
            bottom: 156,
            right: 0,
            child: ValueListenableBuilder<bool>(
              valueListenable: controller.fabVisibility,
              builder: (context, showFAB, _) {
                return AnimatedOpacity(
                  opacity: showFAB ? 1 : 0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOutBack,
                  child: IgnorePointer(
                    ignoring: !showFAB,
                    child: Container(
                      width: 64,
                      decoration: BoxDecoration(
                          color: context.surfaceColor,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(18),
                            topLeft: Radius.circular(18),
                          ),
                          border: Border.all(color: context.lightGreyColor)),
                      padding: const EdgeInsets.all(16),
                      child: FittedBox(
                        child: FloatingActionButton(
                          focusElevation: 0,
                          disabledElevation: 0,
                          hoverElevation: 0,
                          highlightElevation: 0,
                          elevation: 0,
                          backgroundColor: context.blueColor,
                          mini: true,
                          shape: const CircleBorder(),
                          onPressed: () {
                            controller.animateToBottom();
                          },
                          child: Icon(
                            Icons.keyboard_arrow_down,
                            color: context.whiteColor,
                            size: 28,
                          ),
                        ),
                      ),
                    ),
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
