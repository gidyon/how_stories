import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../widgets/sign_in.dart';
import '../widgets/welcome.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Container(
          //   color: Colors.red,
          //   alignment: const Alignment(0, 0.75),
          //   child: SmoothPageIndicator(
          //     controller: _controller,
          //     count: 3,
          //   ),
          // ),
          PageView(
            controller: _controller,
            children: [
              WelcomeScreen(
                getStartedCallback: () => {
                  _controller.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  )
                },
              ),
              const SignInScreen(),
              const SignInScreen(),
            ],
          ),
        ],
      ),
    );
  }
}
