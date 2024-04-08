import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:virtual_hospital/common/components/textfields/input_decoration.dart';
import 'package:virtual_hospital/doctor/authentication/login_screen_doctor.dart';
import 'package:virtual_hospital/doctor/controllers/doctor_controller.dart';

import 'package:virtual_hospital/patient/authentication/sign_up_patient_screen.dart';

class SignUpScreenDoctor extends StatefulWidget {
  const SignUpScreenDoctor({super.key});

  @override
  State<SignUpScreenDoctor> createState() => _SignUpScreenDoctorState();
}

class _SignUpScreenDoctorState extends State<SignUpScreenDoctor> {
  final DoctorController _doctorController = Get.put(DoctorController());

  @override
  void dispose() {
    _doctorController.emailController.dispose();
    _doctorController.passwordController.dispose();
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
                    'Joining as a Doctor? Sign up here',
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
                      controller: _doctorController.emailController,
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
                    controller: _doctorController.passwordController,
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
                    FocusScope.of(context).unfocus();
                    _doctorController.signUpDoctor();
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
                    Get.to(() => const LoginScreenDoctor(),
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
                      "Sign Up as a Patient?",
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const SignUpScreenPatient(),
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
