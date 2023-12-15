import 'package:apptalk/pages/setting/help_center.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  Color myCustomColor = const Color(0xFF00008B);
  Color myTextColor = const Color(0xF6F5F5FF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myCustomColor,
      appBar: AppBar(
        title: Text(
            "Help",
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
                color: myTextColor,
                fontSize: 30,
                fontWeight: FontWeight.w600),
          ),),
        backgroundColor: Colors.black54,

        leading: IconButton(
          onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const HelpCenter()));
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
             Text(
              "Contact Us",
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    color: myTextColor,
                    fontSize: 30,
                    fontWeight: FontWeight.w600),
              ),
            ),

            const SizedBox(height: 20,),

            Padding(
              padding:  const EdgeInsets.symmetric(horizontal: 4.0),
              child: TextField(
                decoration: InputDecoration(
                  enabledBorder:  OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),

                  hintText: 'Tell us how we can help',
                  helperMaxLines: 5,
                  prefixIcon: const Icon(
                    Icons.telegram,
                    color: Colors.white,
                  ),
                  fillColor: Colors.deepPurple,
                  filled: true,
                  hintStyle: TextStyle(
                    color:  myTextColor,
                  ),
                  contentPadding: const EdgeInsets.all(90),
                ),
                style: const TextStyle(
                    color: Colors.white), // Text color while typing
              ),
            ),

            const SizedBox(height: 30,),

            // send button
            SizedBox(
              width: 200,
               child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange[700],
                  elevation: 10,
                  shape: const StadiumBorder()
                ),
                  child:  const Text(
                      "SEND",
                  style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
                  ),
                 onPressed: (){
                   // add save input to database function
                   Navigator.pop(context);
                 },
               ),
            ),
          ],
        ),
      ),
    );
  }
}