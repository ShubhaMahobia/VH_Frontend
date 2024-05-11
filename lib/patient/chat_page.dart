import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:virtual_hospital/common/commonControllers/global_controller.dart';
import 'package:virtual_hospital/common/components/chat_bubble.dart';

class ChatPage extends StatefulWidget {
  const ChatPage(
      {super.key,
      required this.recevierEmail,
      required this.receiverId,
      required this.name});

  final String recevierEmail;
  final String receiverId;
  final String name;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final GlobalController _globalController = GlobalController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Send message
  void sendMessage() {
    if (_messageController.text.isNotEmpty) {
      _globalController.sendMessage(_messageController.text, widget.receiverId);
      _messageController.clear();
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(widget.name),
            centerTitle: true,
            titleTextStyle: GoogleFonts.plusJakartaSans(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.black)),
        body: Column(
      children: [
        Expanded(
          child: _buildMessageList(),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: _buildUserInput(),
        ),
      ],
    ));
  }

  Widget _buildMessageList() {
    String senderId = _auth.currentUser!.uid;
    return StreamBuilder(
        stream: _globalController.getMessage(widget.receiverId, senderId),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Error occured'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              strokeWidth: 1.0,
            ));
          }
          return ListView(
            children: snapshot.data!.docs
                .map<Widget>((doc) => _buildMessageItem(doc))
                .toList(),
          );
        });
  }

  Widget _buildMessageItem(doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    bool isCurrentUser = data['senderId'] == _auth.currentUser!.uid;
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 2,
        horizontal: 10,
      ),
      child: Column(
        crossAxisAlignment:
            isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          ChatBubble(message: data['message'], isCurrentUser: isCurrentUser)
        ],
      ),
    );
  }

  Widget _buildUserInput() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: 50,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: _messageController,
              style: GoogleFonts.plusJakartaSans(),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Type a message...',
                hintStyle: GoogleFonts.plusJakartaSans(),
              ),
            ),
          ),
        ),
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(50),
          ),
          child: IconButton(
            onPressed: sendMessage,
            icon: const Icon(
              Icons.send,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }

}
