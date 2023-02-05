import 'package:flutter/material.dart';
import 'package:untitled/Components/components.dart';
import 'package:untitled/screens/b-login_screen/login_screen.dart';
import 'package:untitled/styles/colors/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String description;
  BoardingModel(
      {required this.image, required this.title, required this.description});
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> onboardingModels = [
    BoardingModel(
        image: 'lib/Images/onboarding1.png',
        title: 'Discover new places!',
        description:
            'TripGo allows you to discover hundreds of places all over the world including landmarks,hotels,shopping places and restaurants.'),
    BoardingModel(
        image: 'lib/Images/onboarding2.png',
        title: 'know your place!',
        description:
            'TripGo can help you with a ton of information about your destination including location,description,and how to contact with the place'),
    BoardingModel(
        image: 'lib/Images/onboarding3.png',
        title: 'enjoy your place!',
        description:
            'since you got so far you now can enjoy your trip and don\'t forget to tell TripGo community about your trip to help them enjoying their time.'),
  ];

  var pageController = PageController();
  bool isLast = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('lib/Images/background.jpg'),
              fit: BoxFit.cover)),
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 100),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white, border: Border.all(color: kMainColor)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 30),
                  child: Column(
                    children: [
                      Expanded(
                        child: PageView.builder(
                          itemBuilder: (context, index) =>
                              buildOnBoardingItem(onboardingModels[index]),
                          itemCount: onboardingModels.length,
                          onPageChanged: (index) {
                            if (index == onboardingModels.length - 1) {
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
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SmoothPageIndicator(
                            controller: pageController,
                            count: onboardingModels.length,
                            effect: ExpandingDotsEffect(
                                activeDotColor: kMainColor,
                                expansionFactor: 6,
                                dotHeight: 5),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          FloatingActionButton(
                            onPressed: () {
                              isLast
                                  ? Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignInScreen()))
                                  : pageController.nextPage(
                                      duration: Duration(milliseconds: 600),
                                      curve: Curves.easeInOut);
                            },
                            child: Icon(
                              isLast
                                  ? Icons.check_outlined
                                  : Icons.navigate_next,
                              color: Colors.white,
                            ),
                            elevation: 0.0,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
