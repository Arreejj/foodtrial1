import 'package:flutter/material.dart';
import 'package:areej/common/color_extension.dart';
import 'package:areej/common_widget/round_button.dart';
import 'package:areej/view/home/home_view.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  int selectPage = 0;
  final PageController controller = PageController();

  static const String titleKey = "title";
  static const String subtitleKey = "subtitle";
  static const String imageKey = "image";

  final List<Map<String, String>> pageArr = [
    {
      titleKey: "Find Food You Love",
      subtitleKey:
          "Discover the best foods from over 1,000\nrestaurants and fast delivery to your\ndoorstep",
      imageKey: "assets/img/on_boarding_1.png",
    },
    {
      titleKey: "Fast Delivery",
      subtitleKey: "Fast food delivery to your home, office\nwherever you are",
      imageKey: "assets/img/on_boarding_2.png",
    },
    {
      titleKey: "Live Tracking",
      subtitleKey:
          "Real-time tracking of your food on the app\nonce you place the order",
      imageKey: "assets/img/on_boarding_3.png",
    },
  ];

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        selectPage = controller.page?.round() ?? 0;
      });
    });
  }

  @override
  void dispose() {
    controller.removeListener(() {});
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: controller,
            itemCount: pageArr.length,
            itemBuilder: (context, index) {
              final pObj = pageArr[index];
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    pObj[imageKey]!,
                    width: media.width * 0.7,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: media.height * 0.05),
                  Text(
                    pObj[titleKey]!,
                    style: TextStyle(
                      color: TColor.primaryText,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: media.height * 0.02),
                  Text(
                    pObj[subtitleKey]!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: TColor.secondaryText,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: media.height * 0.07),
                ],
              );
            },
          ),
          Positioned(
            bottom: media.height * 0.1,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(pageArr.length, (index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      height: 6,
                      width: 6,
                      decoration: BoxDecoration(
                        color: index == selectPage
                            ? TColor.primary
                            : TColor.placeholder,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: RoundButton(
                    title: selectPage == pageArr.length - 1
                        ? "Get Started"
                        : "Next",
                    fontSize: 18,
                    onPressed: () {
                      if (selectPage >= pageArr.length - 1) {
                        // Navigate to HomeView (not HomeViewContent)
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) =>  HomeView()),
                        );
                      } else {
                        controller.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
