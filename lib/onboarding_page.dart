import 'package:baby_and_you/constants.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _activePage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
          controller: _pageController,
          itemCount: pages.length,
          onPageChanged: (int page) {
            setState(() {
              _activePage = page;
            });
          },
          itemBuilder: (BuildContext, index) {
            return Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: kHoneydew,
                      image: DecorationImage(
                          image: AssetImage(pages[index]["image"]),
                          opacity: .3,
                          fit: BoxFit.cover)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    pages[index]["description"],
                    style: TextStyle(
                        color: kFern_green,
                        fontWeight: FontWeight.bold,
                        fontSize: 38),
                  ),
                ),
                Positioned(
                  bottom: 15,
                  left: 1,
                  right: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _activePage > 0
                          ? ElevatedButton(
                              onPressed: () {
                                onPreviousPage();
                              },
                              child: Text(
                                "Previous",
                                style:
                                    TextStyle(color: kFern_green, fontSize: 12),
                              ),
                            )
                          : SizedBox(),
                      TextButton(
                        onPressed: () {
                          onNextPage();
                        },
                        child: Text(
                          _activePage < 2 ? "Next" : "Start",
                          style: TextStyle(
                              color: kFern_green,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }

  void onNextPage() {
    if (_activePage < pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.linear,
      );
    }
  }

  void onPreviousPage() {
    if (_activePage < pages.length + 1) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.linear,
      );
    }
  }
}
