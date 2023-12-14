import 'package:apptalk/pages/store_page_view.dart';
import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';

class StatusScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[900],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Card(
            color: Colors.white,
            elevation: 2.0,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: ListTile(
                leading: Stack(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('lib/images/winter.jpg'),
                    ),
                    Positioned(
                      bottom: 10.0,
                      right: 1.0,
                      child: SizedBox(
                        height: 10,
                        width: 20,
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                    ),
                  ],
                ),
                title: Text(
                  "My Status",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text("Tap to add a status update"),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Viewed Updates",
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              color: Colors.white,
              child: ListTile(
                leading: const CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                      "https://pbs.twimg.com/media/EClDvMXU4AAw_lt?format=jpg&name=medium"),
                ),
                title: const Text(
                  "Pawan Kumar",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: const Text("Today, 20:16 PM"),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StoryPageView(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
