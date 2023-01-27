import 'package:firebase_project/models/simple_user.dart';
import 'package:firebase_project/screens/authenicate/authenticate.dart';
import 'package:firebase_project/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<SimpleUser>(context);
    if (user.uid == 'NoUser') {
      return Authenticate();
    }else{
      return Home();
    }
  }
}
