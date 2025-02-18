import 'package:brew_crew/screens/authenticate/register.dart';
import 'package:brew_crew/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool haveAccount = true;

  void toggleView(){
    setState(() {
      haveAccount = !haveAccount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: haveAccount ? SignIn(toggleView) : Register(toggleView),
    );
  }
}
