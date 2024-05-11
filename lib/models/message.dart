import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderId;
  final String receiverId;
  final String message;
  final String senderEmail;
  final Timestamp timestamp;

  Message({
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.senderEmail,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'senderEmail': senderEmail,
      'timestamp': timestamp,
    };
  }
}
