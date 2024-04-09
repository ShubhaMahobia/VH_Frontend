import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtual_hospital/common/commonControllers/authentication_controller.dart';
import 'package:virtual_hospital/doctor/authentication/create_profile_doctor.dart';
import 'package:virtual_hospital/doctor/doctor_profile.dart';
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
  TextEditingController identificationNumberController =
      TextEditingController();
  final FirebaseAuthService _authService = FirebaseAuthService();
  final AuthenticationController _authenticationController =
      Get.put(AuthenticationController());

  var doctor = {};
  RxBool isLoading = true.obs;

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
      await Future.delayed(const Duration(seconds: 1))
          .then((value) => Get.to(() => const CreateProfileDoctor()));
    } catch (e) {
      EasyLoading.dismiss();
    }
  }

  void signInDoctor() async {
    _authenticationController.isPatient.value = false;
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
          .then((value) => Get.to(() => const ProfilePageDoctor()));
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
    if (emailController.text.isEmpty) {
      ErrorSnackBar(textMsg: 'Email is required')
          .show(Get.context as BuildContext);
      return;
    }
    if (firstName.isEmpty) {
      ErrorSnackBar(textMsg: 'First Name is required')
          .show(Get.context as BuildContext);
      return;
    } else if (lastName.isEmpty) {
      ErrorSnackBar(textMsg: 'Last Name is required')
          .show(Get.context as BuildContext);
      return;
    } else if (phoneNumber.isEmpty) {
      ErrorSnackBar(textMsg: 'Phone Number is required')
          .show(Get.context as BuildContext);
      return;
    } else if (specification.isEmpty) {
      ErrorSnackBar(textMsg: 'Specialization is required')
          .show(Get.context as BuildContext);
      return;
    } else if (experience.isEmpty) {
      ErrorSnackBar(textMsg: 'Experience is required')
          .show(Get.context as BuildContext);
      return;
    } else if (qualification.isEmpty) {
      ErrorSnackBar(textMsg: 'Qualification is required')
          .show(Get.context as BuildContext);
      return;
    } else if (clinicAddress.isEmpty) {
      ErrorSnackBar(textMsg: 'Clinic Address is required')
          .show(Get.context as BuildContext);
      return;
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
          "gender": _authenticationController.genderController.text,
          "availability": availability,
          "profilePicture": imageLinkController.text,
          "address": clinicAddressController.text,
          "specializedField": specificationController.text,
          "degree": qualificationController.text,
          "identificationNumber": identificationNumberController.text,
        });
        http.Response res = await http.post(
          Uri.parse(
              'http://192.168.136.120:8080/api/registerDoctor'), // Replace YOUR_SERVER_ADDRESS with the correct server address
          headers: {'Content-Type': 'application/json'},
          body: body,
        );

        var jsonData = json.decode(res.body);
        if (jsonData['success']) {
          _authenticationController.isPatient.value = false;
          EasyLoading.dismiss();
          SuccessSnackbar(
            textMsg: 'Profile Created Successfully',
          ).show(Get.context as BuildContext);
          await Future.delayed(const Duration(seconds: 1))
              .then((value) => Get.to(() => const ProfilePageDoctor()));
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

  Future<void> fetchUserDetails() async {
    //API call to fetch user details
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getString('userId');
      String body = jsonEncode({
        "id": userId,
      });

      http.Response res = await http.post(
        Uri.parse(
            'http://192.168.136.120:8080/api/getDoctor'), // Replace YOUR_SERVER_ADDRESS with the correct server address
        headers: {'Content-Type': 'application/json'},
        body: body,
      );
      var jsonData = json.decode(res.body);
      if (jsonData['success']) {
        //If user details are fetched successfully
        doctor = jsonData['data'];
        isLoading.value = false;
        update();
      } else {
        ErrorSnackBar(
          textMsg: 'Internal Server Error',
        ).show(Get.context as BuildContext);
      }
    } catch (e) {
      ErrorSnackBar(textMsg: e.toString()).show(Get.context as BuildContext);
    }
  }
}
