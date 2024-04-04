import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class SuccessSnackbar extends StatelessWidget {
  String textMsg;
  // ignore: use_key_in_widget_constructors
  SuccessSnackbar({Key? key, required this.textMsg});

  void _showSuccessSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 1),
        backgroundColor: Colors.lightGreen,
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

  void show(BuildContext context) {
    _showSuccessSnackbar(context);
  }
}
