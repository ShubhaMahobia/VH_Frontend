import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:virtual_hospital/common/components/textfields/input_decoration.dart';
import 'package:virtual_hospital/common/commonControllers/authentication_controller.dart';
import 'package:virtual_hospital/doctor/authentication/sign_up_screen.dart';
import 'package:virtual_hospital/patient/authentication/login_screen.dart';

class SignUpScreenPatient extends StatefulWidget {
  const SignUpScreenPatient({super.key});

  @override
  State<SignUpScreenPatient> createState() => _SignUpScreenPatientState();
}

class _SignUpScreenPatientState extends State<SignUpScreenPatient> {
  final AuthenticationController _authenticationController =
      Get.put(AuthenticationController());

  @override
  void dispose() {
    _authenticationController.emailController.dispose();
    _authenticationController.passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Welcome',
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 18, fontWeight: FontWeight.normal),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                    'Sign up for the Best Experience',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  width: 360,
                  height: 50,
                  decoration: FormInputField.formTextFieldContainer(context),
                  child: TextField(
                      controller: _authenticationController.emailController,
                      style: GoogleFonts.plusJakartaSans(
                          color: Colors.black, fontWeight: FontWeight.w400),
                      decoration: FormInputField.textFieldInputDecoration(
                          context, 'Email')),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: 360,
                  height: 50,
                  decoration: FormInputField.formTextFieldContainer(context),
                  child: TextField(
                    controller: _authenticationController.passwordController,
                    style: GoogleFonts.plusJakartaSans(
                        color: Colors.black, fontWeight: FontWeight.w400),
                    obscureText: true,
                    decoration: FormInputField.textFieldInputDecoration(
                        context, 'Password'),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                GestureDetector(
                  onTap: () {
                    _authenticationController.signUp();
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.0625,
                    width: 320,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: Text(
                        'Proceed',
                        style: GoogleFonts.plusJakartaSans(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Container(
                  width: 360,
                  height: 2,
                  color: const Color.fromARGB(255, 244, 241, 241),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.025,
                ),
                Text(
                  "Already have an account?",
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 14, fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => const LoginScreen(),
                        transition: Transition.noTransition);
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.0625,
                    width: 320,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent, width: 1.5),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: Text(
                        'Sign In',
                        style: GoogleFonts.plusJakartaSans(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Join as Doctor ",
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                    GestureDetector(
                      onTap: () {
                        
                        Get.to(() => const SignUpScreenDoctor(),
                            transition: Transition.noTransition);
                      },
                      child: Text(
                        " Create Account",
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
