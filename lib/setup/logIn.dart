import 'package:flutter/material.dart';
import 'package:firebase_test/pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _invalidFormInput = 'valid';
  String _email, _password;
  final _formKey = GlobalKey<FormState>();

  void _setFormState(String errMsg) {
    setState(() {
      _invalidFormInput = errMsg;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Insert correct email.';
                  }
                  return null;
                },
                onSaved: (input) => _email = input,
                decoration: InputDecoration(
                  icon: Icon(Icons.email),
                  labelText: 'Email',
                ),
              ),
              TextFormField(
                validator: (value) {
                  if (value.length < 7) {
                    return 'Password should contain at least 7 chars';
                  }
                  return null;
                },
                onSaved: (input) => _password = input,
                decoration: InputDecoration(
                    icon: Icon(Icons.security_rounded), labelText: 'Password'),
                obscureText: true,
              ),
              Container(
                width: double.infinity,
                height: 40.0,
                margin: EdgeInsets.only(top: 10, bottom: 10),
                child: RaisedButton(
                  onPressed: signIn,
                  child: Text('Sign in'),
                  color: Color.fromRGBO(0, 0, 0, .1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                ),
              ),
              Container(
                child: _invalidFormInput != 'valid'
                    ? Text(
                        _invalidFormInput,
                        style: TextStyle(color: Colors.red),
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signIn() async {
    final formState = _formKey.currentState;
    // Validate fields
    if (formState.validate()) {
      // Save form input
      formState.save();
      try {
        // Login to firebase
        UserCredential result = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
        // Set the state of the form error to valid
        _setFormState('valid');
        // Navigate to home
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage(user: result.user)));
      } catch (e) {
        if (e.code == 'user-not-found') {
          _setFormState('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          _setFormState('Wrong password provided for that user.');
        } else {
          _setFormState(e.message);
        }
      }
    }
  }
}
