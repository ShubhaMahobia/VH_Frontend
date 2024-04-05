import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class BlogPostPage extends StatelessWidget {
  final List<String> urls = [
    'https://artofhealthyliving.com/quick-tips-for-choosing-the-right-doctor-a-comprehensive-guide-to-finding-quality-healthcare-near-you/',
    'https://medium.com/@ryanholiday/you-need-this-practice-in-your-life-fc30cfe1bb21',
    'https://medium.com/@pinkey23/the-importance-of-mental-health-in-the-workplace-288d89cc1291',
    'https://elemental.medium.com/how-soft-fascination-helps-restore-your-tired-brain-27669cd0be9d',
    'https://medium.com/@info_53109/make-sleep-a-priority-2c50f97e640d',
    'https://medium.com/@info_53109/the-role-of-vitamin-c-edbff5bf56fe',
    'https://medium.com/in-fitness-and-in-health/beginner-ironman-training-a-minimalist-approach-nutrition-for-training-7a416a7b1c4d'
    // Add more URLs as needed
  ];
  final List<String> blogTitle = [
    'Quick tips for choosing the right doctor...',
    'You Need This Practice In Your Life...',
    'The Importance of Mental Health in the Workplace...',
    'How Soft Fascination Helps Restore Your Tired Brain...',
    '6 Science-Backed Health Stories on COVID, Sleep, and More...',
    'Make Sleep a Priority...',
    'The Role of Vitamin C...',
    // Add more titles as needed
    // Add more URLs as needed
  ];
  final List<String> imageLinks = [
    'https://artofhealthyliving.com/wp-content/uploads/2024/04/Quick-Tips-For-Choosing-The-Right-Doctor-A-Comprehensive-Guide-To-Finding-Quality-Healthcare-Near-You.jpg',
    'https://miro.medium.com/v2/resize:fit:828/format:webp/1*w61xFQGpNIskzh0eerzg2w.jpeg',
    'https://miro.medium.com/v2/resize:fit:828/format:webp/1*a3rQzrAcrByUEc-7L-4avg.jpeg',
    'https://miro.medium.com/v2/resize:fit:828/format:webp/0*w2HyM6O58GADbmVt.jpg',
    'https://miro.medium.com/v2/resize:fit:828/format:webp/1*intQ8N7ar0VZFhvXzSbNrw.png',
    'https://miro.medium.com/v2/resize:fit:828/format:webp/1*HbPhhMZ_uzZ62Bo2jxZlKQ.png',
    'https://miro.medium.com/v2/resize:fit:828/format:webp/0*nlwReEu55uUpGqad',
    // Add more titles as needed
    // Add more URLs as needed
  ];

  BlogPostPage({super.key});
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
          itemCount: 7,
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
                height: 250,
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
                  padding: const EdgeInsets.all(8),
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
                          Container(
                            height: 125,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage(imageLinks[index])
                                      as ImageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              //Image will be added after the blog post is ready for now we are using the container-
                              // Image(
                              //   image: AssetImage('assets/images/test.png'),
                              // ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            blogTitle[index],
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Archi Kirar',
                                  style:
                                      GoogleFonts.plusJakartaSans(fontSize: 12),
                                ),
                                Text(
                                  'Date - 30/11/2003',
                                  style:
                                      GoogleFonts.plusJakartaSans(fontSize: 12),
                                )
                              ],
                            ),
                          )
                          
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
