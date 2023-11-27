import 'package:chatappkoko/services/auth/authservices.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/mybutton.dart';
import '../components/mytextfeild.dart';

class Registerpage extends StatefulWidget {
  final void Function()? onTap;

  const Registerpage({super.key, this.onTap});

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  //text controller
  final emailController = TextEditingController();
  final passwordcontroller = TextEditingController();
  final confirmpasswordcontroller = TextEditingController();

  //signup user

  void signUp() async {
    if (passwordcontroller.text != confirmpasswordcontroller.text) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
          SnackBar(content: Text("Password do not match!")
          )
      );
      return;
    }
    //get auth services
    final authService = Provider.of<AuthServices>(context,listen: false);
    try{
      await authService.signUpWithEmailandPassword(emailController.text, passwordcontroller.text);
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                ),
                //logo
                Icon(
                  Icons.message,
                  size: 100,
                  color: Colors.grey[800],
                ),
                SizedBox(
                  height: 50,
                ),
                //create an account text
                Text(
                  "Let's create an accoutn for you!",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: 25,
                ),
                //email textfeild

                MyTextFeild(
                    controller: emailController,
                    hintText: "Email",
                    obscureText: false),
                SizedBox(
                  height: 10,
                ),
                //password textfeild
                MyTextFeild(
                    controller: passwordcontroller,
                    hintText: "Password",
                    obscureText: true),
                SizedBox(
                  height: 10,
                ),
                //confitm password
                MyTextFeild(
                    controller: confirmpasswordcontroller,
                    hintText: "Confirm Password",
                    obscureText: true),
                SizedBox(
                  height: 25,
                ),
                // sign up button
                Mybutton(
                  text: "Sign up",
                  ontap: signUp,
                ),

                SizedBox(
                  height: 50,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already a member?"),
                    SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        "Login Now",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
