import 'package:apptalk/components/progress_bar.dart';
import 'package:flutter/material.dart';

class MyStoryBars extends StatelessWidget {

  List<double> percentWatched=[];

  MyStoryBars({required this.percentWatched});


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
