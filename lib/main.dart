import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtual_hospital/common/commonControllers/authentication_controller.dart';
import 'package:virtual_hospital/doctor/doctor_homepage.dart';
import 'package:virtual_hospital/patient/authentication/login_screen.dart';
import 'package:virtual_hospital/firebase_options.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:virtual_hospital/util/footer.dart';
import 'package:virtual_hospital/util/snackbar/error_snackbar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
  configLoading();
}


void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.cubeGrid
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User? user;

  @override
  void initState() {
    user = FirebaseAuth.instance.currentUser;
    user != null ? checkUserType() : () {};
    super.initState();
    
  }

  Future<void> checkUserType() async {
    try {
      final isPatient = await _authenticationController.isUserPatient();
      _authenticationController.isPatient.value = isPatient;
    } catch (e) {
      ErrorSnackBar(textMsg: 'Something Went Wrong')
          .show(Get.context as BuildContext);
    }
}
  final AuthenticationController _authenticationController =
      Get.put(AuthenticationController());



  // This widget is the root of your application.
  @override
Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: user == null
          ? const LoginScreen()
          : Obx(
              () => _authenticationController.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(
                      strokeWidth: 1,
                    ))
                  : _authenticationController.isPatient.value
                      ? const LandingPage()
                      : const DoctorHomepage(),
            ),
      builder: EasyLoading.init(),
    );
  }
}

