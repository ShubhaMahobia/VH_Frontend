import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDropdown extends StatefulWidget {
  const CustomDropdown({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  // Default value

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      decoration: formTextFieldContainer(context),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          hint: const Padding(
            padding: EdgeInsets.only(left: 14.0),
            child: Text(' Gender'),
          ),
          icon: const Icon(Icons.arrow_drop_down),
          iconSize: 24,
          elevation: 16,
          style: GoogleFonts.plusJakartaSans(
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
          onChanged: (newValue) {
            setState(() {});
          },
          items: <String>['Male', 'Female'].map<DropdownMenuItem<String>>(
            (String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            },
          ).toList(),
        ),
      ),
    );
  }

  BoxDecoration formTextFieldContainer(BuildContext context) {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: const Color.fromARGB(255, 247, 223, 223),
      ),
    );
  }
}
