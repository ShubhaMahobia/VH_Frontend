import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:virtual_hospital/doctor/create_pres.dart';
import 'package:virtual_hospital/patient/blog_post.dart';
import 'package:virtual_hospital/patient/bookAppointment/book_appointment_all_doctor.dart';
import 'package:virtual_hospital/patient/controller/patient_controller.dart';
import 'package:virtual_hospital/patient/nearby_hospital.dart';
import 'package:virtual_hospital/patient/profile_page.dart';


class PatientHomePage extends StatefulWidget {
  const PatientHomePage({super.key});

  @override
  State<PatientHomePage> createState() => _PatientHomePageState();
}

class _PatientHomePageState extends State<PatientHomePage> {
  PatientController patientController = Get.put(PatientController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PatientController>(
      initState: (state) => {
        patientController.fetchUserDetails(),
        patientController.fetchAllDoctors(),
      },
      builder: (controller) {
        if (controller.isUserDataLoading.value || controller.isLoading.value) {
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
                          patientController.user['firstName'],
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          patientController.user['Email'],
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                    const CircleAvatar(
                      radius: 20,
                      child: Image(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              'https://static.vecteezy.com/system/resources/thumbnails/002/002/403/small/man-with-beard-avatar-character-isolated-icon-free-vector.jpg')),
                      // backgroundImage: NetworkImage('url'),
                    ),
                  ],
                ),
              ),
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    SizedBox(
                      height: 120,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.to(
                                      () => const BookAppointmentAllDoctor());
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.blue,
                                  ),
                                  height: 50,
                                  width: 50,
                                  child: const Icon(
                                    Icons.book,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: 100,
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    'Book Appointment',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Colors.blue,
                                ),
                                height: 50,
                                width: 50,
                                child: const Icon(
                                  Icons.health_and_safety,
                                  color: Colors.white,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: 100,
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    'Diseases Prediction',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => const NearbyHospital());
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.blue,
                                  ),
                                  height: 50,
                                  width: 50,
                                  child: const Center(
                                    child: Icon(
                                      Icons.location_pin,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: 100,
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    'Nearby Hospitals',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Available Doctors',
                            style: GoogleFonts.plusJakartaSans(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          GestureDetector(
                            onTap: () =>
                                Get.to(() => const BookAppointmentAllDoctor()),
                            child: Text(
                              'View All',
                              style: GoogleFonts.plusJakartaSans(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 150,
                        child: GetBuilder<PatientController>(
                          builder: (patientController) {
                            if (patientController.isLoading.value) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              return ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: patientController.allDoctors.length,
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
                                          color:
                                              Colors.lightBlue.withOpacity(0.3),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(10),
                                      color: index == 0
                                          ? Colors.blueAccent
                                          : Colors.white,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            const CircleAvatar(
                                              // backgroundImage: NetworkImage(
                                              //   // patientController
                                              //   //         .allDoctors[index]
                                              //   //     ['profilePicture'],
                                              // ),
                                              radius: 18,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Dr ${controller.allDoctors[index]['firstName']} ${controller.allDoctors[index]['lastName']}',
                                                    style: GoogleFonts
                                                        .plusJakartaSans(
                                                      color: index == 0
                                                          ? Colors.white
                                                          : Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  Text(
                                                    patientController
                                                        .allDoctors[index]
                                                            ['specializedField']
                                                        .toString(),
                                                    style: GoogleFonts
                                                        .plusJakartaSans(
                                                      fontSize: 12,
                                                      color: index == 0
                                                          ? const Color
                                                              .fromARGB(255,
                                                              219, 219, 219)
                                                          : Colors.black,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
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
                                                  '15',
                                                  style: GoogleFonts
                                                      .plusJakartaSans(
                                                    color: index == 0
                                                        ? Colors.white
                                                        : Colors.black,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                Text(
                                                  controller.allDoctors[index]
                                                      ['degree'],
                                                  style: GoogleFonts
                                                      .plusJakartaSans(
                                                    color: index == 0
                                                        ? Colors.white
                                                        : Colors.black,
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Get.to(
                                                  () => GeneratePrescription(
                                                    doctorName:
                                                        "${controller.allDoctors[index]['firstName']}  ${controller.allDoctors[index]['LastName']}",
                                                    doctorId: controller
                                                            .allDoctors[index]
                                                        ['_id'],
                                                  ),
                                                  transition:
                                                      Transition.noTransition,
                                                );
                                              },
                                              child: CircleAvatar(
                                                backgroundColor: index == 0
                                                    ? Colors.white
                                                    : Colors.blue,
                                                child: Icon(
                                                  Icons.add,
                                                  color: index == 0
                                                      ? Colors.black
                                                      : Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Text(
                            'Welcome ${patientController.user['firstName']}',
                            style: GoogleFonts.plusJakartaSans(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() => BlogPostPage(),
                              transition: Transition.noTransition);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          height: 60,
                          width: 300,
                          child: ListTile(
                            leading: const Icon(
                              Icons.post_add,
                              color: Colors.blue,
                            ),
                            title: Text(
                              'Healthy Learnings',
                              style: GoogleFonts.plusJakartaSans(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            trailing: const Icon(Icons.menu),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() => const ProfilePage(),
                              transition: Transition.noTransition);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          height: 60,
                          width: 300,
                          child: ListTile(
                            leading: const Icon(
                              Icons.update,
                              color: Colors.blue,
                            ),
                            title: Text(
                              'Update Profile',
                              style: GoogleFonts.plusJakartaSans(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            trailing: const Icon(Icons.menu),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'My Reports',
                            style: GoogleFonts.plusJakartaSans(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'View All',
                            style: GoogleFonts.plusJakartaSans(
                                color: Colors.blue,
                                fontWeight: FontWeight.w600),
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
                          itemCount: 2,
                          itemBuilder: (BuildContext context, int index) {
                            //Include Box shadow
                            return Container(
                              padding: const EdgeInsets.all(8),
                              height: 300,
                              width: 250,
                              margin: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      const CircleAvatar(
                                        backgroundColor:
                                            Color.fromARGB(255, 127, 245, 235),
                                        radius: 28,
                                        child: Icon(Icons.copy),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: GestureDetector(
                                          onTap: () {},
                                          child: Column(
                                            children: [
                                              //Patient Name
                                              Text(
                                                index == 0
                                                    ? 'Prescriptions'
                                                    : 'Lab Reports',
                                                style:
                                                    GoogleFonts.plusJakartaSans(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
                                              ),
                                              //Patient Email
                                              Text(
                                                'view now',
                                                style:
                                                    GoogleFonts.plusJakartaSans(
                                                  fontSize: 12,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
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
            ),
    );
        }
      },
    );
  }
}
  
