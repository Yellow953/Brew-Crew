import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {

    final AuthService _auth = AuthService();

    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: Text('BrewCrew'),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        actions: [
          ElevatedButton.icon(
            onPressed: () async {
              await _auth.signOut();
            },
            label: Text('Logout'),
            icon: Icon(Icons.logout),
          )
        ],
      ),
      body: Text('home'),
    );
  }
}
