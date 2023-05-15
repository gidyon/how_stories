import 'package:flutter/material.dart';
import 'package:how_stories/src/presentation/widgets/signin_buttons.dart';
import 'package:lottie/lottie.dart';

import '../utils/first_time.dart';
import 'styles.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 150,
            width: 150,
            child: Lottie.asset(
              'assets/animes/61927-flying-man.json',
              repeat: true,
              onLoaded: (composition) {
                // Future.delayed(const Duration(seconds: 3), stopAnimation());
              },
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          const Text(
            'Sign in now :)',
            style: startHeaderStyles,
          ),
          SignInButtons(
            whileSigning: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Please wait while signing in...'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            afterSignIn: (p0) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('User signed in successfully'),
                ),
              );
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const HomeScreen(),
              //   ),
              // );
              FirstTimeManager.setNotFirstTime();
            },
            signInFailed: (p0) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Failed to sign in. Try again later'),
                ),
              );
            },
          ),
          const SizedBox(
            height: 40,
          ),
          ElevatedButton(
            onPressed: () {
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const HomeScreen(),
              //   ),
              // );
              FirstTimeManager.setNotFirstTime();
            },
            child: const Text('MAYBE LATER'),
          ),
        ],
      ),
    );
  }
}
