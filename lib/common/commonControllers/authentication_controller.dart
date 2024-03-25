import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtual_hospital/patient/authentication/create_profile.dart';
import 'package:virtual_hospital/patient/home_page.dart';
import 'package:virtual_hospital/services/firebase_auth_services.dart';
import 'package:http/http.dart' as http;
import 'package:virtual_hospital/util/snackbar/error_snackbar.dart';
import 'package:virtual_hospital/util/snackbar/success_snackbar.dart';

class AuthenticationController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController identificationNumberController =
      TextEditingController();
  final FirebaseAuthService _authService = FirebaseAuthService();
  
  void signUp() async {
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
          .then((value) => Get.to(() => CreateProfilePatient()));
    } catch (e) {
      EasyLoading.dismiss();
      if (e is FirebaseAuthException) {
        e.message as String;
        ErrorSnackBar(textMsg: e.message as String)
            .show(Get.context as BuildContext);
      }
    }
  }

  void signIn() async {
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
      prefs.setString('userId', user?.uid as String);
      EasyLoading.dismiss();
      SuccessSnackbar(textMsg: 'Login successful')
          .show(Get.context as BuildContext);
      await Future.delayed(const Duration(seconds: 1))
          .then((value) => Get.to(() => CreateProfilePatient()));
    } catch (e) {
      EasyLoading.dismiss();
      if (e is FirebaseAuthException) {
        e.message as String;
        ErrorSnackBar(textMsg: e.message as String)
            .show(Get.context as BuildContext);
      }
    }
  }

//Create Profile Function Patient
  void createProfilePatient() async {
    try {
      EasyLoading.show(status: 'Loading...');
      String body = json.encode({
        "firebaseUserId": FirebaseAuth.instance.currentUser!.uid,
        "firstName": firstNameController.text,
        "lastName": lastNameController.text,
        "dateOfBirth": dobController.text,
        "email": emailController.text,
        "phoneNumber": phoneNumberController.text,
        "gender": "male",
        "identificationNumber": identificationNumberController.text,
      });
      http.Response res = await http.post(
        Uri.parse(
            'https://nirogbharatbackend.azurewebsites.net/api/registerPatient'), // Replace YOUR_SERVER_ADDRESS with the correct server address
        headers: {'Content-Type': 'application/json'},
        body: body,
      );
     
      var jsonData = json.decode(res.body);
      if (jsonData['success']) {
        SuccessSnackbar(textMsg: 'Profile created successfully')
            .show(Get.context as BuildContext);
        EasyLoading.dismiss();    
        await Future.delayed(const Duration(seconds: 1))
            .then((value) => Get.to(() => const PatientHomePage()));
      } else {
        EasyLoading.dismiss(); 
        ErrorSnackBar(textMsg: 'Profile creation failed')
            .show(Get.context as BuildContext);
      }
    } catch (e) {
      EasyLoading.dismiss(); 
      ErrorSnackBar(textMsg: 'Something Went Wrong')
          .show(Get.context as BuildContext);
    }
  }
}

