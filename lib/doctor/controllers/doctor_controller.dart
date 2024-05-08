import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtual_hospital/common/commonControllers/authentication_controller.dart';
import 'package:virtual_hospital/doctor/authentication/create_profile_doctor.dart';
import 'package:virtual_hospital/doctor/doctor_homepage.dart';
import 'package:virtual_hospital/doctor/doctor_profile.dart';
import 'package:virtual_hospital/services/firebase_auth_services.dart';
import 'package:virtual_hospital/util/snackbar/error_snackbar.dart';
import 'package:http/http.dart' as http;
import 'package:pdf/widgets.dart' as pw;
import 'package:virtual_hospital/util/snackbar/success_snackbar.dart';
import 'package:path_provider/path_provider.dart';

class DoctorController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController specificationController = TextEditingController();
  TextEditingController experienceController = TextEditingController();
  TextEditingController qualificationController = TextEditingController();
  TextEditingController clinicAddressController = TextEditingController();
  TextEditingController imageLinkController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController startHourController = TextEditingController();
  TextEditingController endHourController = TextEditingController();

  List<int> daysAvailable = [];
  final FirebaseAuthService _authService = FirebaseAuthService();
  final AuthenticationController _authenticationController =
      Get.put(AuthenticationController());

  var doctor = {};
  RxBool isLoading = true.obs;
  List<bool> selectedDays = [false, false, false, false, false, false];
  List<String> dayNames = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday'
  ];
  void signUpDoctor() async {
    try {
      if (emailController.text.isEmpty) {
        ErrorSnackBar(textMsg: 'Email is required')
            .show(Get.context as BuildContext);
        return;
      }
      if (passwordController.text.isEmpty) {
        ErrorSnackBar(textMsg: 'Password is required')
            .show(Get.context as BuildContext);
        return;
      }
      EasyLoading.show(status: 'Loading');
      String email = emailController.text;
      String password = passwordController.text;
      User? user =
          await _authService.signUpWithEmailAndPassword(email, password);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('userId', user?.uid as String);
      EasyLoading.dismiss();
      SuccessSnackbar(textMsg: 'Account created successfully')
          .show(Get.context as BuildContext);
      await Future.delayed(const Duration(seconds: 1))
          .then((value) => Get.to(() => const CreateProfileDoctor()));
    } catch (e) {
      EasyLoading.dismiss();
    }
  }

  void signInDoctor() async {
    _authenticationController.isPatient.value = false;
    String email = emailController.text;
    String password = passwordController.text;
    try {
      if (emailController.text.isEmpty) {
        ErrorSnackBar(textMsg: 'Email is required')
            .show(Get.context as BuildContext);
        return;
      }
      if (passwordController.text.isEmpty) {
        ErrorSnackBar(textMsg: 'Password is required')
            .show(Get.context as BuildContext);
        return;
      }
      EasyLoading.show(status: 'Loading...');
      User? user =
          await _authService.signInWithEmailAndPassword(email, password);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(
        'userId',
        user?.uid as String,
      );
      String body = json.encode({
        "firebaseUserId": FirebaseAuth.instance.currentUser!.uid,
      });
      http.Response res = await http.post(
        Uri.parse(
            'https://nirogbharatbackend.azurewebsites.net/api/isDoctorExist'), // Replace YOUR_SERVER_ADDRESS with the correct server address
        headers: {'Content-Type': 'application/json'},
        body: body,
      );
      var jsonData = json.decode(res.body);
      if (jsonData['success'] == true) {
        if (jsonData['isPresent'] == true) {
          EasyLoading.dismiss();
          SuccessSnackbar(textMsg: 'Login successful')
              .show(Get.context as BuildContext);
          await Future.delayed(const Duration(seconds: 1))
              .then((value) => Get.to(() => const DoctorHomepage()));
        } else {
          EasyLoading.dismiss();
          ErrorSnackBar(textMsg: 'User does not exist, Login Failed')
              .show(Get.context as BuildContext);
        }
      }
    } catch (e) {
      EasyLoading.dismiss();
    }
  }

  void createDoctorProfile() async {
    //Get the values from the text editing controllers
    String firstName = firstNameController.text;
    String lastName = lastNameController.text;
    String phoneNumber = phoneNumberController.text;
    String specification = specificationController.text;
    String experience = experienceController.text;
    String qualification = qualificationController.text;
    String clinicAddress = clinicAddressController.text;
    String startHour = startHourController.text;
    String endHour = endHourController.text;
    String bio = bioController.text;

    //Check if the fields are empty
    if (emailController.text.isEmpty) {
      ErrorSnackBar(textMsg: 'Email is required')
          .show(Get.context as BuildContext);
      return;
    }
    if (firstName.isEmpty) {
      ErrorSnackBar(textMsg: 'First Name is required')
          .show(Get.context as BuildContext);
      return;
    } else if (lastName.isEmpty) {
      ErrorSnackBar(textMsg: 'Last Name is required')
          .show(Get.context as BuildContext);
      return;
    } else if (phoneNumber.isEmpty) {
      ErrorSnackBar(textMsg: 'Phone Number is required')
          .show(Get.context as BuildContext);
      return;
    } else if (specification.isEmpty) {
      ErrorSnackBar(textMsg: 'Specialization is required')
          .show(Get.context as BuildContext);
      return;
    } else if (experience.isEmpty) {
      ErrorSnackBar(textMsg: 'Experience is required')
          .show(Get.context as BuildContext);
      return;
    } else if (qualification.isEmpty) {
      ErrorSnackBar(textMsg: 'Qualification is required')
          .show(Get.context as BuildContext);
      return;
    } else if (clinicAddress.isEmpty) {
      ErrorSnackBar(textMsg: 'Clinic Address is required')
          .show(Get.context as BuildContext);
      return;
    } else if (startHour.toString().isEmpty) {
      ErrorSnackBar(textMsg: 'Please enter your availablity')
          .show(Get.context as BuildContext);
      return;
    } else if (endHour.toString().isEmpty) {
      ErrorSnackBar(textMsg: 'Please enter your availablity')
          .show(Get.context as BuildContext);
      return;
    } else if (bio.isEmpty) {
      ErrorSnackBar(textMsg: 'Please tell us about yourself')
          .show(Get.context as BuildContext);
      return;
    } else {
      try {
        EasyLoading.show(status: 'Loading...');
        Map<String, bool> daysMap = Map.fromIterables(dayNames, selectedDays);
        String body = json.encode({
          "firebaseUserId": FirebaseAuth.instance.currentUser?.uid,
          "firstName": firstName,
          "lastName": lastName,
          "email": emailController.text,
          "phoneNumber": phoneNumberController.text,
          "experience": experienceController.text,
          "startTimeHour": startHour,
          "endTimeHour": endHour,
          "gender": _authenticationController.genderController.text,
          "profilePicture": imageLinkController.text,
          "address": clinicAddressController.text,
          "specializedField": specification,
          "degree": qualification,
          "breifDescription": bio,
          "daysAvailable": daysMap,
        });
        http.Response res = await http.post(
          Uri.parse(
              'https://nirogbharatbackend.azurewebsites.net/api/registerDoctor'), // Replace YOUR_SERVER_ADDRESS with the correct server address
          headers: {'Content-Type': 'application/json'},
          body: body,
        );

        var jsonData = json.decode(res.body);
        if (jsonData['success']) {
          _authenticationController.isPatient.value = false;
          EasyLoading.dismiss();
          SuccessSnackbar(
            textMsg: 'Profile Created Successfully',
          ).show(Get.context as BuildContext);
          await Future.delayed(const Duration(seconds: 1))
              .then((value) => Get.to(() => const DoctorHomepage()));
        } else {
          EasyLoading.dismiss();
          ErrorSnackBar(
            textMsg: jsonData['message'],
          ).show(Get.context as BuildContext);
        }
      } catch (e) {
        EasyLoading.dismiss();

        ErrorSnackBar(
          textMsg: 'Something Went Wrong',
        ).show(Get.context as BuildContext);
      }
    }
  }

  Future<void> fetchDoctorDetails() async {
    //API call to fetch user details
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getString('userId');
      String body = jsonEncode({
        "id": userId,
      });
      http.Response res = await http.post(
        Uri.parse(
            'https://nirogbharatbackend.azurewebsites.net/api/getDoctor'), // Replace YOUR_SERVER_ADDRESS with the correct server address
        headers: {'Content-Type': 'application/json'},
        body: body,
      );
      var jsonData = json.decode(res.body);
      if (jsonData['success']) {
        prefs.setString('userType', jsonData['data']['userType']);
        //If user details are fetched successfully
        doctor = jsonData['data'];
        isLoading.value = false;
        update();
      } else {
        ErrorSnackBar(
          textMsg: jsonData['message'],
        ).show(Get.context as BuildContext);
      }
    } catch (e) {
      ErrorSnackBar(textMsg: e.toString()).show(Get.context as BuildContext);
    }
  }

  Future<void> generateSendPrescription(
      String docId, String patientId, String title, String description) async {
    EasyLoading.show(status: 'Loading...');
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: pw.Text(description),
        ),
      ),
    );

    // Save PDF locally
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/prescription.pdf');
    await file.writeAsBytes(await pdf.save());

    // Upload PDF to Firebase Storage
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('prescriptions')
        .child('prescription.pdf');
    storageRef.putFile(file);
    final downloadURL = await storageRef.getDownloadURL();
    try {
      String body = jsonEncode({
        "doctorId": docId,
        "patientId": patientId,
        "documentId": "451684",
        "date": "10/04/2024",
        "title": title,
        "description": description,
        "documentLink": downloadURL,
      });
      http.Response res = await http.post(
        Uri.parse(
            'https://nirogbharatbackend.azurewebsites.net/api/generatePrescription'), // Replace YOUR_SERVER_ADDRESS with the correct server address
        headers: {'Content-Type': 'application/json'},
        body: body,
      );
      var jsonData = json.decode(res.body);
      if (jsonData['success']) {
        EasyLoading.dismiss();
        SuccessSnackbar(textMsg: 'Prescription Sent Successfully')
            .show(Get.context as BuildContext);
        isLoading.value = false;
        update();
      } else {
        EasyLoading.dismiss();
        ErrorSnackBar(
          textMsg: 'Internal Server Error',
        ).show(Get.context as BuildContext);
      }
    } catch (e) {
      EasyLoading.dismiss();
      ErrorSnackBar(textMsg: e.toString()).show(Get.context as BuildContext);
    }
  }
}
