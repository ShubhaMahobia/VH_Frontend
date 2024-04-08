import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtual_hospital/common/videoChat/video_chat_button.dart';
import 'package:virtual_hospital/doctor/authentication/create_profile_doctor.dart';
import 'package:virtual_hospital/patient/home_page.dart';
import 'package:virtual_hospital/patient/profile_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (value) =>
              controller.selectedIndex.value = value,
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
            NavigationDestination(
                icon: Icon(Icons.search_outlined), label: 'Search'),
            NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
            NavigationDestination(icon: Icon(Icons.settings), label: 'Setting'),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const PatientHomePage(),
    const DummyScreen(),
    const ProfilePage(),
    const CreateProfileDoctor()
  ];
}
