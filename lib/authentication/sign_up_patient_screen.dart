import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:virtual_hospital/common/input_decoration.dart';

class SignUpScreenPatient extends StatelessWidget {
  const SignUpScreenPatient({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: Expanded(
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
                  width: MediaQuery.of(context).size.width * 0.6,
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
                    style: GoogleFonts.plusJakartaSans(
                        color: Colors.black, fontWeight: FontWeight.w400),
                    obscureText: true,
                    decoration: FormInputField.textFieldInputDecoration(
                        context, 'Password'),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'Forgot Password?',
                        style: GoogleFonts.plusJakartaSans(
                            color: Colors.blue, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.0625,
                    width: 320,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: Text(
                        'Create Account',
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
                  onTap: () {},
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
