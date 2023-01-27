import 'package:firebase_project/screens/authenicate/register.dart';
import 'package:firebase_project/screens/authenicate/sign_in.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool isSignIn = true;

  void toggleView() {
    setState(() => isSignIn = !isSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (isSignIn) {
      return  SignIn(toggleView: toggleView);
    } else {
      return  Register(toggleView: toggleView);
    }
  }
}
