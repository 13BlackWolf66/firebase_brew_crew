import 'package:firebase_project/screens/home/brew_list.dart';
import 'package:firebase_project/screens/home/settings_form.dart';
import 'package:firebase_project/services/auth.dart';
import 'package:firebase_project/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/brew.dart';
import '../../models/simple_user.dart';

class Home extends StatelessWidget {
  Home({super.key});
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<SimpleUser>(context);
    void _showSettingsPanel() {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
            child: SettingsForm(),
          );
        },
      );
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService(uid: user.uid).brews,
      initialData: const [],
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: const Text('Brew Crew'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: [
            ElevatedButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: const Icon(
                Icons.person,
              ),
              label: Text('logout'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Colors.brown[400],
                ),
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                _showSettingsPanel();
              },
              icon: Icon(Icons.settings),
              label: Text('settigs'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Colors.brown[400],
                ),
              ),
            ),
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/coffee_bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: BrewList(),
        ),
      ),
    );
  }
}
