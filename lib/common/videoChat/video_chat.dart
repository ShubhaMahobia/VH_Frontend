import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtual_hospital/patient/controller/patient_controller.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class CallPage extends StatefulWidget {
  // ignore: use_super_parameters
  const CallPage({Key? key, required this.userName, required this.callId})
      : super(key: key);
  final String userName;
  final String callId;

  @override
  State<CallPage> createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  PatientController patientController = Get.put(PatientController());

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID:
          372572596, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
      appSign:
          '8619ece1f2a8b4c67a2350027375ea7eb0c56cd7738c073b3c490d50e1c9d492', // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
      userID: patientController.user['_id'],
      userName: widget.userName,
      callID: widget.callId,
      // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
    );
  }
}
