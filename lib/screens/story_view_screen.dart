import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:story_view/story_view.dart';

class StoryViewScreen extends StatefulWidget {
  final List<String>? storiesList;
  final int? index;
  const StoryViewScreen({this.storiesList,this.index,Key? key}) : super(key: key);

  @override
  State<StoryViewScreen> createState() => _StoryViewScreenState();
}

class _StoryViewScreenState extends State<StoryViewScreen> {
  final storyController = StoryController();
  int index=0;

  @override
  void initState() {
    super.initState();
    index = widget.index!;
    debugPrint(index.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoryView(
        storyItems: [
          for(int i = index; i< widget.storiesList!.length;i++)
            storyItemType(widget.storiesList!,i)

        ],
        onStoryShow: (s) {
          debugPrint("Showing a story");
        },
        onComplete: () {
          debugPrint("Completed a cycle");
          Get.back();
        },
        progressPosition: ProgressPosition.top,
        repeat: false,
        controller: storyController,
      )
    );
  }
  storyItemType(List<String> storiesList, int i) {

    if(storiesList[i].split('.').last!="mp4"){
      return StoryItem.pageImage(
        imageFit: BoxFit.contain,
        url: storiesList[i],
        controller: storyController, );
    }
   else{
      return StoryItem.pageVideo(storiesList[i], controller: storyController, );
    }
  }
}
