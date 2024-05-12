import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:virtual_hospital/patient/chat_page.dart';
import 'package:virtual_hospital/patient/controller/patient_controller.dart';

class AllPatients extends StatefulWidget {
  const AllPatients({super.key});

  @override
  State<AllPatients> createState() => _AllPatientsState();
}

class _AllPatientsState extends State<AllPatients> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Patients'),
      ),
      body: GetBuilder<PatientController>(
        builder: (controller) {
          var item = controller.allPatients;
          return ListView.builder(
            shrinkWrap: true,
            itemCount: item.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                trailing: GestureDetector(
                    onTap: () {
                      Get.to(
                          () => ChatPage(
                              name: controller.allPatients[index]['firstName'] +
                                  ' ' +
                                  controller.allPatients[index]['LastName'],
                              recevierEmail: controller.allPatients[index]
                                  ['Email'],
                              receiverId: controller.allPatients[index]
                                  ['firebaseUserId']),
                          transition: Transition.noTransition);
                    },
                    child: const Icon(Icons.chat_outlined)),
                title: Text(
                  controller.allPatients[index]['firstName'] +
                      ' ' +
                      controller.allPatients[index]['LastName'],
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  controller.allPatients[index]['Email'],
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
