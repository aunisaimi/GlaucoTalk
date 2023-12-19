import 'package:apptalk/pages/setting/help_center.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  TextEditingController messageController = TextEditingController();

  Future<void> saveFeedbackData() async{
    try{
      // get the current users ID
      final userId = FirebaseAuth.instance.currentUser!.uid;

      // Generate a unique document ID for each feedback submission
      final feedbackDocRef =
        FirebaseFirestore.instance.collection('feedbacks').doc();

      // save the feedback in firestore
      await feedbackDocRef.set({
        'userID': userId,
        'rating' : _rating,
        'dateTime' : DateTime.now(),
        'comment' : messageController.text,
        'status' : 1,
      });

      // inform the user that the profile has been updated
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(
      //     content: Text('Feedback saved successfully'),
      //   ),
      // );

      print("Successfully saved feedback");

    } catch(e){
      print('Error saving feedback data: $e');
    }
  }

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
                fontWeight: FontWeight.w600
            ),
          ),
        ),

        leading: IconButton(
          onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const HelpCenter()
                )
            );
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
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
                  controller: messageController,
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

              const SizedBox(height: 20,),

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
                    saveFeedbackData();
                    // inform the user that the feedback has been sent
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => buildSuccessPage(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
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

  Widget buildSuccessPage() {
    return Scaffold(
      backgroundColor: myCustomColor,
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
                  color: Color(0xF6F5F5FF),
                ),
              ),
              const SizedBox(height: 10.0),
              const Text(
                'We appreciate your feedback—it fuels our improvement process.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Color(0xF6F5F5FF),
                ),
                textAlign: TextAlign.center,
              ),
              ElevatedButton(
                  onPressed: (){
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HelpCenter()
                        ), (route) => false
                    );
                  },
                  child: const Text("Return")
              ),
            ],
          ),
        ),
      ),
    );
  }
}