import 'package:auth_buttons/auth_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../domain/entities/user_entity.dart';

class SignInButtons extends StatefulWidget {
  final Function(UserAccount?) afterSignIn;
  final Function(Object) signInFailed;
  final Function whileSigning;

  const SignInButtons(
      {super.key,
      required this.afterSignIn,
      required this.signInFailed,
      required this.whileSigning});

  @override
  State<SignInButtons> createState() => _SignInButtonsState();
}

class _SignInButtonsState extends State<SignInButtons> {
  bool isLoading = false;
  bool darkMode = false;

  AuthButtonType? buttonType;
  AuthIconType? iconType;

  ThemeMode get themeMode => darkMode ? ThemeMode.dark : ThemeMode.light;

  Future<void> signInWithGoogle() async {
    widget.whileSigning();
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      var cred = await FirebaseAuth.instance.signInWithCredential(credential);

      UserAccount user = UserAccount.empty;
      if (cred.user != null) {
        // user.setUser(
        //   cred.user!.displayName!,
        //   cred.user!.uid,
        //   cred.user!.email ?? '',
        //   cred.user!.photoURL ?? '',
        // );
      }

      // Call widget after sign in
      widget.afterSignIn(user);
    } catch (e) {
      if (kDebugMode) {
        print('Google signing in error happened: ${e.toString()}');
      }
      widget.signInFailed(e);
    }
  }

  Future<void> signInWithFacebook() async {
    widget.whileSigning();
    try {
      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login();

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      // Once signed in, return the UserCredential
      var cred = await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);

      UserAccount user = UserAccount.empty;
      if (cred.user != null) {
        // user.setUser(
        //   cred.user!.displayName!,
        //   cred.user!.uid,
        //   cred.user!.email ?? '',
        //   cred.user!.photoURL ?? '',
        // );
      }

      // Call widget after sign in
      widget.afterSignIn(user);
    } catch (e) {
      if (kDebugMode) {
        print('Facebook signing in error happened: ${e.toString()}');
      }
      widget.signInFailed(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          AuthButtonGroup(
            style: AuthButtonStyle(
              progressIndicatorType: AuthIndicatorType.linear,
              buttonType: buttonType,
              width: 230,
              height: 50,
              margin: const EdgeInsets.only(bottom: 10.0),
            ),
            buttons: [
              GoogleAuthButton(
                onPressed: () {
                  // your implementation
                  signInWithGoogle();
                },
                themeMode: themeMode,
                isLoading: isLoading,
                text: 'Continue with Google',
                style: AuthButtonStyle(
                  buttonType: buttonType,
                  iconType: iconType,
                ),
              ),
              FacebookAuthButton(
                onPressed: () {
                  signInWithFacebook();
                },
                themeMode: themeMode,
                isLoading: isLoading,
                text: 'Continue with Facebook',
                style: AuthButtonStyle(
                  buttonType: buttonType,
                  iconType: iconType,
                ),
              ),
              TwitterAuthButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Twitter Login will be supported soon'),
                      duration: Duration(seconds: 3),
                    ),
                  );
                },
                themeMode: themeMode,
                text: 'Continue with Twitter',
                isLoading: isLoading,
                style: AuthButtonStyle(
                  buttonType: buttonType,
                  iconType: iconType,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
