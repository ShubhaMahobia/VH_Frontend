import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class BlogPostPage extends StatelessWidget {
  final List<String> urls = [
    'https://artofhealthyliving.com/quick-tips-for-choosing-the-right-doctor-a-comprehensive-guide-to-finding-quality-healthcare-near-you/',
    'https://github.com/ShubhaMahobia/VH_Backend/blob/main/controller/authenticationController.js',
    // Add more URLs as needed
  ];
  final List<String> blogTitle = [
    'QUICK TIPS FOR CHOOSING THE RIGHT DOCTOR.....',
    'HOW TO CHOOSE THE RIGHT DOCTOR FOR YOU',
    // Add more titles as needed
    // Add more URLs as needed
  ];
  final List<String> blogdesc = [
    'Nowadays, seeking a reliable health care provider goes far beyond some local...',
    'Nowadays, seeking a reliable health care provider goes far beyond some local...',
    // Add more titles as needed
    // Add more URLs as needed
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Blog Post',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: 2,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () async {
                String url = urls[index];
                if (await canLaunchUrl(Uri.parse(url))) {
                  await launchUrl(Uri.parse(url));
                } else {
                  throw 'Could not launch $url';
                }
              },
              child: Container(
                height: 150,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      // Add more styling as needed
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            blogTitle[index],
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            blogdesc[index],
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
