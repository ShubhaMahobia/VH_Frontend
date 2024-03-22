import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FormInputField {
  static BoxDecoration formTextFieldContainer(BuildContext context) {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: const Color.fromARGB(255, 247, 223, 223),
      ),
    );
  }

  static InputDecoration textFieldInputDecoration(
      BuildContext context, String hintext) {
    return InputDecoration(
      contentPadding: const EdgeInsets.all(10),
      border: InputBorder.none,
      hintText: hintext,
      hintStyle: GoogleFonts.plusJakartaSans(
          color: Colors.grey, fontWeight: FontWeight.w400),
    );
  }
}
