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
      'hasBeenRead': false,
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

  Future<int> getUnreadMessagesCountFrom(String otherUserId) async {
    final currentUserId = await _authService.getUserId();

    final query = await _cloudFireStore
        .collection('messages')
        .where('toId', isEqualTo: currentUserId.toString())
        .where('fromId', isEqualTo: otherUserId)
        .where('hasBeenRead', isEqualTo: false)
        .get();

    return query.docs.length;
  }

  Future<Map<String, int>> getUnreadMessagesCountForUserContacts(
      List<String> contactsIds) async {
    final currentUserId = await _authService.getUserId();

    if (currentUserId == null) return {};

    final query = await _cloudFireStore
        .collection('messages')
        .where('toId', isEqualTo: currentUserId.toString())
        .where('hasBeenRead', isEqualTo: false)
        .get();

    final Map<String, int> unreadCounts = {};

    for (var doc in query.docs) {
      final fromId = doc['fromId'];
      if (contactsIds.contains(fromId)) {
        unreadCounts[fromId] = (unreadCounts[fromId] ?? 0) + 1;
      }
    }

    for (var id in contactsIds) {
      unreadCounts[id] = unreadCounts[id] ?? 0;
    }

    return unreadCounts;
  }

  Future<void> markMessagesAsRead(String otherUserId) async {
    final currentUserId = await _authService.getUserId();

    if (currentUserId == null) return;

    final query = await _cloudFireStore
        .collection('messages')
        .where('toId', isEqualTo: currentUserId.toString())
        .where('fromId', isEqualTo: otherUserId)
        .where('hasBeenRead', isEqualTo: false)
        .get();

    final batch = _cloudFireStore.batch();

    for (final doc in query.docs) {
      batch.update(doc.reference, {'hasBeenRead': true});
    }

    await batch.commit();
  }
}

class MessageModel {
  final String fromId;
  final String toId;
  final String text;
  final Timestamp timestamp;
  final bool hasBeenRead;

  MessageModel({
    required this.fromId,
    required this.toId,
    required this.text,
    required this.timestamp,
    this.hasBeenRead = false,
  });

  factory MessageModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return MessageModel(
      fromId: data['fromId'],
      toId: data['toId'],
      text: data['text'],
      timestamp: data['timestamp'],
      hasBeenRead: data['hasBeenRead'],
    );
  }
}
