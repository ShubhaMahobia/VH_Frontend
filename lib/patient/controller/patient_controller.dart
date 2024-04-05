import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:virtual_hospital/util/snackbar/error_snackbar.dart';

class PatientController extends GetxController {
  var user = {};
  RxBool isLoading = true.obs;
  RxBool isEditing = false.obs;
//Function to fetch user details which will take email as body
  Future<void> fetchUserDetails() async {
    //API call to fetch user details
    try {
      String email = FirebaseAuth.instance.currentUser!.email!;
      String body = jsonEncode({
        "email": email,
      });

      http.Response res = await http.post(
        Uri.parse(
            'https://nirogbharatbackend.azurewebsites.net/api/getUser'), // Replace YOUR_SERVER_ADDRESS with the correct server address
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
        ErrorSnackBar(
          textMsg: 'Internal Server Error',
        ).show(Get.context as BuildContext);
        
      }
    } catch (e) {
    
      ErrorSnackBar(textMsg: e.toString()).show(Get.context as BuildContext);
    }
  }
}
