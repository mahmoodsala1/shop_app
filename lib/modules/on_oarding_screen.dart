import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/shared/shared_pref.dart';
import 'login/login.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../shared/functions.dart';

class OnBoardingModel {
  String image;
  String title;
  String body;

  OnBoardingModel(
      @required this.image, @required this.title, @required this.body);
}

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  List<OnBoardingModel> boardingList = [
    OnBoardingModel('assets/images/onboarding.png', 'title1', 'body1'),
    OnBoardingModel('assets/images/onboarding.png', 'title2', 'body2'),
    OnBoardingModel('assets/images/onboarding.png', 'title3', 'body3')
  ];
  PageController pageController = PageController();
  bool isLast = false;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [
          TextButton(
            onPressed: () {
              SharedPref.saveData(key: 'onBoardingVisitedBefore', value: true)
                  .then((value) {
                print(SharedPref.getData(key: 'onBoardingVisitedBefore'));
                navigateAndFinish(Login(), context);
              });
            },
            child: Text(
              'skip',
              style: TextStyle(fontFamily: 'jannah', fontSize: 20),
            ),
          )
        ],
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (index) {
                  if (index == boardingList.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                physics: BouncingScrollPhysics(),
                controller: pageController,
                itemBuilder: (context, index) =>
                    OnBoardItem(boardingList[index]),
                itemCount: boardingList.length,
              ),
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: pageController,
                  count: boardingList.length,
                  axisDirection: Axis.horizontal,
                  onDotClicked: (_) {
                    pageController.nextPage(
                        duration: Duration(seconds: 1),
                        curve: Curves.fastLinearToSlowEaseIn);
                  },
                  effect: WormEffect(
                    activeDotColor: ThemeData.light().primaryColor,
                    spacing: 8.0,
                    radius: 20.0,
                    dotWidth: 16.0,
                    dotHeight: 16.0,
                    paintStyle: PaintingStyle.stroke,
                    strokeWidth: 1.5,
                    dotColor: Colors.grey,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      SharedPref.saveData(
                              key: ' onBoardingVisitedBefore', value: true)
                          .then((value) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
                            (route) => false);
                      });
                    } else {
                      pageController.nextPage(
                          duration: Duration(seconds: 1),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios),
                )
              ],
            )
          ],
        ),
      )),
    );
  }

  Widget OnBoardItem(OnBoardingModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: Image(
          image: AssetImage('${model.image}'),
        )),
        SizedBox(
          height: 15,
        ),
        Text(
          '${model.title}',
          style: TextStyle(fontSize: 24, fontFamily: 'jannah'),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          '${model.body}',
          style: TextStyle(fontSize: 15, fontFamily: 'jannah'),
        )
      ],
    );
  }
}
