import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class ErrorSnackBar extends StatelessWidget {
  String textMsg;
  // ignore: use_key_in_widget_constructors
  ErrorSnackBar({Key? key, required this.textMsg});

  void _showErrorSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 1),
        backgroundColor: Colors.red,
        content: Text(
          textMsg,
          style: GoogleFonts.plusJakartaSans(
              fontSize: 16, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  // Method to show the SnackBar
  void show(BuildContext context) {
    _showErrorSnackbar(context);
  }
}
