import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:virtual_hospital/doctor/controllers/doctor_controller.dart';
import 'package:virtual_hospital/doctor/doctor_profile.dart';

class DoctorHomepage extends StatefulWidget {
  const DoctorHomepage({super.key});

  @override
  State<DoctorHomepage> createState() => _DoctorHomepageState();
}

class _DoctorHomepageState extends State<DoctorHomepage> {

  final DoctorController doctorController = Get.put(DoctorController());

 
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DoctorController>(initState: (state) {
      doctorController.fetchDoctorDetails();
    }, builder: (controller) {
      if (doctorController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
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
                    child: CircleAvatar(
                      radius: 16,
                      backgroundImage:
                          NetworkImage(controller.doctor['profilePicture']),
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
              ],
            ),
          ),
        );
      }
    }
    );
  }
}
