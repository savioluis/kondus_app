import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:kondus/core/services/auth/auth_service.dart';

class ChatService {
  final FirebaseFirestore _cloudFireStore = FirebaseFirestore.instance;
  final AuthService _authService = GetIt.instance<AuthService>();

  Future<void> sendMessage({
    required String fromId,
    required String toId,
    required String text,
  }) async {
    await _cloudFireStore.collection('messages').add({
      'fromId': fromId,
      'toId': toId,
      'text': text.trim(),
      'timestamp': Timestamp.now(),
    });
  }

  Stream<List<MessageModel>> getMessages(String toId) async* {
    final fromId = await _authService.getUserId();

    yield* _cloudFireStore
        .collection('messages')
        .where('fromId', whereIn: [fromId.toString(), toId])
        .where('toId', whereIn: [fromId.toString(), toId])
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return MessageModel.fromFirestore(doc);
          }).toList();
        });
  }

  Future<List<String>> getUsersIdsWithWhomUserHasConversed(
      String userId) async {
    var querySnapshot = await _cloudFireStore
        .collection('messages')
        .where('fromId', isEqualTo: userId)
        .get();

    Set<String> usersIdsWithWhomUserHasConversed = {};

    for (final doc in querySnapshot.docs) {
      usersIdsWithWhomUserHasConversed.add(doc['toId']);
    }

    querySnapshot = await _cloudFireStore
        .collection('messages')
        .where('toId', isEqualTo: userId)
        .get();

    for (final doc in querySnapshot.docs) {
      usersIdsWithWhomUserHasConversed.add(doc['fromId']);
    }

    return usersIdsWithWhomUserHasConversed.toList();
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
