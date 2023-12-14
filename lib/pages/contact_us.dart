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
        backgroundColor: const Color(0xFF00008B),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Text(
              "Contact Us",
              style: TextStyle(
                fontSize: 30
              ),
            ),
            SizedBox(height: 8,),
            TextField(
              decoration: InputDecoration(
                hintText: "Tell us how we can help in at least 5 characters",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 8,),
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
