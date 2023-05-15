import 'package:flutter/material.dart';

import '../../domain/entities/user_entity.dart';
import 'signin_buttons.dart';

loginFirstAlert(context, {String? title, Function(UserAccount?)? callback}) {
  //  Show alert
  Widget cancelButton = TextButton(
    child: const Text("Cancel"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  AlertDialog alert = AlertDialog(
    title: Text(
      title ?? 'Sign in to continue',
      textAlign: TextAlign.center,
    ),
    content: SignInButtons(
      whileSigning: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please wait while signing in...'),
            duration: Duration(seconds: 2),
          ),
        );
      },
      afterSignIn: (p0) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('User signed in successfully'),
            duration: Duration(seconds: 1),
          ),
        );
        if (callback != null) {
          callback(p0);
        }
      },
      signInFailed: (p0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to sign in. Try again later'),
            duration: Duration(seconds: 2),
          ),
        );
      },
    ),
    actions: [
      cancelButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
