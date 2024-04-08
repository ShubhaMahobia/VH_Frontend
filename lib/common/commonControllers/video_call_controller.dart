import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:virtual_hospital/util/snackbar/error_snackbar.dart';
import 'package:virtual_hospital/util/snackbar/success_snackbar.dart';

class VideoCallController extends GetxController {
  void bookAppointment() async {
    try {
      String body = json.encode({
        "doctorId": "xyzz",
        "patientId": "abc",
        "meetingId": "123456789",
        "meetingDate": "2022-12-12",
        "meetingHour": "14",
        "meetingStartMinute": "30",
        "meetingEndMinute": "45",
        "meetingDescription": "This is a meeting description",
      });

      http.Response res = await http.post(
        Uri.parse(
            ''), // Replace YOUR_SERVER_ADDRESS with the correct server address
        headers: {'Content-Type': 'application/json'},
        body: body,
      );
      var jsonData = json.decode(res.body);
      if (jsonData['success']) {
        SuccessSnackbar(
          textMsg: 'Appointment Booked Successfully',
        ).show(Get.context as BuildContext);
        Get.back();
      } else {
        ErrorSnackBar(
          textMsg: 'Internal Server Error, Please try again later',
        ).show(Get.context as BuildContext);
      }
    } catch (e) {
      ErrorSnackBar(
        textMsg: 'Something Went Wrong',
      ).show(Get.context as BuildContext);
    }
  }

  void getAppointment() {
    // Get appointment logic
  }
}
