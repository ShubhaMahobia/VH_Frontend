import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class DoctorHomepage extends StatefulWidget {
  const DoctorHomepage({super.key});

  @override
  State<DoctorHomepage> createState() => _DoctorHomepageState();
}

class _DoctorHomepageState extends State<DoctorHomepage> {
  @override
  Widget build(BuildContext context) {
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
                    'Shubham Mahobia',
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Nuerologist',
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              const CircleAvatar(
                radius: 16,
                backgroundImage: NetworkImage('url'),
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
                  itemCount: 5,
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
                              spreadRadius: 5, // Spread radius of the shadow
                              blurRadius: 7, // Blur radius of the shadow
                              offset: Offset(0, 3), // Offset of the shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10),
                          color: index == 0 ? Colors.blueAccent : Colors.white),
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
                                              : Colors.black
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                  color:
                                      index == 0 ? Colors.black : Colors.white,
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
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text(
                    'Welcome Shubham',
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
                    'Update Availablity',
                    style: GoogleFonts.plusJakartaSans(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  trailing: const Icon(Icons.menu),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
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
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  trailing: const Icon(Icons.menu),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
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
              child: SizedBox(
                height: 150,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              const CircleAvatar(
                                backgroundColor:
                                    Color.fromARGB(255, 127, 245, 235),
                                radius: 28,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    //Patient Name
                                    Text(
                                      'Deependra Patel',
                                      style: GoogleFonts.plusJakartaSans(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    //Patient Email
                                    Text(
                                      'deependra@gmail.com',
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
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
    );
  }
}
