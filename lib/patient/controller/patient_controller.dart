import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtual_hospital/util/snackbar/error_snackbar.dart';

class PatientController extends GetxController {
  var user = {};
  RxBool isLoading = true.obs;
  RxBool isEditing = false.obs;
  RxString lat = "".obs;
  RxString long = "".obs;
  var allDoctors = [];
  var hospitals = [];
  var singleHospital = [];
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
            'https://nirogbharatbackend.azurewebsites.net/api/getUser'), // Replace YOUR_SERVER_ADDRESS with the correct server address
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      var jsonData = json.decode(res.body);

      if (jsonData['success']) {
        isLoading.value = false;
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
      isLoading.value = false;
      ErrorSnackBar(textMsg: e.toString()).show(Get.context as BuildContext);
    }
  }

  Future<void> fetchAllDoctors() async {
    //API call to fetch user details
    try {
      http.Response res = await http.get(
        Uri.parse(
            'https://nirogbharatbackend.azurewebsites.net/api/getAllDoctors'), // Replace YOUR_SERVER_ADDRESS with the correct server address
        headers: {'Content-Type': 'application/json'},
      );

      var jsonData = json.decode(res.body);
      if (jsonData['success']) {
        //If user details are fetched successfully
        allDoctors = jsonData['data'];
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

  Future<void> fetchAllHospital() async {
    //API call to fetch user details
    try {
      String body = json.encode({"latitude": "$lat", "longitude": "$long"});
      http.Response res = await http.post(
          Uri.parse(
              'https://nirogbharatbackend.azurewebsites.net/api/fetchHospitals'), // Replace YOUR_SERVER_ADDRESS with the correct server address
          headers: {'Content-Type': 'application/json'},
          body: body);

      var jsonData = json.decode(res.body);
      //If user details are fetched successfully
      hospitals = jsonData;
      isLoading.value = false;
      update();
    } catch (e) {
      ErrorSnackBar(textMsg: e.toString()).show(Get.context as BuildContext);
    }
  }

  // ignore: non_constant_identifier_names
  Future<void> FetchHospitalbyId(String id) async {
    try {
      isLoading.value = true;
      http.Response res = await http.get(
        Uri.parse(
            'https://nirogbharatbackend.azurewebsites.net/api/getHospital/$id'), // Replace YOUR_SERVER_ADDRESS with the correct server address
        headers: {'Content-Type': 'application/json'},
      );

      var jsonData = json.decode(res.body);
      singleHospital = [jsonData['hospital']];
      isLoading.value = false;
      update();
    } catch (e) {
      ErrorSnackBar(textMsg: e.toString()).show(Get.context as BuildContext);
    }
  }
}
