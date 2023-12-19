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
        backgroundColor: Colors.black54,
        title: Text(
          "Help",
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
                color: myTextColor,
                fontSize: 28,
                fontWeight: FontWeight.w600),
          ),),
        leading: IconButton(
          onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage())
            );
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),

      body: Container(
      padding: const EdgeInsets.all(18),
      child:  ListView(
          children: [
            const SizedBox(height: 40,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(
                  Icons.live_help_rounded,
                  color: Colors.white,
                ),
                const SizedBox(width: 10,height: 30,),
                Text(
                  "Help Center",
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: myTextColor,
                        fontSize: 25,
                        fontWeight: FontWeight.w600),
                  ),),
              ],
            ),
            const Divider(
              color: Colors.white,
              height: 40,
              thickness: 4,
            ),
            const SizedBox(height: 20,),
            buildAccountOption(context, "Contact Us"),
            const SizedBox(height: 20,),
            buildFeedbackOption(context, "Send Feedback"),
          ],
        ),
      ),
    );
  }

  GestureDetector buildAccountOption(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const ContactUsScreen()),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: GoogleFonts.aBeeZee(
                textStyle: TextStyle(
                  fontSize: 20,
                  color: myTextColor,
                  fontWeight: FontWeight.bold,
                ),),),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

    GestureDetector buildFeedbackOption(BuildContext context, String title) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const FeedbackPage()),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: GoogleFonts.aBeeZee(
                  textStyle: TextStyle(
                    fontSize: 20,
                    color: myTextColor,
                    fontWeight: FontWeight.bold,
                  ),),),
              const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white)
            ],
          ),
        ),
      );
  }
}
