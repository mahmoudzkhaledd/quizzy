import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/general_methods/AppHelper.dart';
import 'package:quizapp/Widgets/DrawerListTile.dart';
import 'package:quizapp/Widgets/ImageLoader.dart';
import '../controllers/MainPageController.dart';
import '../general_methods/SizedBoxes.dart';
import '../general_methods/TextStyles.dart';
import '../Widgets/Screens/HomePageWidgets.dart';

class HomePage extends GetView<MainPageController> {
  HomePage({Key? key}) : super(key: key) {
    Get.put(MainPageController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          children: [
            GetBuilder<MainPageController>(
              id: "Drawer_Builder",
              builder: (_) => Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ImageLoader(
                    imageUrl:
                        AppHelper.user == null ? "" : AppHelper.user!.imageUrl,
                    borderRadius: 200,
                    width: 130,
                    height: 130,
                  ),
                  SizedBoxes.heightSizedBox,
                  Flexible(
                    child: Text(
                      AppHelper.user != null
                          ? AppHelper.user!.username
                          : "Username",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles.titleStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            SizedBoxes.heightSizedBox,
            CustomListTile(
              onTap: controller.goToYourQuizzes,
              title: "Your Quizzes",
              subTitle: "Tap To See The Quizzes You Made",
              icon: Icons.check_circle_outline,
            ),
            CustomListTile(
              onTap: controller.goToFriendRequests,
              title: "Friend Requests",
              subTitle: "Tap To Go To See Your Friend Requests",
              icon: Icons.send_rounded,
            ),
            CustomListTile(
              onTap: controller.viewProfile,
              title: "My Profile",
              subTitle: "Tap To Go To Your Profile",
              icon: Icons.account_circle_outlined,
            ),
            CustomListTile(
              onTap: controller.logOut,
              title: "Logout",
              subTitle: "Logout From Application",
              icon: Icons.exit_to_app_outlined,
            ),
            CustomListTile(
              onTap: controller.resetApp,
              title: "Reset",
              subTitle: "Reset All Application",
              icon: Icons.restart_alt,
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text(
          "Quizzy",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 2,
              horizontal: 7,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.black,
              ),
              borderRadius: BorderRadius.circular(200),
              color: Colors.amberAccent,
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.monetization_on_outlined,
                ),
                GetBuilder<MainPageController>(
                  id: "Drawer_Builder",
                  builder: (_) => Text(
                    AppHelper.user != null
                        ? AppHelper.user!.coins.toString()
                        : "0",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                )
              ],
            ),
          ),
          IconButton(
            onPressed: controller.viewProfile,
            icon: GetBuilder<MainPageController>(
              id: "Drawer_Builder",
              builder: (_) => ImageLoader(
                borderRadius: 200,
                imageUrl:
                    AppHelper.user == null ? "" : AppHelper.user!.imageUrl,
                height: 32,
                width: 32,
              ),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: controller.refreshPage,
        child: FutureBuilder<void>(
          future: controller.init(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData && AppHelper.user != null) {
              return GetBuilder<MainPageController>(
                id: "StackBuilder",
                builder: (_) => ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    SizedBoxes.heightSizedBox,
                    const Text(
                      "Explore Quizzes",
                      style: TextStyles.titleStyle,
                    ),
                    GetBuilder<MainPageController>(
                      id: "DotBuilder",
                      builder: (_) => HomeScreenHeader(
                        onTap: controller.goToMakeQuizPage,
                        startLiveQuiz: controller.startLiveQuiz,
                        onPageChanged: controller.onIndexValueChanged,
                        groupValue: controller.currentIndex,
                      ),
                    ),
                    HorizontalScroll(
                      friendsOnTap: controller.friendsOnTap,
                      solvedOnTap: controller.showSolved,
                      allQuizzesPage: controller.allQuizzesPage,
                      addFriendOnTap: controller.goToAddFriendPage,
                    ),
                    SizedBoxes.heightSizedBox,
                    const Text(
                      "Top Quizzes",
                      style: TextStyles.subTitleStyle,
                    ),
                    SizedBoxes.heightSizedBox,
                    GetBuilder<MainPageController>(
                      id: "Top_Quizzes_List_Builder",
                      builder: (ctx) => HomeScreenShowTopQuizzes(
                        onTap: controller.onTapQuiz,
                        quizzes: ctx.quizzes,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
