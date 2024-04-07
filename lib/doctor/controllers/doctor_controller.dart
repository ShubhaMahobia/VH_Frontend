import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtual_hospital/doctor/authentication/create_profile_doctor.dart';
import 'package:virtual_hospital/services/firebase_auth_services.dart';
import 'package:virtual_hospital/util/snackbar/error_snackbar.dart';
import 'package:http/http.dart' as http;
import 'package:virtual_hospital/util/snackbar/success_snackbar.dart';

class DoctorController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController specificationController = TextEditingController();
  TextEditingController experienceController = TextEditingController();
  TextEditingController qualificationController = TextEditingController();
  TextEditingController clinicAddressController = TextEditingController();
  TextEditingController imageLinkController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  final FirebaseAuthService _authService = FirebaseAuthService();

  void signUpDoctor() async {
    try {
      if (emailController.text.isEmpty) {
        ErrorSnackBar(textMsg: 'Email is required')
            .show(Get.context as BuildContext);
        return;
      }
      if (passwordController.text.isEmpty) {
        ErrorSnackBar(textMsg: 'Password is required')
            .show(Get.context as BuildContext);
        return;
      }
      EasyLoading.show(status: 'Loading');
      String email = emailController.text;
      String password = passwordController.text;
      User? user =
          await _authService.signUpWithEmailAndPassword(email, password);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('userId', user?.uid as String);
      EasyLoading.dismiss();
      SuccessSnackbar(textMsg: 'Account created successfully')
          .show(Get.context as BuildContext);
      await Future.delayed(const Duration(seconds: 2))
          .then((value) => Get.to(() => const CreateProfileDoctor()));
    } catch (e) {
      EasyLoading.dismiss();
    }
  }

  void signInDoctor() async {
    String email = emailController.text;
    String password = passwordController.text;
    try {
      if (emailController.text.isEmpty) {
        ErrorSnackBar(textMsg: 'Email is required')
            .show(Get.context as BuildContext);
        return;
      }
      if (passwordController.text.isEmpty) {
        ErrorSnackBar(textMsg: 'Password is required')
            .show(Get.context as BuildContext);
        return;
      }
      EasyLoading.show(status: 'Loading...');
      User? user =
          await _authService.signInWithEmailAndPassword(email, password);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(
        'userId',
        user?.uid as String,
      );
      EasyLoading.dismiss();
      SuccessSnackbar(textMsg: 'Login successful')
          .show(Get.context as BuildContext);
      await Future.delayed(const Duration(seconds: 1))
          .then((value) => Get.to(() => Container(
                color: Colors.red,
              )));
    } catch (e) {
      EasyLoading.dismiss();
    }
  }

  void createDoctorProfile() async {
    List<Map<String, String>> availability = [
      {"day": "Monday", "time": "9am - 5pm"},
      {"day": "Tuesday", "time": "9am - 5pm"},
      // Add more days as needed
    ];
    //Get the values from the text editing controllers
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
        EasyLoading.show(status: 'Loading...');

        //Image Upload Function -

        String body = json.encode({
          "firebaseUserId": FirebaseAuth.instance.currentUser?.uid,
          "firstName": firstNameController.text,
          "lastName": lastNameController.text,
          "email": emailController.text,
          "phoneNumber": phoneNumberController.text,
          "experience": experienceController.text,
          "gender": "male",
          "availability": availability,
          "profilePicture": imageLinkController.text,
          "address": clinicAddressController.text,
          "specializedField": specificationController.text,
          "degree": qualificationController.text,
          "identificationNumber": "1234567805345390",
        });
        http.Response res = await http.post(
          Uri.parse(
              'http://192.168.29.161:8080/api/registerDoctor'), // Replace YOUR_SERVER_ADDRESS with the correct server address
          headers: {'Content-Type': 'application/json'},
          body: body,
        );
     

        var jsonData = json.decode(res.body);
  
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
        
        ErrorSnackBar(
          textMsg: 'Something Went Wrong',
        ).show(Get.context as BuildContext);
      }
    }
  }
}
