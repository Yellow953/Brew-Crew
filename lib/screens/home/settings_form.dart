import 'package:brew_crew/models/custom_user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4', '5'];

  String _currentName = '';
  String _currentSugars = '0';
  int _currentStrength = 100;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);
    if (user == null) {
      return Loading();
    }

    return StreamBuilder<UserData>(
      stream: DatabaseService(user.uid).userData,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Loading();
        }

        UserData? userData = snapshot.data;

        return Form(
          key: _formKey,
          child: Column(
            children: [
              Text('Update Your Brew Preferences...', style: TextStyle(fontSize: 18)),
              SizedBox(height: 20),
              TextFormField(
                initialValue: userData?.name ?? '',
                decoration: textInputDecoration,
                validator: (val) => val!.isEmpty ? 'Please enter a name' : null,
                onChanged: (val) => setState(() => _currentName = val),
              ),
              SizedBox(height: 20),
              DropdownButtonFormField(
                decoration: textInputDecoration,
                value: sugars.contains(_currentSugars) ? _currentSugars : userData?.sugars ?? '0',
                items: sugars.map((sugar) {
                  return DropdownMenuItem(
                    value: sugar,
                    child: Text('$sugar sugar(s)'),
                  );
                }).toList(),
                onChanged: (val) => setState(() => _currentSugars = val!),
              ),
              SizedBox(height: 20),
              Slider(
                min: 100,
                max: 900,
                divisions: 8,
                value: (_currentStrength != 100 ? _currentStrength : userData?.strength ?? 100).toDouble(),
                activeColor: Colors.brown[_currentStrength != 100 ? _currentStrength : userData?.strength ?? 100],
                inactiveColor: Colors.brown[_currentStrength != 100 ? _currentStrength : userData?.strength ?? 100],
                onChanged: (val) => setState(() => _currentStrength = val.round()),
              ),
              SizedBox(height: 20),
              OutlinedButton(
                onPressed: () async {
                  if(_formKey.currentState!.validate()){
                    await DatabaseService(user.uid).updateUserData(
                        _currentSugars ?? userData!.sugars,
                        _currentName ?? userData!.name,
                        _currentStrength ?? userData!.strength,
                    );
                    Navigator.pop(context);
                  }
                },
                child: Text('Update'),
              ),
            ],
          ),
        );
      },
    );
  }
}
