import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:virtual_hospital/patient/controller/patient_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailHospital extends StatefulWidget {
  const DetailHospital({super.key, required this.id});
  final String id;

  @override
  State<DetailHospital> createState() => _DetailHospital();
}

class _DetailHospital extends State<DetailHospital> {
  PatientController patientController = Get.put(PatientController());
  @override
  void initState() {
    patientController.singleHospital.clear();
    patientController.FetchHospitalbyId(widget.id);
    super.initState();
  }

  @override
  void dispose() {
    patientController.singleHospital.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PatientController>(
      builder: (controller) {
        if (controller.isLoading.value == true) {
          return const Center(
              child: CircularProgressIndicator(
            strokeWidth: 1,
          ));
        } else {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'Nearby Hospital',
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue,
                    ),
                    child: Image(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          patientController.singleHospital[0]['imageLink']),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: SizedBox(
                    height: 60,
                    width: 250,
                    child: Text(
                      patientController.singleHospital[0]['name'],
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: SizedBox(
                    height: 50,
                    width: 250,
                    child: SingleChildScrollView(
                      child: Text(
                        patientController.singleHospital[0]['description'],
                        style: GoogleFonts.plusJakartaSans(
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  child: SizedBox(
                    height: 50,
                    width: 250,
                    child: Row(
                      children: [
                        Text(
                          'Timing : ',
                          style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          patientController.singleHospital[0]['hours'],
                          style: GoogleFonts.plusJakartaSans(
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  child: SizedBox(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Address : ',
                          style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 240,
                          child: Text(
                            patientController.singleHospital[0]['address'],
                            style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: SizedBox(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Contact Number : ',
                          style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 120,
                          child: Text(
                            patientController.singleHospital[0]['phone'],
                            style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: SizedBox(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Number of bed : ',
                          style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 120,
                          child: Text(
                            patientController.singleHospital[0]['noOfBed'],
                            style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: SizedBox(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Website : ',
                          style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 200,
                          child: GestureDetector(
                            onTap: () async {
                              if (await canLaunchUrl(Uri.parse(patientController
                                  .singleHospital[0]['browserLink']))) {
                                await launchUrl(Uri.parse(patientController
                                    .singleHospital[0]['browserLink']));
                              } else {
                                throw 'Could not launch';
                              }
                            },
                            child: Text(
                              patientController.singleHospital[0]
                                  ['browserLink'],
                              style: GoogleFonts.plusJakartaSans(
                                fontWeight: FontWeight.normal,
                                color: Colors.blue,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
