import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/shared/constants.dart';

class Register extends StatefulWidget {

  final Function toggleView;

  const Register(this.toggleView, {super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign Up to Brew Crew'),
        actions: [
          TextButton.icon(
            onPressed: (){
              widget.toggleView();
            },
            icon: Icon(
              Icons.person,
              color: Colors.white,
            ),
            label: Text(
              'Login',
              style: TextStyle(
                  color: Colors.white
              ),
            ),
          )
        ],
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(
                      hintText: 'Enter your Email...',
                    ),
                    validator: (value) => value!.isEmpty ? 'Enter an email' : null,
                    onChanged: (value) => {
                      setState(() {
                        email = value;
                      })
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(
                      hintText: 'Enter your Password...',
                    ),
                    obscureText: true,
                    validator: (value) => value!.length < 6 ? 'Password should be 8+ characters...' : null,
                    onChanged: (value) => {
                      setState(() {
                        password = value;
                      })
                    },
                  ),
                  SizedBox(height: 20),
                  TextButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()){
                        dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                        if (result == null){
                          setState(() {
                            error = 'Please supply a valid email address...';
                          });
                        }
                      }
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    error,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                    ),
                  ),
                ],
              )
          )
      ),
    );
  }
}
