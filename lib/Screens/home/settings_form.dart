import 'package:brew_crew/Services/database.dart';
import 'package:brew_crew/models/appuser.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/shared/constant.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];
  //form values
  String _currentName, _currentSugars;
  int _currentStrength;
  @override
  Widget build(BuildContext context) {
    final appUser = Provider.of<AppUser>(context);
    return StreamBuilder<AppUserData>(
        stream: DatabaseService(uid: appUser.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            AppUserData appUserData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    'Update your brew settings',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    initialValue: appUserData.name,
                    decoration:
                        textInputDecoration.copyWith(hintText: 'Your name'),
                    validator: (val) {
                      return val.isEmpty ? 'Please enter a name' : null;
                    },
                    onChanged: (val) {
                      setState(() {
                        _currentName = val;
                      });
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  //dropdown
                  DropdownButtonFormField(
                    decoration: textInputDecoration,
                    value: _currentSugars ?? '0',
                    onChanged: (val) {
                      setState(() => _currentSugars = val);
                    },
                    items: sugars.map((sugar) {
                      return DropdownMenuItem(
                          value: sugar, child: Text('${sugar} sugars'));
                    }).toList(),
                  ),
                  Slider(
                    min: 100,
                    max: 900,
                    divisions: 8,
                    value:
                        (_currentStrength ?? appUserData.strength).toDouble(),
                    activeColor:
                        Colors.brown[_currentStrength ?? appUserData.strength],
                    inactiveColor:
                        Colors.brown[_currentStrength ?? appUserData.strength],
                    onChanged: (val) =>
                        setState(() => _currentStrength = val.round()),
                  ),
                  //slider
                  RaisedButton(
                      color: Colors.pink[400],
                      child: Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          await DatabaseService(uid: appUser.uid)
                              .updateUserData(
                                  _currentSugars ?? appUserData.sugars,
                                  _currentName ?? appUserData.name,
                                  _currentStrength ?? appUserData.strength);
                          Navigator.pop(context);
                        }
                        print(_currentName);
                        print(_currentSugars);
                        print(_currentStrength);
                      })
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
