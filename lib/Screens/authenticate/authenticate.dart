import 'package:brew_crew/Screens/authenticate/register.dart';
import 'package:brew_crew/Screens/authenticate/sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn=true;
  void toggleView(){
    setState(() {
      showSignIn=!showSignIn;
    });
  }
  @override
  Widget build(BuildContext context) {
    // await Firebase.initializeApp();
    if(showSignIn==true){
      return SignIn(toggleView: toggleView);
    }
    else{
      return Register(toggleView: toggleView );
    }
  }
}
