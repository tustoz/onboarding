import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:onboarding/dummy.dart';
import 'package:onboarding/constants.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final _controller = PageController(keepPage: true);
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: PageView.builder(
        controller: _controller,
        onPageChanged: (index) {
          setState(() {
            isLastPage = index == data.length;
          });
        },
        itemBuilder: (ctx, i) {
          return SizedBox(
            height: size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  data[i]['imageUrl'],
                  height: size.height * 0.6,
                  width: size.width,
                  scale: 4,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 30),
                SmoothPageIndicator(
                  controller: _controller,
                  count: data.length,
                  effect: WormEffect(
                    spacing: 8,
                    dotColor: Colors.black26,
                    activeDotColor: data[i]['color'],
                    dotHeight: 8,
                    dotWidth: 8,
                  ),
                  onDotClicked: (index) {
                    _controller.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                    );
                  },
                ),
                const SizedBox(height: 30),
                Text(
                  data[i]['title'],
                  style: kTitle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Text(
                  data[i]['subtitle'],
                  style: kSubtitle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: size.width * 0.40,
                  height: size.height * 0.07,
                  child: TextButton(
                    child: Text(
                      'Next',
                      style: kSubtitle.copyWith(
                        fontWeight: FontWeight.bold,
                        color: kBackgroundColor,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: data[i]['color'],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(size.width / 2),
                        ),
                      ),
                    ),
                    onPressed: () {
                      if (isLastPage == false) {
                        _controller.jumpToPage(i + 1);
                      }
                      if (isLastPage == true) {
                        _controller.jumpToPage(0);
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
