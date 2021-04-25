import 'package:brew_crew/Services/auth.dart';
import 'package:brew_crew/shared/constant.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth=AuthService();
  final _formKey=GlobalKey<FormState>();
  bool loading=false;

  String email='';
  String password='';
  String error='';
  @override
  Widget build(BuildContext context) {

    return loading?Loading(): Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Text('Sign in to brew crew'),
        actions: [
          FlatButton.icon(
              onPressed: (){
                widget.toggleView();

              },
              icon: Icon(Icons.person),
              label: Text('Register'))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 20,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email'),

                validator: (val){
                  return val.isEmpty?'Enter an email':null;
                },
                onChanged: (val){
                  setState(() {
                    email=val;
                  });
                },
              ),
              SizedBox(height: 20,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                validator: (val){
                  return val.length<6?'Set longer password(>6)':null;
                },
                obscureText: true,
                onChanged: (val){
                  setState(() {
                    password=val;
                  });
                },
              ),
              SizedBox(height: 20,),
              RaisedButton(
                color: Colors.pink,
                  child: Text(
                    'Sign In',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: ()async{
                    if(_formKey.currentState.validate()){
                      setState(() {
                        loading=true;
                      });
                      dynamic result=await _auth.signInWithEmailAndPassword(email, password);
                      if(result==null){
                        setState(() {
                          loading=false;
                          error='Please enter valid CREDENTIALS';
                        });
                      }
                      print(email);
                      print(password);
                    }
                  }),
              SizedBox(height: 20.0,),
              Text(error,
                style: TextStyle(color: Colors.red,
                    fontSize: 14.0),),


            ],
          ),
        ),
      ),
    );
  }
}
