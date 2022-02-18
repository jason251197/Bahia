import 'package:appclientes/shared/common.dart';
import 'package:appclientes/shared/helpers/removeScrollGlow.dart';
import 'package:flutter/material.dart';

import 'controller/on_boarding_controller.dart';
import 'data/boarding_json.dart';

class OnBoardingView extends StatelessWidget {
  final bool canPop;
  OnBoardingView([this.canPop = false]);
  final _pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (canPop)
          Navigator.pop(context);
        else
          OnBoardingController.goStartup();
        return false;
      },
      child: AppView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: Center(
                  child: Container(
                    child: ScrollConfiguration(
                      behavior: RemoveOverScrollGlow(),
                      child: PageView.builder(
                        physics: ClampingScrollPhysics(),
                        controller: _pageController,
                        itemCount: onBoarding.length,
                        itemBuilder: (context, index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(70),
                                child: GestureDetector(
                                  onLongPress: () {},
                                  child: Center(
                                    child: Image(
                                      fit: BoxFit.scaleDown,
                                      image: AssetImage(
                                        onBoarding[index]['image'],
                                      ),
                                      height: 250,
                                      width: 250,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: Texts.black(
                                  '${onBoarding[index]['title']}',
                                  textScaleFactor: 1.0,
                                  fontSize: 20,
                                  overflow: TextOverflow.visible,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Buttons.gray(
                      "Omite",
                      width: 120,
                      onClick: canPop
                          ? () => Navigator.pop(context)
                          : OnBoardingController.goStartup,
                    ),
                    Buttons.yellow(
                      "siguiente",
                      width: 120,
                      onClick: () => OnBoardingController.verifyToNavigation(
                          _pageController, canPop),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
