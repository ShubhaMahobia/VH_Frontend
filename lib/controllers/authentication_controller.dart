import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:virtual_hospital/home_page.dart';
import 'package:virtual_hospital/services/firebase_auth_services.dart';

class AuthenticationController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FirebaseAuthService _authService = FirebaseAuthService();

  void signUp() async {
    String email = emailController.text;
    String password = emailController.text;
    User? user = await _authService.signUpWithEmailAndPassword(email, password);
    if (user != null) {
      print("User Created Sucessfully");
      Get.to(() => HomePage());
    } else {
      print("Error Occured");
    }
  }
}
