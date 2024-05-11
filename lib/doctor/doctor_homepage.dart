import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:virtual_hospital/doctor/controllers/doctor_controller.dart';
import 'package:virtual_hospital/doctor/create_pres.dart';
import 'package:virtual_hospital/doctor/doctor_profile.dart';
import 'package:virtual_hospital/patient/chat_page.dart';
import 'package:virtual_hospital/patient/controller/patient_controller.dart';

class DoctorHomepage extends StatefulWidget {
  const DoctorHomepage({super.key});

  @override
  State<DoctorHomepage> createState() => _DoctorHomepageState();
}

class _DoctorHomepageState extends State<DoctorHomepage> {

  final DoctorController doctorController = Get.put(DoctorController());
  final PatientController patientController = Get.put(PatientController());
  @override
  void initState() {
    patientController.fetchAllPatient();
    super.initState();
  }

 
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DoctorController>(initState: (state) {
      doctorController.fetchDoctorDetails();
    }, builder: (controller) {
      if (doctorController.isLoading.value) {
        return const Center(
            child: CircularProgressIndicator(
          strokeWidth: 1,
        ));
      } else {
        return Scaffold(
          backgroundColor: const Color.fromARGB(255, 240, 240, 240),
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 240, 240, 240),
            title: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.doctor['firstName'] +
                            ' ' +
                            controller.doctor['lastName'],
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        controller.doctor['specializedField'],
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const ProfilePageDoctor(),
                          transition: Transition.noTransition);
                    },
                    child: const CircleAvatar(
                      radius: 16,
                      // backgroundImage:
                      //     NetworkImage(controller.doctor['profilePicture']),
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Upcoming Schedule',
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'View All',
                        style: GoogleFonts.plusJakartaSans(
                            color: Colors.blue, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 150,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder: (BuildContext context, int index) {
                        //Include Box shadow
                        return Container(
                          padding: const EdgeInsets.all(8),
                          height: 300,
                          width: 250,
                          margin: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.lightBlue
                                      .withOpacity(0.3), // Color of the shadow
                                  spreadRadius:
                                      5, // Spread radius of the shadow
                                  blurRadius: 7, // Blur radius of the shadow
                                  offset: const Offset(
                                      0, 3), // Offset of the shadow
                                ),
                              ],
                              borderRadius: BorderRadius.circular(10),
                              color: index == 0
                                  ? Colors.blueAccent
                                  : Colors.white),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const CircleAvatar(
                                    radius: 18,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        //Patient Name
                                        Text(
                                          'Deependra Patel',
                                          style: GoogleFonts.plusJakartaSans(
                                              color: index == 0
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        //Patient Email
                                        Text(
                                          'deependra@gmail.com',
                                          style: GoogleFonts.plusJakartaSans(
                                              fontSize: 12,
                                              color: index == 0
                                                  ? const Color.fromARGB(
                                                      255, 219, 219, 219)
                                                  : Colors.black),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Tuesday, 9 April 2024',
                                        style: GoogleFonts.plusJakartaSans(
                                            color: index == 0
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: 12),
                                      ),
                                      Text('15:00 - 15:30',
                                          style: GoogleFonts.plusJakartaSans(
                                              color: index == 0
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontSize: 10)),
                                    ],
                                  ),
                                  CircleAvatar(
                                    backgroundColor:
                                        index == 0 ? Colors.white : Colors.blue,
                                    child: Icon(
                                      Icons.video_call_sharp,
                                      color: index == 0
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Recent Patients',
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'View All',
                        style: GoogleFonts.plusJakartaSans(
                            color: Colors.blue, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: GetBuilder<PatientController>(
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
                                            name: controller.allPatients[index]
                                                    ['firstName'] +
                                                ' ' +
                                                controller.allPatients[index]
                                                    ['LastName'],
                                            recevierEmail: controller
                                                .allPatients[index]['Email'],
                                            receiverId:
                                                controller.allPatients[index]
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
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => GeneratePrescription(
                          doctorName: controller.doctor['lastName'] +
                              // ignore: prefer_interpolation_to_compose_strings
                              '${'Dr. ' + controller.doctor['firstName']} ',
                          doctorId: controller.doctor['firstName'],
                        ));
                  },
                  child: Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      color: Colors.lightBlue,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.lightBlue.withOpacity(0.3),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        )
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Text(
                        'Generate Prescription',
                        style: GoogleFonts.plusJakartaSans(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      trailing: const Icon(
                        Icons.note_alt_sharp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.lightBlue,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.lightBlue.withOpacity(0.3),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      )
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: Text(
                      'Patients Notes & History',
                      style: GoogleFonts.plusJakartaSans(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    trailing: const Icon(
                      Icons.history,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    }
    );
  }
}
