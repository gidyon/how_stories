import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'styles.dart';

class WelcomeScreen extends StatefulWidget {
  final Function getStartedCallback;

  const WelcomeScreen({super.key, required this.getStartedCallback});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  stopAnimation() {
    _controller.stop();
  }

//  Widget _buildImage([double width = 200]) {
//     return Image.asset('assets/images/logo2.png', width: width);
//   }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: SizedBox(
              height: 250,
              width: 250,
              child: Lottie.asset(
                'assets/animes/61927-flying-man.json',
                repeat: true,
                onLoaded: (composition) {
                  // Future.delayed(const Duration(seconds: 3), stopAnimation());
                },
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                overflow: TextOverflow.visible,
                textAlign: TextAlign.start,
                textDirection: TextDirection.ltr,
                softWrap: true,
                maxLines: 4,
                textScaleFactor: 3,
                text: const TextSpan(
                  text: 'A world of exciting Stories and Ideas ',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'in 5 mins',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.pink,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                " of exciting Stories and Ideas from across the world, all for you :)",
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Color.fromARGB(255, 105, 104, 104),
                  fontSize: 15,
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () => widget.getStartedCallback(),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  'Jump right in',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ), // <-- Text
                SizedBox(
                  width: 5,
                ),
                Icon(
                  // <-- Icon
                  Icons.arrow_forward,
                  size: 18.0,
                ),
              ],
            ),
          ),
          // SizedBox(
          //   width: double.infinity,
          //   child: ElevatedButton(
          //     onPressed: () => widget.getStartedCallback(),
          //     child: const Text('Login'),
          //   ),
          // ),
        ],
      ),
    );
  }
}
