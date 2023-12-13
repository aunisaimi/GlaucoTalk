import 'package:flutter/material.dart';
class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Help"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Divider(
              color: Colors.white24, // Set the color of the divider
              thickness: 2.0, // Set the thickness of the divider
              height: 20.0, // Set the height of the divider
              indent: 20.0, // Set the left indentation of the divider
              endIndent: 20.0, // Set the right indentation of the divider
            ),
            Text("Contact Us"),
            TextField(
              decoration: InputDecoration(
                hintText: "Tell us how we can help in at least 5 characters",
                border: OutlineInputBorder(),
              ),
            ),
            ElevatedButton(
                onPressed: (){
                  // add save input to database function
                  Navigator.pop(context);
                },
                child: Text("Send"),
            ),
          ],
        ),
      ),
    );
  }
}
