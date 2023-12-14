import 'dart:async';
import 'package:apptalk/components/story_bars.dart';
import 'package:apptalk/pages/status/stories/story2.dart';
import 'package:apptalk/pages/status/stories/story3.dart';
import 'package:flutter/material.dart';

import 'stories/story1.dart';

class StoryPage extends StatefulWidget {
  const StoryPage({
    Key? key}) : super(key: key);

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  int currentStoryIndex = 0;
  final List<Widget> myStories = [
    const MyStory1(), // 0
    const MyStory2(), // 1
    const MyStory3(), // 2
  ];

  List<double> percentWatched = [];

  @override
  void initState(){
    super.initState();

    // Only add 0.01 as long as it is below 1
    for (int i = 0; i < myStories.length; i++){
      percentWatched.add(0);
    }
    // If adding 0.01 exceeds 1, set percentage to 1 and cancel timer

    _startWatching();
  }

  void _startWatching(){
    Timer.periodic(const Duration(milliseconds: 50), (timer){
      setState(() {
        // Only add 0.01 as long as it is below 1
        if (percentWatched[currentStoryIndex] + 0.01 < 1){
          percentWatched[currentStoryIndex] += 0.01;
        }
        // If adding 0.01 exceeds 1, set percentage to 1 and cancel timer
        else{
        percentWatched[currentStoryIndex] = 1;
        timer.cancel();

        // go to the next story as long as there are more stories to go through
          if(currentStoryIndex < myStories.length - 1){
            currentStoryIndex++;

            // Restart story timer
            _startWatching();
          }

          // If we are finished watching, the last story then return to HomePage
          else{
            Navigator.pop(context);
          }
        }
      });
    });
  }

  void _onTapDown(TapDownDetails details){
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dx = details.globalPosition.dx;

    // user taps on first half of the screen
    if (dx < screenWidth / 2){
      setState(() {
        // as long as this isnt the first story
        if(currentStoryIndex > 0) {
          // set previous and current story watched percentage back to 0
          percentWatched[currentStoryIndex-1] = 0;
          percentWatched[currentStoryIndex] = 0;

          // go to previous story
          currentStoryIndex--;
        }
      });
    }
    // user taps on second half of the screen
    else{
      setState(() {
        // if there are no more stories left
        if(currentStoryIndex < myStories.length - 1){
          // finish current story
          percentWatched[currentStoryIndex] = 1;
          // move to next  story
          currentStoryIndex++;
        }
        else{
          percentWatched[currentStoryIndex] =1;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) => _onTapDown(details) ,
      child:Scaffold(
        body: Stack(
          children: [
            // Story
            myStories[currentStoryIndex],
            // Progress bar
             MyStoryBars(
               percentWatched: percentWatched,),
          ],
        )
      ),
    );
  }
}
