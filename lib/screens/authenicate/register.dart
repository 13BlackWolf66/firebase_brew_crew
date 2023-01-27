import 'package:firebase_project/services/auth.dart';
import 'package:firebase_project/shared/constants.dart';
import 'package:firebase_project/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  const Register({super.key, required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? const Loading():Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: const Text('Sign up to Brew Crew'),
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
                  'Sign in',
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
                child: const Text('Register'),
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    setState(() {
                      loading = true;
                    });
                    dynamic result =
                        await _auth.registerWithEAP(email, password);
                    if (result == 'NoUser') {
                      setState(() {
                        loading = false;
                        error = 'please supply a valid info';
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
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
