import 'package:apptalk/pages/home_page.dart';
import 'package:apptalk/pages/setting/help_center.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackPage> {
  Color myCustomColor = const Color(0xFF00008B);
  Color myTextColor = const Color(0xF6F5F5FF);
  int _rating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myCustomColor,
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title:  Text(
            "Feedback",
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
                color: myTextColor,
                fontSize: 25,
                fontWeight: FontWeight.w600),
          ),),

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
              "Rate Your Experience",
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    color: myTextColor,
                    fontSize: 30,
                    fontWeight: FontWeight.w600),
              ),
            ),
             const SizedBox(height: 10,),

             Text(
              "Are you Satisfied with the Application?",
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    color: myTextColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
            ),

            const SizedBox(height: 10,),

            buildStar(),
            const Divider(
              color: Colors.white, // Set the color of the divider
              thickness: 2.0, // Set the thickness of the divider
              height: 20.0, // Set the height of the divider
              indent: 20.0, // Set the left indentation of the divider
              endIndent: 20.0, // Set the right indentation of the divider
            ),

            const SizedBox(height: 20,),

             Text(
              "Tell us what can be Improved?",
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: myTextColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
            ),

            const SizedBox(height: 20,),

             Padding(
              padding:  const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextField(
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),

                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),

                  ),
                  hintText: 'Feedback',
                  prefixIcon: const Icon(
                    Icons.telegram,
                    color: Colors.white,),
                  fillColor: Colors.deepPurple,
                  filled: true,
                  hintStyle: TextStyle(
                    color:  myTextColor,
                  ),
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
                  buildSuccessPage();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  HomePage(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStar() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return GestureDetector(
          onTap: () {
            // Handle the star tap
            setState(() {
              _rating = index + 1;
            });
          },
          child: Icon(
            index < _rating ? Icons.star : Icons.star_border,
            color: Colors.yellowAccent,
            size: 40.0,
          ),
        );
      }),
    );
  }

  void navigateToSuccessPage() {
    // Save feedback to the database or perform other necessary actions here

    // Navigate to the success page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => buildSuccessPage()),
    );
  }


  Widget buildSuccessPage() {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 100.0,
              ),
              const SizedBox(height: 20.0),
              const Text(
                'Thanks for your feedback!',
                style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10.0),
              const Text(
                'We appreciate your feedback—it fuels our improvement process.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              ElevatedButton(
                  onPressed: (){
                    navigateBackToHelpCenter();
                  },
                  child: const Text("Return")
              ),
            ],
          ),
        ),
      ),
    );
  }

  void navigateBackToHelpCenter(){
    Navigator.popUntil(
        context,
            ModalRoute.withName('HelpCenterScreen'),
    );
  }
}