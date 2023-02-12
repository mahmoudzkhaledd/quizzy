import 'package:flutter/material.dart';
import 'package:quizapp/general_methods/AppHelper.dart';
import '../QuizWidget.dart';
import '../ViewContainer.dart';
import '../../../models/QuizShortModel.dart';
import '../CustomDotIndecator.dart';
import '../NoResultFoundWidget.dart';
import '../SlideContainer.dart';


class HomeScreenHeader extends StatelessWidget {
  HomeScreenHeader({
    Key? key,
    required this.onTap,
    required this.startLiveQuiz,
    required this.onPageChanged,
    required this.groupValue
  }) : super(key: key){
    children =  [
      ViewContainer(
        mainText: "Make It Free Make Your Own Quiz",
        buttonText: "Make It Now",
        imageLoc: "assets/images/record.png",
        buttonOnTap: onTap,
        rightMargin: false,
      ),
      ViewContainer(
        mainText: "Start Live Quiz With Your Friends",
        buttonText: "Start",
        imageLoc:  "assets/images/livequiz.png",
        buttonOnTap: startLiveQuiz,
        rightMargin: false,
      ),
    ];
  }
  final VoidCallback onTap;
  final VoidCallback startLiveQuiz;
  final ValueChanged<int> onPageChanged;
  final int groupValue;


  List<Widget> children = [];
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 250,
          child: PageView(
            onPageChanged: onPageChanged,
            scrollDirection: Axis.horizontal,
            children: children,
          ),
        ),
        CustomPageIndicator(
          length: children.length,
          groupIndex: groupValue,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}



class HorizontalScroll extends StatelessWidget {
  const HorizontalScroll({
    Key? key,
    required this.solvedOnTap,
    required this.friendsOnTap,
    required this.allQuizzesPage,
    required this.addFriendOnTap,
  }) : super(key: key);
  final VoidCallback friendsOnTap;
  final VoidCallback solvedOnTap;
  final VoidCallback allQuizzesPage;
  final VoidCallback addFriendOnTap;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          SlideContainer(
            backgroundColor: AppHelper.mainColor,
            image: "assets/images/2830919.png",
            text: "Friends",
            onTap: friendsOnTap,
          ),
          SlideContainer(
            backgroundColor: AppHelper.mainColor,
            image: "assets/images/solution.png",
            text: "Solved",
            onTap: solvedOnTap,
          ),
          SlideContainer(
            backgroundColor: AppHelper.mainColor,
            image: "assets/images/select.png",
            text: "All Quizzes",
            onTap: allQuizzesPage,
          ),
          SlideContainer(
            backgroundColor: AppHelper.mainColor,
            image: "assets/images/friend.png",
            text: "Add Friends",
            onTap: addFriendOnTap,
          ),
        ],
      ),
    );
  }
}


class HomeScreenShowTopQuizzes extends StatelessWidget {
  HomeScreenShowTopQuizzes({
    Key? key,
    required this.quizzes,
    required this.onTap,
  }) : super(key: key);
  ValueChanged<String> onTap;
  List<QuizShortModel> quizzes;

  @override
  Widget build(BuildContext context) {
    return quizzes.isNotEmpty
        ? Column(
            children: quizzes
                .map(
                  (e) => QuizWidget(
                    hasGrade: false,
                    quiz: e,
                    ontTap: onTap,
                  ),
                )
                .toList())
        : const NoResultFoundWidget();
  }
}
