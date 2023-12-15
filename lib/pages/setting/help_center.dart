import 'package:apptalk/pages/home_page.dart';
import 'package:apptalk/pages/setting/feedback_page.dart';
import 'package:apptalk/pages/setting/contact_us.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class HelpCenter extends StatefulWidget {
    const HelpCenter({super.key});

  @override
  State<HelpCenter> createState() => _HelpCenterState();
}

class _HelpCenterState extends State<HelpCenter> {
  Color myCustomColor = const Color(0xFF00008B);
  Color myTextColor = const Color(0xF6F5F5FF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myCustomColor,
      appBar: AppBar(
        title:  Text(
            "Help",
        style: GoogleFonts.poppins(
          textStyle: TextStyle(
              color: myTextColor,
          fontSize: 25,
          fontWeight: FontWeight.w600),
        ),),
        backgroundColor: Colors.black54,

        leading: IconButton(
          onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomePage()));
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: ListView(
          children: <Widget>[
             Text(
              "Help Center",
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    color: myTextColor,
                    fontSize: 25,
                    fontWeight: FontWeight.w600),
              ),),
            // Card(
            //   child: ListTile(
            //     leading: Icon(Icons.chat_outlined),
            //     title: Text('Help Center'),
            //   ),
            // ),
            // Divider(
            //   color: Colors.white24, // Set the color of the divider
            //   thickness: 2.0, // Set the thickness of the divider
            //   height: 20.0, // Set the height of the divider
            //   indent: 20.0, // Set the left indentation of the divider
            //   endIndent: 20.0, // Set the right indentation of the divider
            // ),
            GestureDetector(
              onTap: () {
                // Navigate to Contact Us Screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ContactUsScreen()
                  ),
                );
                const SizedBox(height: 20);
              },

              child: const Card(
                child: ListTile(
                  title: Text('Contact Us'),
                  trailing: Icon(Icons.arrow_right),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                // Navigate to Contact Us Screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FeedbackPage()),
                );
              },
              child: const Card(
                child: ListTile(
                  title: Text('Send Feedback'),
                  trailing: Icon(Icons.arrow_right),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}