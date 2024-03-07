import 'package:flutter/material.dart';

class SignUpScreenPatient extends StatelessWidget {
  const SignUpScreenPatient({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Email',
              ),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Password',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
