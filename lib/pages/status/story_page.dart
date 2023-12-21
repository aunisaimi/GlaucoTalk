import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:story_view/story_view.dart'; // Corrected import for story_view

class StoryPage extends StatefulWidget {
  const StoryPage({Key? key}) : super(key: key);

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  int currentStoryIndex = 0;
  List<double> percentWatched = [];
  late Timer _timer;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late Stream<List<QueryDocumentSnapshot>> _storyStream;
  final StoryController storyController = StoryController(); // Define StoryController for StoryView

  @override
  void initState() {
    super.initState();
    _storyStream = _firestore.collection('status')
        .orderBy('timeStamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs);

    _startWatching();
  }

  void _startWatching() {
    _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      // Update percentWatched logic here
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    storyController.dispose(); // Dispose StoryController when not in use
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    // Your existing onTapDown logic
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      child: Scaffold(
        body: StreamBuilder<List<QueryDocumentSnapshot>>(
          stream: _storyStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No stories available'));
            }
            final stories = snapshot.data!;
            percentWatched = List.generate(stories.length, (index) => 0);

            // Assuming each document contains multiple StoryItems, we map each document to a list of StoryItem
            final List<List<StoryItem>> allStories = stories.map((document) {
              // Create a list of StoryItems for each story
              // This is a placeholder; you'll need to construct the StoryItems based on your actual data structure
              return [
                StoryItem.text(title: document['statusText'] ?? 'No text', backgroundColor: Colors.blue),
                // Add more StoryItem instances if your story has multiple items
              ];
            }).toList();

            return StoryView(
              storyItems: allStories[currentStoryIndex], // Pass the list of StoryItems for the current story
              controller: storyController, // Use the StoryController
              onComplete: () {
                // Logic to determine what happens when the story is complete
              },
              onVerticalSwipeComplete: (direction) {
                // Logic for vertical swipe action, if needed
              },
              // You can add more callbacks and configurations as needed
            );
          },
        ),
      ),
    );
  }
}
