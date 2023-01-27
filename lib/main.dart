import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_project/models/simple_user.dart';
import 'package:firebase_project/screens/wrapper.dart';
import 'package:firebase_project/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<SimpleUser>.value(
      value: AuthService().user,
      initialData: SimpleUser(uid: 'NoUser'),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}
