import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:virtual_hospital/common/commonControllers/authentication_controller.dart';
import 'package:virtual_hospital/common/components/textfields/input_decoration.dart';

class CustomDropdown extends StatefulWidget {
  const CustomDropdown({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String defaultValue = '';

  final AuthenticationController _authenticationController =
      Get.put(AuthenticationController());

  String dropdownvalue = 'Male';

  var items = [
    'Male',
    'Female',
  ];    
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      height: 50,
      width: 320,
      decoration: FormInputField.formTextFieldContainer(context),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          value: dropdownvalue,
          icon: const Icon(Icons.keyboard_arrow_down),
          items: items.map((String items) {
            return DropdownMenuItem(
              value: items,
              child: Text(items),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              dropdownvalue = newValue!;
              _authenticationController.genderController.text = newValue;
            });
          },
        ),
      ),
    );
  }


}
