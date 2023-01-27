import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_project/services/auth.dart';
import 'package:firebase_project/shared/constants.dart';
import 'package:firebase_project/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  const SignIn({super.key, required this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? const Loading() :Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: const Text('Sign in to Brew Crew'),
        actions: [
          TextButton(
            onPressed: () {
              widget.toggleView();
            },
            child: Row(
              children: const [
                Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                Text(
                  'Register',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                validator: ((value) =>
                    (value!.isEmpty) ? 'Enter an email' : null),
                onChanged: (value) {
                  setState(() => email = value);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                validator: ((value) => (value!.length < 6)
                    ? 'Enter a password 6+ chars long'
                    : null),
                onChanged: (value) {
                  setState(() => password = value);
                },
                obscureText: true,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.pink.shade400),
                ),
                child: const Text('Sign in'),
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    setState(() {
                      loading = true;
                    });
                    dynamic result = await _auth.signInWithEAP(email, password);
                    if (result == 'NoUser') {
                      setState(() {
                        loading = false;
                        error = 'Could\'nt sign in!';
                      });
                    }
                  }
                },
              ),
              const SizedBox(
                height: 12.0,
              ),
              Text(
                error,
                style: const TextStyle(color: Colors.red, fontSize: 14.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
