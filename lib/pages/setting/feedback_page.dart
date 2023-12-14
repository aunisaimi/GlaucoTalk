import 'package:flutter/material.dart';
class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackPage> {

  int _rating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Feedback"),
        backgroundColor: const Color(0xFF00008B),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            const Text(
              "Rate Your Experience",
              style: TextStyle(
                  fontSize: 30
              ),
            ),
            const Text(
              "Are you Satisfied with the Application?",
              style: TextStyle(
                fontSize: 16.0, // Adjust the font size as needed
              ),
            ),
            buildStar(),
            const Divider(
              color: Colors.white24, // Set the color of the divider
              thickness: 2.0, // Set the thickness of the divider
              height: 20.0, // Set the height of the divider
              indent: 20.0, // Set the left indentation of the divider
              endIndent: 20.0, // Set the right indentation of the divider
            ),
            const Text(
              "Tell us what can be Improved?",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const TextField(
              decoration: InputDecoration(
                hintText: "feedback",
                border: OutlineInputBorder(),
              ),
            ),
            ElevatedButton(
              onPressed: (){
                // add save input to database function
                Navigator.pop(context);
                buildSuccessPage();
              },
              child: const Text("Send"),
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
            color: Colors.amber,
            size: 40.0,
          ),
        );
      }),
    );
  }

  Widget buildSuccessPage() {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 100.0,
              ),
              SizedBox(height: 20.0),
              Text(
                'Thanks for your feedback!',
                style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'We appreciate your feedback—it fuels our improvement process.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}