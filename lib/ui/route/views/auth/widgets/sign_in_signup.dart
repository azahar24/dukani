import 'package:dukani/business_logics/auth.dart';
import 'package:flutter/material.dart';

class LoginSignup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () => Auth().signInWithGoogle(context),
              child: Text('Login & SignUp With Google'),
            ),
          ),
        ],
      ),
    );
  }
}
