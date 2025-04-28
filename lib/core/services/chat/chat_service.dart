import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  final FirebaseFirestore _cloudFireStore = FirebaseFirestore.instance;

  Future<void> sendMessage(String fromId, String toId, String text) async {
    await _cloudFireStore.collection('messages').add({
      'fromId': fromId,
      'toId': toId,
      'text': text,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<List<MessageModel>> getMessages(String userId1, String userId2) {
    return _cloudFireStore
        .collection('messages')
        .where('fromId', whereIn: [userId1, userId2])
        .where('toId', whereIn: [userId1, userId2])
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return MessageModel.fromFirestore(doc);
          }).toList();
        });
  }

  Future<List<String>> getUsersIdsWithWhomUserHasConversed(String userId) async {
    var querySnapshot = await _cloudFireStore
        .collection('messages')
        .where('fromId', isEqualTo: userId)
        .get();

    Set<String> usersWithWhomUserHasConversed = {};

    for (final doc in querySnapshot.docs) {
      usersWithWhomUserHasConversed.add(doc['toId']);
    }

    querySnapshot = await _cloudFireStore
        .collection('messages')
        .where('toId', isEqualTo: userId)
        .get();

    for (final doc in querySnapshot.docs) {
      usersWithWhomUserHasConversed.add(doc['fromId']);
    }

    return usersWithWhomUserHasConversed.toList();
  }
}

class MessageModel {
  final String fromId;
  final String toId;
  final String text;
  final DateTime timestamp;

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
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }
}
