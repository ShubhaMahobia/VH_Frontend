import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:virtual_hospital/patient/controller/patient_controller.dart';
import 'package:virtual_hospital/patient/detail_hospital.dart';
import 'package:geolocator/geolocator.dart';

class NearbyHospital extends StatefulWidget {
  const NearbyHospital({super.key});

  @override
  State<NearbyHospital> createState() => _NearbyHospital();
}

class _NearbyHospital extends State<NearbyHospital> {
  TextEditingController _searchController = TextEditingController();
  PatientController patientController = Get.put(PatientController());
  bool _isLoading = true;

  @override
  void initState() {
    patientController.fetchAllHospital();
    super.initState();
  }

  void findingNearbyHospital() async {
    patientController.isLoading.value = true;
    setState(() {
      patientController.lat.value = "23.1826";
      patientController.long.value = "77.3015";
    });
    _getLocation();
    patientController.fetchAllHospital();
  }

  Future<void> _getLocation() async {
    // LocationPermission permission = await Geolocator.checkPermission();
    // if (permission == LocationPermission.denied) {
    //   permission = await Geolocator.requestPermission();
    //   if (permission == LocationPermission.denied) {
    //     // Handle the scenario where user denies permission
    //     return;
    //   }
    // }
    // if (permission == LocationPermission.deniedForever) {
    //   // Permissions are denied forever, handle appropriately.
    //   return;
    // }

    // Position position = await Geolocator.getCurrentPosition(
    //     desiredAccuracy: LocationAccuracy.bestForNavigation);
  }

  @override
  void dispose() {
    patientController.hospitals.clear();
    patientController.lat.value = "";
    patientController.long.value = "";
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Nearby Hospital',
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.5,
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
                        GestureDetector(
                          onTap: () {
                            findingNearbyHospital();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Center(
                              child: Text(
                                'Near Me',
                                style: GoogleFonts.plusJakartaSans(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        child: ListView.builder(
                            itemCount: patientController.hospitals.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Get.to(
                                        () => DetailHospital(
                                              id: patientController
                                                  .hospitals[index]['_id'],
                                            ),
                                        transition: Transition.noTransition);
                                  },
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
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              height: 100,
                                              width: 100,
                                              child: Image(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    patientController
                                                            .hospitals[index]
                                                        ['imageLink']),
                                              ),
                                            ),
                                            Container(
                                              width: 10,
                                            ),
                                            SizedBox(
                                              height: 40,
                                              width: 140,
                                              child: Text(
                                                patientController
                                                    .hospitals[index]['name'],
                                                style:
                                                    GoogleFonts.plusJakartaSans(
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                            ),
                                            const Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              size: 16,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
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
