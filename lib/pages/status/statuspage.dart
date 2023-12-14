import 'package:apptalk/components/story_circles.dart';
import 'package:apptalk/pages/status/story_page.dart';
import 'package:flutter/material.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({super.key});

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {

  void _openStory(){
    Navigator.push(
      context, MaterialPageRoute(builder: (context) => const StoryPage(),
      )
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[300],
        title: const Center(
          child: Text(' S T A T U S',
          style: TextStyle(color: Colors.white)),
        ),
      ),
      body: Column(
        children: [
           SizedBox(
            height: 100,
              child: ListView.builder(
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return StoryCircle(
                  function: _openStory,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
