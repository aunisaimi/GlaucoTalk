import 'package:apptalk/components/progress_bar.dart';
import 'package:flutter/material.dart';

class MyStoryBars extends StatelessWidget {

  final List<double> percentWatched;
  final PageController controller;

   const MyStoryBars({
     Key? key,
     required this.percentWatched,
     required this.controller})
       : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 34, left: 8, right: 8),
      child: Row(
        children: [
          Expanded(
              child: MyProgressBar(percentWatched: percentWatched[0]),
          ),
          Expanded(
            child: MyProgressBar(percentWatched: percentWatched[1]),
          ),
          Expanded(
            child: MyProgressBar(percentWatched:percentWatched[2]),
          ),
        ],
      ),
    );
  }
}
