import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:virtual_hospital/common/commonControllers/authentication_controller.dart';
import 'package:virtual_hospital/common/components/buttons/b1.dart';
import 'package:virtual_hospital/common/components/textfields/input_decoration.dart';
import 'package:virtual_hospital/doctor/controllers/doctor_controller.dart';

class ProfilePageDoctor extends StatefulWidget {
  const ProfilePageDoctor({super.key});

  @override
  State<ProfilePageDoctor> createState() => _ProfilePageState();
}

DoctorController doctorController = Get.put(DoctorController());

class _ProfilePageState extends State<ProfilePageDoctor> {
  @override
  void initState() {
    doctorController.fetchUserDetails();
    super.initState();
  }

  final AuthenticationController _authenticationController =
      Get.put(AuthenticationController());

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
      body: GetBuilder<DoctorController>(
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
                  height: 120,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.blue,
                  //Add circle of size 100 in center
                  child: Center(
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          doctorController.doctor['profilePicture']),
                      radius: 50,
                      backgroundColor: Colors.white,
                    ),
                  ),
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
                                    decoration:
                                        FormInputField.textFieldInputDecoration(
                                            context,
                                            controller.doctor['firstName'] +
                                                " " +
                                                controller.doctor['LastName']),
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
                                    //enabled: doctorController.isEditing.value,
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
                                    //enabled: doctorController.isEditing.value,
                                    decoration:
                                        FormInputField.textFieldInputDecoration(
                                            context,
                                            controller.doctor['phoneNumber']),
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
                                    //: doctorController.isEditing.value,
                                    decoration:
                                        FormInputField.textFieldInputDecoration(
                                            context,
                                            controller.doctor['Email']),
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
                                    //: doctorController.isEditing.value,
                                    decoration:
                                        FormInputField.textFieldInputDecoration(
                                            context,
                                            " ${controller.doctor['Experience']} years of experience"),
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
                                    //: doctorController.isEditing.value,
                                    decoration:
                                        FormInputField.textFieldInputDecoration(
                                            context,
                                            controller
                                                .doctor['SpecializedField']),
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
                                    //: doctorController.isEditing.value,
                                    decoration:
                                        FormInputField.textFieldInputDecoration(
                                            context,
                                            controller.doctor['address']),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ButtonOne(
                                  buttonText: 'Sign Out',
                                  onTap: () {
                                    _authenticationController.signOut();
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ButtonOne(
                                  buttonText: 'Save',
                                  onTap: () {},
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
