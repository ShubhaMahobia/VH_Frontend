import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtual_hospital/util/snackbar/error_snackbar.dart';

class PatientController extends GetxController {
  var user = {};
  RxBool isLoading = true.obs;
//Function to fetch user details which will take email as body
  Future<void> fetchUserDetails() async {
    //API call to fetch user details
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getString('userId');
      String body = jsonEncode({
        "id": userId,
      });

      http.Response res = await http.post(
        Uri.parse(
            'http://192.168.1.4:8080/api/getUser'), // Replace YOUR_SERVER_ADDRESS with the correct server address
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      var jsonData = json.decode(res.body);
      if (jsonData['success']) {
        //If user details are fetched successfully
        user = jsonData['data'];
        isLoading.value = false;

        update();
      } else {
        //If user details are not fetched successfully
        print(jsonData['message']);
      }
    } catch (e) {
      print(e.toString());
      ErrorSnackBar(textMsg: e.toString()).show(Get.context as BuildContext);
    }
  }
}
