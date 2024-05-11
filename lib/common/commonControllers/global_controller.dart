import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:virtual_hospital/models/message.dart';

class GlobalController extends GetxController {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Chat message - sent
  Future<void> sendMessage(String message, String receiverId) async {
    //Get current user infor -
    final String senderId = _auth.currentUser!.uid;
    final String senderEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();
    //Create Message

    Message newMessage = Message(
        senderId: senderId,
        receiverId: receiverId,
        message: message,
        senderEmail: senderEmail,
        timestamp: timestamp);

    List<String> members = [senderId, receiverId];
    members.sort();
    String chatRoomId = members.join('_');
    await _fireStore
        .collection('chat_room')
        .doc(chatRoomId)
        .collection("messages")
        .add(newMessage.toMap());
  }

  Stream<QuerySnapshot> getMessage(String userId, otherUserID) {
    List<String> members = [userId, otherUserID];
    members.sort();
    String chatRoomId = members.join('_');

    return _fireStore
        .collection('chat_room')
        .doc(chatRoomId)
        .collection("messages")
        .orderBy('timestamp')
        .snapshots();
  }
}
