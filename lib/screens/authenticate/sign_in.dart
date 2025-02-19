import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/shared/constants.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;

  const SignIn(this.toggleView, {super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign In to Brew Crew'),
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
                'Register',
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
                  validator: (value) => value!.isEmpty ? 'Enter a password' : null,
                  onChanged: (value) => {
                    setState(() {
                      password = value;
                    })
                  },
                ),
                SizedBox(height: 20),
                OutlinedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()){
                        setState(() {
                          loading = true;
                        });

                        dynamic result = await _auth.loginWithEmailAndPassword(email, password);
                        if (result == null){
                          setState(() {
                            error = 'Invalid email or password...';
                            loading = false;
                          });
                        }
                      }
                    },
                    child: Text(
                      'SIGN IN',
                      style: TextStyle(
                        color: Colors.brown[600],
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.8,
                      ),
                    ),
                ),
                Text(
                  error,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                  ),
                ),

                SizedBox(height: 20),
                OutlinedButton.icon(
                  onPressed: () async {
                    await _auth.signInAnon();
                  },
                  label: Text(
                    'Sign In Anonymously...',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.brown[600],
                      letterSpacing: 0.5,
                    ),
                  ),
                  icon: Icon(
                      Icons.person,
                    color: Colors.brown[600],
                  ),
                ),
              ],
            )
        )
      ),
    );
  }
}
