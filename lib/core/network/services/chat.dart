// chat_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modares/model/user_model.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String getChatId(String studentEmail, String teacherEmail) {
    return "${studentEmail}__${teacherEmail}";
  }

  Future<void> createConversationIfNotExists({
    required UserModel currentUser,
    required String teacherEmail,
    required String teacherName,
    required String? teacherImage,
  }) async {
    final chatId = getChatId(currentUser.email.toString(), teacherEmail);
    final docRef = _firestore.collection("conversations").doc(chatId);
    final doc = await docRef.get();

    if (!doc.exists) {
      await docRef.set({
        "teacherName": teacherName,
        "teacherImage": teacherImage,
        "teacherEmail": teacherEmail,
        "participantIds": [currentUser.id.toString(), teacherEmail],
        "createdAt": FieldValue.serverTimestamp(),
        "createdAtMs": DateTime.now().millisecondsSinceEpoch,
        "lastMessageText": "",
        "lastMessageSenderId": "",
        "lastMessageSenderName": "",
        "lastMessageAt": FieldValue.serverTimestamp(),
        "lastMessageAtMs": DateTime.now().millisecondsSinceEpoch,
      });
    }
  }

  Future<void> sendMessage({
    required UserModel currentUser,
    required String teacherEmail,
    required String text,
  }) async {
    final chatId = getChatId(currentUser.id.toString(), teacherEmail);
    final now = DateTime.now().millisecondsSinceEpoch;

    await _firestore
        .collection("conversations")
        .doc(chatId)
        .collection("messages")
        .add({
          "senderId": currentUser.id.toString(),
          "senderName": currentUser.name,
          "text": text,
          "createdAt": FieldValue.serverTimestamp(),
          "createdAtMs": now,
        });

    await _firestore.collection("conversations").doc(chatId).update({
      "lastMessageText": text,
      "lastMessageSenderId": currentUser.id.toString(),
      "lastMessageSenderName": currentUser.name,
      "lastMessageAt": FieldValue.serverTimestamp(),
      "lastMessageAtMs": now,
    });
  }

  Stream<QuerySnapshot> getMessages({
    required String studentId,
    required String teacherEmail,
  }) {
    final chatId = getChatId(studentId, teacherEmail);
    return _firestore
        .collection("conversations")
        .doc(chatId)
        .collection("messages")
        .orderBy("createdAtMs", descending: false)
        .snapshots();
  }

  Stream<QuerySnapshot> getConversations(String userId) {
    return _firestore
        .collection("conversations")
        .where("participantIds", arrayContains: userId)
        .orderBy("lastMessageAtMs", descending: true)
        .snapshots();
  }
}
