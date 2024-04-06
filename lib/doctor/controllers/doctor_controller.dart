import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:virtual_hospital/util/snackbar/error_snackbar.dart';
import 'package:http/http.dart' as http;
import 'package:virtual_hospital/util/snackbar/success_snackbar.dart';

class DoctorController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController specificationController = TextEditingController();
  TextEditingController experienceController = TextEditingController();
  TextEditingController qualificationController = TextEditingController();
  TextEditingController clinicAddressController = TextEditingController();

  void createDoctorProfile() async {
    print("method called");
    //Get the values from the text editing controllers
    String email = emailController.text;
    String firstName = firstNameController.text;
    String lastName = lastNameController.text;
    String phoneNumber = phoneNumberController.text;
    String specification = specificationController.text;
    String experience = experienceController.text;
    String qualification = qualificationController.text;
    String clinicAddress = clinicAddressController.text;

    //Check if the fields are empty
    if (firstName.isEmpty ||
        lastName.isEmpty ||
        phoneNumber.isEmpty ||
        specification.isEmpty ||
        experience.isEmpty ||
        qualification.isEmpty ||
        clinicAddress.isEmpty) {
      ErrorSnackBar(textMsg: 'All fields are required')
          .show(Get.context as BuildContext);
    } else {
      try {
        List<Map<String, String>> availability = [
          {"day": "Monday", "time": "9am - 5pm"},
          {"day": "Tuesday", "time": "9am - 5pm"},
          // Add more days as needed
        ];
        EasyLoading.show(status: 'Loading...');
        String body = json.encode({
          "firebaseUserId": 'asdmawmkdanmwlkdawdk',
          "firstName": firstNameController.text,
          "lastName": lastNameController.text,
          "email": 'ok@gmail.com',
          "phoneNumber": phoneNumberController.text,
          "experience": experienceController.text,
          "gender": "Male",
          "availability": availability,
          "profilePicture": "https://www.google.com",
          "address": clinicAddressController.text,
          "specializedField": specificationController.text,
          "degree": qualificationController.text,
          "identificationNumber": "1234567890",
        });
        http.Response res = await http.post(
          Uri.parse(
              'http://192.168.29.161:8080/api/registerDoctor'), // Replace YOUR_SERVER_ADDRESS with the correct server address
          headers: {'Content-Type': 'application/json'},
          body: body,
        );
        print(body);

        var jsonData = json.decode(res.body);
        print(jsonData);
        if (jsonData['success']) {
          EasyLoading.dismiss();
          SuccessSnackbar(
            textMsg: 'Profile Created Successfully',
          ).show(Get.context as BuildContext);
        } else {
          EasyLoading.dismiss();
          ErrorSnackBar(
            textMsg: 'Internal Server Error, Please try again later',
          ).show(Get.context as BuildContext);
        }
      } catch (e) {
        EasyLoading.dismiss();
        print(e);
        ErrorSnackBar(
          textMsg: 'Something Went Wrong',
        ).show(Get.context as BuildContext);
      }
    }
  }
}
