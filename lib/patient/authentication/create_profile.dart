import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:virtual_hospital/common/components/buttons/b1.dart';
import 'package:virtual_hospital/common/components/dropdowns/custom_dropdown.dart';
import 'package:virtual_hospital/common/components/textfields/input_decoration.dart';

class CreateProfilePatient extends StatelessWidget {
  const CreateProfilePatient({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              Text(
                'Lets Create Your Account',
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 24, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      height: 50,
                      width: 150,
                      decoration:
                          FormInputField.formTextFieldContainer(context),
                      child: TextField(
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: FormInputField.textFieldInputDecoration(
                              context, 'First Name*')),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      height: 50,
                      width: 150,
                      decoration:
                          FormInputField.formTextFieldContainer(context),
                      child: TextField(
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: FormInputField.textFieldInputDecoration(
                              context, 'Last Name*')),
                    ),
                  ),
                ],
              ),

              //This Field will be uneditable as will be fetched automatically
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: 50,
                  width: 320,
                  decoration: FormInputField.formTextFieldContainer(context),
                  child: TextField(
                      enabled: false,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: FormInputField.textFieldInputDecoration(
                          context, 'Mahobiashubham4@gmail.com')),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: 50,
                  width: 320,
                  decoration: FormInputField.formTextFieldContainer(context),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 14, fontWeight: FontWeight.bold),
                    decoration: FormInputField.textFieldInputDecoration(
                        context, 'Phone Number*'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: 50,
                  width: 320,
                  decoration: FormInputField.formTextFieldContainer(context),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 14, fontWeight: FontWeight.bold),
                    decoration: FormInputField.textFieldInputDecoration(
                        context, 'Date of Birth*  (DD/MM/YYYY)'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomDropdown(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: 50,
                  width: 320,
                  decoration: FormInputField.formTextFieldContainer(context),
                  child: TextField(
                    inputFormatters: [LengthLimitingTextInputFormatter(12)],
                    keyboardType: TextInputType.number,
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 14, fontWeight: FontWeight.bold),
                    decoration: FormInputField.textFieldInputDecoration(
                        context, 'Aadhar Card Number*'),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: ButtonOne(buttonText: 'Create Account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
