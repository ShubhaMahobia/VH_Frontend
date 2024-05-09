import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtual_hospital/patient/authentication/login_screen.dart';
import 'package:virtual_hospital/patient/authentication/create_profile.dart';
import 'package:virtual_hospital/services/firebase_auth_services.dart';
import 'package:http/http.dart' as http;
import 'package:virtual_hospital/util/footer.dart';
import 'package:virtual_hospital/util/snackbar/error_snackbar.dart';
import 'package:virtual_hospital/util/snackbar/success_snackbar.dart';

class AuthenticationController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isPatient = true.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController genderController = TextEditingController();
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
          .then((value) => Get.to(() => const CreateProfilePatient()));
    } catch (e) {
      EasyLoading.dismiss();
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
      prefs.setString(
        'userId',
        user?.uid as String,
      );
      String body = json.encode({
        "firebaseUserId": FirebaseAuth.instance.currentUser!.uid,
      });
      http.Response res = await http.post(
        Uri.parse(
            'https://nirogbharatbackend.azurewebsites.net/api/isPatientExist'), // Replace YOUR_SERVER_ADDRESS with the correct server address
        headers: {'Content-Type': 'application/json'},
        body: body,
      );
      var jsonData = json.decode(res.body);
      if (jsonData['success'] == true) {
        if (jsonData['isPresent'] == true) {
          EasyLoading.dismiss();
          SuccessSnackbar(textMsg: 'Login successful')
              .show(Get.context as BuildContext);
          await Future.delayed(const Duration(seconds: 1))
              .then((value) => Get.to(() => const LandingPage()));
        } else {
          EasyLoading.dismiss();
          ErrorSnackBar(textMsg: 'User does not exist, Login Failed')
              .show(Get.context as BuildContext);
        }
      } else {
        EasyLoading.dismiss();
        ErrorSnackBar(textMsg: 'Login failed')
            .show(Get.context as BuildContext);
      }
    } catch (e) {
      EasyLoading.dismiss();
    }
  }

//Create Profile Function Patient
  void createProfilePatient() async {
    if (firstNameController.text.isEmpty) {
      ErrorSnackBar(textMsg: 'First Name is required')
          .show(Get.context as BuildContext);
      return;
    }
    if (lastNameController.text.isEmpty) {
      ErrorSnackBar(textMsg: 'Last Name is required')
          .show(Get.context as BuildContext);
      return;
    }
    if (dobController.text.isEmpty) {
      ErrorSnackBar(textMsg: 'Date of Birth is required')
          .show(Get.context as BuildContext);
      return;
    }
    if (phoneNumberController.text.isEmpty) {
      ErrorSnackBar(textMsg: 'Phone Number is required')
          .show(Get.context as BuildContext);
      return;
    }
    if (identificationNumberController.text.isEmpty) {
      ErrorSnackBar(textMsg: 'Aadhar Number is required')
          .show(Get.context as BuildContext);
      return;
    }
    try {
      EasyLoading.show(status: 'Loading...');
      String body = json.encode({
        "firebaseUserId": FirebaseAuth.instance.currentUser!.uid,
        "firstName": firstNameController.text,
        "lastName": lastNameController.text,
        "dateOfBirth": dobController.text,
        "email": emailController.text,
        "phoneNumber": phoneNumberController.text,
        "gender": genderController.text,
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
            .then((value) => Get.to(() => const LandingPage()));
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


  Future<void> signOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    SuccessSnackbar(textMsg: 'Signed Out Successfully!')
        .show(Get.context as BuildContext);
    await Future.delayed(
      const Duration(milliseconds: 500),
    );
    await FirebaseAuth.instance.signOut().then((value) =>
        Get.to(() => const LoginScreen(), transition: Transition.noTransition));
  }


  Future<bool> isUserPatient() async {
    isLoading.value = true;
    String body = json.encode({
      "firebaseUserId": FirebaseAuth.instance.currentUser!.uid,
    });
    http.Response res = await http.post(
      Uri.parse(
          'https://nirogbharatbackend.azurewebsites.net/api/defineUser'), // Replace YOUR_SERVER_ADDRESS with the correct server address
      headers: {'Content-Type': 'application/json'},
      body: body,
    );
    var jsonData = json.decode(res.body);
    if (jsonData['success'] == true) {
      isLoading.value = false;
      return jsonData['isPatient'];
    } else {
      isLoading.value = false;
      ErrorSnackBar(textMsg: 'Something Went Wrong')
          .show(Get.context as BuildContext);
      return jsonData['isPatient'];
    }
  }




}


