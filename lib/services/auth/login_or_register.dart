import 'package:chatappkoko/pages/loginpage.dart';
import 'package:chatappkoko/pages/registerpage.dart';
import 'package:flutter/material.dart';

class LoginorRegister extends StatefulWidget {
  const LoginorRegister({super.key});

  @override
  State<LoginorRegister> createState() => _LoginorRegisterState();
}

class _LoginorRegisterState extends State<LoginorRegister> {
  //initally show the login screen
  bool showLoginpage = true;

  //toogle betwwn login and register page
  void tooglePages(){
    setState(() {
      showLoginpage = !showLoginpage;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showLoginpage){
      return Loginpage(onTap: tooglePages,);
    }else{
      return Registerpage(onTap: tooglePages,);
    }
  }
}
