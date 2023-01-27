import 'package:firebase_project/models/simple_user.dart';
import 'package:firebase_project/services/database.dart';
import 'package:firebase_project/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../shared/constants.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();

  final List sugars = ['0', '1', '2', '3', '4'];

  String? _currentName;
  String? _currentSugars;
  int? _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<SimpleUser>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.requireData;
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text(
                    'Update your brew settings.',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    initialValue: userData.name,
                    decoration: textInputDecoration.copyWith(
                        hintText: 'Enter your name'),
                    validator: ((value) =>
                        (value!.isEmpty) ? 'Enter your name' : ''),
                    onChanged: (value) {
                      setState(() => _currentName = value);
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  DropdownButtonFormField(
                    decoration: textInputDecoration,
                    value: _currentSugars ?? userData.sugars,
                    items: sugars.map((sugar) {
                      return DropdownMenuItem(
                        value: sugar,
                        child: Text('$sugar sugar(s)'),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _currentSugars = value.toString();
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Slider(
                    activeColor:
                        Colors.brown[_currentStrength ?? userData.strength],
                    inactiveColor:
                        Colors.brown[_currentStrength ?? userData.strength],
                    label:
                        'Strength ${_currentStrength ?? userData.strength / 100.toInt()}',
                    value: _currentStrength?.toDouble() ??
                        userData.strength.toDouble(),
                    onChanged: ((value) {
                      setState(() {
                        _currentStrength = value.toInt();
                      });
                    }),
                    min: 100,
                    max: 900,
                    divisions: 8,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.pink.shade400),
                    ),
                    child: const Text('Update'),
                    onPressed: () async {
                      await DatabaseService(uid: user.uid).updateUserData(
                          _currentSugars ?? userData.sugars,
                          _currentName ?? userData.name,
                          _currentStrength ?? userData.strength);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            );
          } else {
            return const Loading();
          }
        });
  }
}
