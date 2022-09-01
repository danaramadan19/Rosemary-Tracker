
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:untitled/pages/loginSignup.dart';
import '../ui/widgets/colors.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key key}) : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final controller = LiquidController();
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Stack(children: [
          LiquidSwipe(
              liquidController: controller,
              enableSideReveal: true,
              onPageChangeCallback: (index) {
                setState(() {});
              },
              slideIconWidget: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              pages: [
                Container(
                  color: AppColors.backColor,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "img/time.png",
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Text(
                        "Rosemary Tracker",
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 32,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Container(
                        padding: const EdgeInsets.only(right: 32),
                        child: Text(
                          "Rosemary is a simple habit tracker that helps you organize your routine,achieve your personal goals and reflect on your life.",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                   color:  Color(0xFFCEE7B3),
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "img/habit.png",
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Text(
                        "Track Your habits",
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 32,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Container(
                        padding: const EdgeInsets.only(right: 32),
                        child: Text(
                          "Rosemary not only helps you form healthy habits,but it also suggests for you new habits and keep them.",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                   color: AppColors.backColor,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "img/todo.png",
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Text(
                        "ToDo List",
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 32,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Container(
                        padding: const EdgeInsets.only(right: 32),
                        child: const Text(
                          "Make easy and effective ToDo list, so you will not forget your goals for the days. It's time you took control of your life!",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                     color:  Color.fromARGB(255, 147, 179, 114),
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "img/article.png",
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      const Text(
                        'Motivational Articles',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 32,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Container(
                        padding: const EdgeInsets.only(right: 32),
                        child: const Text(
                          'You will find a list of encouraging and inspiring articles that will help you do your tasks better and broaden your horizons.',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                 color:  Color(0xFFCEE7B3),
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "img/Journey-cuate.png",
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      const Text(
                        "Reach Your GOAL",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 32,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Container(
                        padding: const EdgeInsets.only(right: 32),
                        child: const Text(
                          "After all this and sticking to the steps daily, you will build a healthy routine and complete all your tasks in a timely manner, what's you're waiting for? lets get started!",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ]),
          Positioned(
              bottom: 0,
              left: 16,
              right: 32,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginSignupScreen()),
                        );
                      },
                      child: const Text('SKIP')),
                  AnimatedSmoothIndicator(
                    activeIndex: controller.currentPage,
                    count: 5,
                    effect: const WormEffect(
                      spacing: 12,
                      dotColor: Colors.black12,
                      activeDotColor: Colors.black,
                    ),
                    onDotClicked: (index) {
                      controller.animateToPage(page: index);
                    },
                  ),
                  TextButton(
                      onPressed: () {
                        final page = controller.currentPage + 1;

                        controller.animateToPage(
                            page: page, duration: 400);
                      },
                      child: const Text('NEXT')),
                ],
              )
              )
        ]),
      );
}
