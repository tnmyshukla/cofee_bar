import 'package:brew_crew/Screens/authenticate/authenticate.dart';
import 'package:brew_crew/Screens/home/home.dart';
import 'package:brew_crew/models/appuser.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //return either home or authenticate screen
    final appuser=Provider.of<AppUser>(context);
    print(appuser);
    if(appuser==null){
      return Authenticate();
    }
    else{
      return Home();
    }

  }
}
