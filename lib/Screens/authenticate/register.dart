import 'package:brew_crew/Services/auth.dart';
import 'package:brew_crew/shared/constant.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth=AuthService();
  final _formKey=GlobalKey<FormState>();
  bool loading=false;
  String email,password,error='';
  @override
  Widget build(BuildContext context) {
    return loading?Loading():  Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Text('Sign up to brew crew'),
        actions: [
          FlatButton.icon(
              onPressed: (){
                widget.toggleView();
              },
              icon: Icon(Icons.person),
              label: Text('Sign in'))
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
                    'Register',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: ()async{
                    if(_formKey.currentState.validate()){
                      setState(() {
                        loading=true;
                      });
                      dynamic result=await _auth.registerWithEmailAndPassword(email, password);
                      if(result==null){
                        setState(() {
                          error='Please supply valid email';
                          loading=false;
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
