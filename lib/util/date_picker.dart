import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:virtual_hospital/common/commonControllers/authentication_controller.dart';
import 'package:virtual_hospital/common/components/textfields/input_decoration.dart';
import 'package:intl/intl.dart';

// ignore: use_key_in_widget_constructors
class CalendarWidget extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  final AuthenticationController _authenticationController =
      Get.put(AuthenticationController());
  String selectedDate = '';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        selectedDate = DateFormat('dd/MM/yyyy').format(picked);
        _authenticationController.dobController.text = selectedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        height: 50,
        width: 320,
        decoration: FormInputField.formTextFieldContainer(context),
          child: selectedDate.isNotEmpty
              ? Text(
                  selectedDate,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
                )
              : Text(
                  'Enter your Date of Birth',
                  style: GoogleFonts.plusJakartaSans(
                      color: Colors.grey, fontWeight: FontWeight.w400),
                ),
        )
    );
  }
}
