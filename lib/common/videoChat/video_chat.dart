import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class CallPage extends StatelessWidget {
  // ignore: use_super_parameters
  const CallPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID:
          372572596, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
      appSign:
          '8619ece1f2a8b4c67a2350027375ea7eb0c56cd7738c073b3c490d50e1c9d492', // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
      userID: '123',
      userName: 'Shobhit Mahobia',
      callID: '123456',
      // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
    );
  }
}
