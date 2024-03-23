import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PatientHomePage extends StatelessWidget {
  const PatientHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            // Image.asset('assets/icons/location.png'),
            const Icon(
              size: 30,
              Icons.pin_drop_sharp,
              color: Colors.blue,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Current Location',
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 12, color: Colors.grey),
                  ),
                  Text(
                    'Oriental College',
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: 700,
          width: MediaQuery.of(context).size.width,
          child: Column(
            //Search Bar
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(10)),
                  height: 140,
                  width: MediaQuery.of(context).size.width * 0.9,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(10)),
                      height: 140,
                      width: MediaQuery.of(context).size.width * 0.42,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(10)),
                      height: 140,
                      width: MediaQuery.of(context).size.width * 0.42,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(10)),
                  height: 100,
                  width: MediaQuery.of(context).size.width * 0.9,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Availabe Doctors',
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'View all',
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 120,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 100,
                        width: 150,
                        margin: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blueAccent),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 70,
        color: Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 40,
              width: 40,
              color: Colors.white,
            ),
            Container(
              height: 40,
              width: 40,
              color: Colors.white,
            ),
            Container(
              height: 40,
              width: 40,
              color: Colors.white,
            ),
            Container(
              height: 40,
              width: 40,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
