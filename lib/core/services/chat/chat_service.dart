import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:kondus/core/services/auth/auth_service.dart';

class ChatService {
  final FirebaseFirestore _cloudFireStore = FirebaseFirestore.instance;
  final AuthService _authService = GetIt.instance<AuthService>();

  Future<void> sendMessage({
    required String targetId,
    required String text,
  }) async {
    if (text.trim().isEmpty) return;

    final currentUserId = (await _authService.getUserId())?.toString();

    if (currentUserId == null) return;

    final messageData = {
      'fromId': currentUserId,
      'toId': targetId,
      'text': text.trim(),
      'timestamp': Timestamp.now(),
    };

    await _cloudFireStore.collection('messages').add(messageData);
  }

  Stream<List<MessageModel>> getUserMessages(String otherUserId) async* {
    final currentUserId = (await _authService.getUserId())?.toString();

    if (currentUserId == null) return;

    final query = _cloudFireStore.collection('messages').where(
      'fromId',
      whereIn: [currentUserId, otherUserId],
    ).where(
      'toId',
      whereIn: [currentUserId, otherUserId],
    ).orderBy('timestamp', descending: false);

    yield* query.snapshots().map((snapshot) {
      return snapshot.docs.map(MessageModel.fromFirestore).toList();
    });
  }

  Future<List<String>> getUsersIdsContacts({int? limit}) async {
    final currentUserId = (await _authService.getUserId())?.toString();

    if (currentUserId == null) return [];

    final Set<String> usersIdsWithWhomUserHasChated = {};

    QuerySnapshot sentMessagesSnapshot = await _cloudFireStore
        .collection('messages')
        .where('fromId', isEqualTo: currentUserId)
        .get();

    for (final doc in sentMessagesSnapshot.docs) {
      usersIdsWithWhomUserHasChated.add(doc['toId']);
    }

    QuerySnapshot receivedMessagesSnapshot = await _cloudFireStore
        .collection('messages')
        .where('toId', isEqualTo: currentUserId)
        .get();

    for (final doc in receivedMessagesSnapshot.docs) {
      usersIdsWithWhomUserHasChated.add(doc['fromId']);
    }

    final allUserIds = usersIdsWithWhomUserHasChated.toList();

    if (limit != null && limit < allUserIds.length) {
      return allUserIds.take(limit).toList();
    }

    return allUserIds;
  }
}

class MessageModel {
  final String fromId;
  final String toId;
  final String text;
  final Timestamp timestamp;

  MessageModel({
    required this.fromId,
    required this.toId,
    required this.text,
    required this.timestamp,
  });

  factory MessageModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return MessageModel(
      fromId: data['fromId'],
      toId: data['toId'],
      text: data['text'],
      timestamp: data['timestamp'],
    );
  }
}
