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
        title: Text("Feedback"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("Rate Your Experience"),
            Text(
              "Are you Satisfied with the Application?",
              style: TextStyle(
                fontSize: 16.0, // Adjust the font size as needed
              ),
            ),
            buildStar(),
            Divider(
              color: Colors.white24, // Set the color of the divider
              thickness: 2.0, // Set the thickness of the divider
              height: 20.0, // Set the height of the divider
              indent: 20.0, // Set the left indentation of the divider
              endIndent: 20.0, // Set the right indentation of the divider
            ),
            Text("Tell us what can be Improved?"),
            TextField(
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
              child: Text("Send"),
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
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
