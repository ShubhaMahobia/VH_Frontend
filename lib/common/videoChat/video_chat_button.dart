import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtual_hospital/common/videoChat/video_chat.dart';
import 'package:virtual_hospital/patient/profile_page.dart';
import 'package:uuid/uuid.dart';

class DummyScreen extends StatefulWidget {
  const DummyScreen({super.key});

  @override
  State<DummyScreen> createState() => _DummyScreenState();
}

class _DummyScreenState extends State<DummyScreen> {
  Color buttonColor = Colors.grey;
  late String callId;
  late String userName;

  @override
  void initState() {
    buttonColorUpdate();
    super.initState();
  }

  void configuringMeeting() {
    var uuid = Uuid();
    String randomId = uuid.v4();
    callId = randomId;
    userName = patientController.user['firstName'] +
        ' ' +
        patientController.user['lastName'];
  }

  void buttonColorUpdate() {
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        // Update the button color based on the current time
        buttonColor = _getColorBasedOnTime(DateTime.now());
      });
    });
  }

//This function will return the color and function based on the time if the time is according to the slots then it will be active otherwise it will be inactive
  static Color _getColorBasedOnTime(DateTime dateTime) {
    int hour = dateTime.hour;
    int minute = dateTime.minute;
    if (hour == 22 && minute >= 0 && minute < 38) {
      return Colors.blue;
    } else {
      return Colors.grey;
    }
  }

  //Meeting hour
  //Start time
  //End time
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
          ),
          child: const Text('Start Video Chat'),
          onPressed: () {
            Get.to(() =>
                 CallPage(
                callId: callId,
                userName: userName,
              ),
            );
          },
        ),
      ),
    );
  }
}
