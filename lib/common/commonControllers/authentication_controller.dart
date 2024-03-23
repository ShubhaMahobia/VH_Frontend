import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtual_hospital/patient/home_page.dart';
import 'package:virtual_hospital/services/firebase_auth_services.dart';
import 'package:http/http.dart' as http;

class AuthenticationController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final FirebaseAuthService _authService = FirebaseAuthService();

  void signUp() async {
    String email = emailController.text;
    String password = emailController.text;
    User? user = await _authService.signUpWithEmailAndPassword(email, password);
    if (user != null) {     
      Get.to(() => const PatientHomePage());
    } else {
      print("Error Occured");
    }
  }

  void signIn() async {
    String email = emailController.text;
    String password = emailController.text;
    try {
      User? user =
          await _authService.signInWithEmailAndPassword(email, password);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('userId', user?.uid as String);

      String body = json.encode(
          {"email": emailController.text, "password": passwordController.text});

      http.Response res = await http.post(
        Uri.parse(''),
        headers: {'Content-Type': 'application/json'},
        body: body,
      );
    } catch (e) {}
  }
}
