import 'package:apptalk/pages/home_page.dart';
import 'package:apptalk/pages/setting/contact_us.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'feedback_page.dart'; // Import the FeedbackPage file

class HelpCenter extends StatefulWidget {
  const HelpCenter({Key? key}) : super(key: key);

  @override
  _HelpCenterState createState() => _HelpCenterState();
}

class _HelpCenterState extends State<HelpCenter> {
  Color myCustomColor = const Color(0xFF00008B);
  Color myTextColor = const Color(0xF6F5F5FF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myCustomColor,
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text(
          "Help",
          style: GoogleFonts.aBeeZee(
            fontSize: 25,
            color: myTextColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            SizedBox(height: 40),
            Row(
              children: [
                Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                SizedBox(width: 10),
                Text(
                  "Help Center",
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 25,
                      color: myTextColor,
                      fontWeight: FontWeight.bold,
                    ),),)
              ],
            ),
            Divider(height: 20, thickness: 1),
            SizedBox(height: 10),
            buildHelpOption(context, "Contact Us"),
            buildHelpOption(context, "Send Feedback"),
            // Other help options...
          ],
        ),
      ),
    );
  }

  GestureDetector buildHelpOption(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        if (title == "Contact Us") {
          // Navigate to ContactUsScreen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ContactUsScreen()),
          );
        } else if (title == "Send Feedback") {
          // Navigate to FeedbackPage
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FeedbackPage()),
          );
        }
        // Add navigation for other options if needed
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
              style: GoogleFonts.aBeeZee(
                textStyle: TextStyle(
                  fontSize: 20,
                  color: myTextColor,
                  fontWeight: FontWeight.bold,
                ),),),
            const Icon(Icons.arrow_forward_ios, color: Colors.grey)
          ],
        ),
      ),
    );
  }
}
