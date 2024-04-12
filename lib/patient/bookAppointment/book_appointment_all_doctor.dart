import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:virtual_hospital/patient/bookAppointment/book_appointment_doctor_detail.dart';
import 'package:virtual_hospital/patient/controller/patient_controller.dart';
import 'package:virtual_hospital/patient/profile_page.dart';


class BookAppointmentAllDoctor extends StatefulWidget {
  const BookAppointmentAllDoctor({super.key});

  @override
  State<BookAppointmentAllDoctor> createState() => _BookAppointmentAllDoctor();
}

class _BookAppointmentAllDoctor extends State<BookAppointmentAllDoctor> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Book Appointment',
            style: GoogleFonts.plusJakartaSans(
                fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        body: GetBuilder<PatientController>(
          builder: (controller) {
            if (controller.isLoading.value) {
              return const Center(
                  child: CircularProgressIndicator(
                strokeWidth: 1,
              ));
            } else {
              List<dynamic> filteredDoctors =
                  controller.allDoctors.where((doctor) {
                String firstName = doctor['firstName'].toLowerCase();
                String searchTerm = _searchController.text.toLowerCase();
                return firstName.contains(searchTerm);
              }).toList();
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          controller: _searchController,
                          onChanged: (value) {
                            setState(() {});
                          },
                          style: GoogleFonts.plusJakartaSans(),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: const Icon(Icons.search),
                            hintText: 'Search',
                            hintStyle: GoogleFonts.plusJakartaSans(),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: ListView.builder(
                            itemCount: filteredDoctors.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    height: 120,
                                    width: 250,
                                    margin: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(
                                                0.3), // Color of the shadow
                                            spreadRadius:
                                                5, // Spread radius of the shadow
                                            blurRadius:
                                                7, // Blur radius of the shadow
                                            offset: const Offset(
                                                0, 3), // Offset of the shadow
                                          ),
                                        ],
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  patientController
                                                          .allDoctors[index]
                                                      ['profilePicture']),
                                              radius: 25,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  //Patient Name
                                                  Text(
                                                    'Dr ${filteredDoctors[index]['firstName']} ${filteredDoctors[index]['LastName']}',
                                                    style: GoogleFonts
                                                        .plusJakartaSans(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16),
                                                  ),
                                                  //Patient Email
                                                  Text(
                                                    filteredDoctors[index]
                                                            ['SpecializedField']
                                                        .toString(),
                                                    style: GoogleFonts
                                                        .plusJakartaSans(
                                                            fontSize: 12,
                                                            color:
                                                                Colors.black),
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
                                                  filteredDoctors[index]
                                                      ['Experience'],
                                                  style: GoogleFonts
                                                      .plusJakartaSans(
                                                          color: Colors.black,
                                                          fontSize: 12),
                                                ),
                                                Text(
                                                    filteredDoctors[index]
                                                        ['degree'],
                                                    style: GoogleFonts
                                                        .plusJakartaSans(
                                                            color: Colors.black,
                                                            fontSize: 10)),
                                              ],
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Get.to(
                                                  () => const DoctorDetail(),
                                                  transition:
                                                      Transition.noTransition,
                                                );
                                              },
                                              child: const CircleAvatar(
                                                backgroundColor: Colors.blue,
                                                child: Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ));
                            }),
                      ),
                    )
                  ],
                ),
              );
            }
          },
        ));
  }
}
