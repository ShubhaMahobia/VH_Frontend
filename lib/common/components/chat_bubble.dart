import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble(
      {super.key, required this.message, required this.isCurrentUser});
  final String message;
  final bool isCurrentUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      constraints: const BoxConstraints(maxWidth: 200, minWidth: 50),
      decoration: BoxDecoration(
          color: Colors.lightBlue, borderRadius: BorderRadius.circular(20)),
      child: Text(
        textAlign: TextAlign.center,
        message,
        style: GoogleFonts.plusJakartaSans(
            fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500),
      ),
    );
  }
}
