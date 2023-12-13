import 'package:apptalk/pages/feedback_page.dart';
import 'package:flutter/material.dart';

import 'contact_us.dart';

class HelpCenter extends StatelessWidget {
  const HelpCenter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Help"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            Card(
              child: ListTile(
                leading: Icon(Icons.chat_outlined),
                title: Text('Help Center'),
              ),
            ),
            Divider(
              color: Colors.white24, // Set the color of the divider
              thickness: 2.0, // Set the thickness of the divider
              height: 20.0, // Set the height of the divider
              indent: 20.0, // Set the left indentation of the divider
              endIndent: 20.0, // Set the right indentation of the divider
            ),
            GestureDetector(
              onTap: () {
                // Navigate to Contact Us Screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ContactUsScreen()
                  ),
                );
              },
              child: Card(
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
                  MaterialPageRoute(builder: (context) => FeedbackPage()),
                );
              },
              child: Card(
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
