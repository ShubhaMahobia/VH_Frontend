import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtual_hospital/common/videoChat/video_chat.dart';

class DummyScreen extends StatelessWidget {
  const DummyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text('Start Video Chat'),
          onPressed: () {
            Get.to(() => const CallPage());
          },
        ),
      ),
    );
  }
}
