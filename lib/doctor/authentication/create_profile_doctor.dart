import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:virtual_hospital/common/commonControllers/authentication_controller.dart';
import 'package:virtual_hospital/common/components/buttons/b1.dart';
import 'package:virtual_hospital/common/components/dropdowns/custom_dropdown.dart';
import 'package:virtual_hospital/common/components/textfields/input_decoration.dart';
import 'package:virtual_hospital/doctor/controllers/doctor_controller.dart';
import 'package:virtual_hospital/util/date_picker.dart';

class CreateProfileDoctor extends StatefulWidget {
  const CreateProfileDoctor({super.key});

  @override
  State<CreateProfileDoctor> createState() => _CreateProfileDoctorState();
}

class _CreateProfileDoctorState extends State<CreateProfileDoctor> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    EasyLoading.dismiss();
    super.dispose();
  }

  final DoctorController _doctorController = Get.put(DoctorController());

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
                          controller: _doctorController.firstNameController,
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
                          controller: _doctorController.lastNameController,
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
                      controller: _doctorController.emailController,
                      enabled: false,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: FormInputField.textFieldInputDecoration(
                        context,
                        _doctorController.emailController.text,
                      )),
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
                    inputFormatters: [LengthLimitingTextInputFormatter(2)],
                    controller: _doctorController.experienceController,
                    keyboardType: TextInputType.number,
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 14, fontWeight: FontWeight.bold),
                    decoration: FormInputField.textFieldInputDecoration(
                        context, 'Years of Experience*'),
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
                    inputFormatters: [LengthLimitingTextInputFormatter(12)],
                    controller: _doctorController.specificationController,
                    keyboardType: TextInputType.number,
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 14, fontWeight: FontWeight.bold),
                    decoration: FormInputField.textFieldInputDecoration(
                        context, 'Specialization*'),
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
                    inputFormatters: [LengthLimitingTextInputFormatter(12)],
                    //   controller: _doctorController.phoneNumberController,
                    keyboardType: TextInputType.number,
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 14, fontWeight: FontWeight.bold),
                    decoration: FormInputField.textFieldInputDecoration(
                        context, 'Availablity*'),
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
                    inputFormatters: [LengthLimitingTextInputFormatter(12)],
                    controller: _doctorController.qualificationController,
                    keyboardType: TextInputType.number,
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 14, fontWeight: FontWeight.bold),
                    decoration: FormInputField.textFieldInputDecoration(
                        context, 'Highest Qualification*'),
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
                    inputFormatters: [LengthLimitingTextInputFormatter(12)],
                    controller: _doctorController.clinicAddressController,
                    keyboardType: TextInputType.number,
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 14, fontWeight: FontWeight.bold),
                    decoration: FormInputField.textFieldInputDecoration(
                        context, 'Clinic Address*'),
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
                    inputFormatters: [LengthLimitingTextInputFormatter(12)],
                    controller: _doctorController.phoneNumberController,
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
                child: CalendarWidget(),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CustomDropdown(),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: ButtonOne(
                  buttonText: 'Create Account',
                  onTap: () {
                    _doctorController.createDoctorProfile();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
