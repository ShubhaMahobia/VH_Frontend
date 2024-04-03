import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:virtual_hospital/common/components/buttons/b1.dart';
import 'package:virtual_hospital/common/components/textfields/input_decoration.dart';
import 'package:virtual_hospital/patient/controller/patient_controller.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

PatientController patientController = Get.put(PatientController());

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    patientController.isEditing.value = false;
    patientController.fetchUserDetails();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text(
          'Profile',
          style: GoogleFonts.plusJakartaSans(fontSize: 20, color: Colors.white),
        ),
      ),
      body: GetBuilder<PatientController>(
        builder: (controller) {
          if (controller.isLoading.value) {
            return const Center(
                child: CircularProgressIndicator(
              strokeWidth: 1,
            ));
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.blue,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 50,
                                  width: 320,
                                  decoration:
                                      FormInputField.formTextFieldContainer(
                                          context),
                                  child: TextField(
                                    enabled: patientController.isEditing.value,
                                    decoration:
                                        FormInputField.textFieldInputDecoration(
                                            context,
                                            controller.user['firstName'] +
                                                " " +
                                                controller.user['LastName']),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 50,
                                  width: 320,
                                  decoration:
                                      FormInputField.formTextFieldContainer(
                                          context),
                                  child: TextField(
                                    enabled: patientController.isEditing.value,
                                    decoration:
                                        FormInputField.textFieldInputDecoration(
                                            context, '**** **** **45 6156'),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 50,
                                  width: 320,
                                  decoration:
                                      FormInputField.formTextFieldContainer(
                                          context),
                                  child: TextField(
                                    enabled: patientController.isEditing.value,
                                    decoration:
                                        FormInputField.textFieldInputDecoration(
                                            context,
                                            controller.user['phoneNumber']),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 50,
                                  width: 320,
                                  decoration:
                                      FormInputField.formTextFieldContainer(
                                          context),
                                  child: TextField(
                                    enabled: patientController.isEditing.value,
                                    decoration:
                                        FormInputField.textFieldInputDecoration(
                                            context, controller.user['Email']),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 50,
                                  width: 320,
                                  decoration:
                                      FormInputField.formTextFieldContainer(
                                          context),
                                  child: TextField(
                                    enabled: false,
                                    decoration:
                                        FormInputField.textFieldInputDecoration(
                                            context,
                                            controller.user['dateOfBirth']),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ButtonOne(
                                  buttonText: 'Add Address',
                                  onTap: () {},
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ButtonOne(
                                  buttonText: patientController.isEditing.value
                                      ? 'Save'
                                      : 'Edit Profile',
                                  onTap: () {
                                    setState(() {
                                      patientController.isEditing.value =
                                          !patientController.isEditing.value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }
}
