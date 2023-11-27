import 'package:chatappkoko/components/mybutton.dart';
import 'package:chatappkoko/components/mytextfeild.dart';
import 'package:chatappkoko/services/auth/authservices.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Loginpage extends StatefulWidget {
  final void Function()? onTap;

  const Loginpage({super.key, this.onTap});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  //text controller
  final emailController = TextEditingController();
  final passwordcontroller = TextEditingController();

  //sign in
  Future<void> signIn() async {
    //get the auth services
    final authService = Provider.of<AuthServices>(context, listen: false);

    try {
      await authService.signInWithEmailandPassword(
          emailController.text,
          passwordcontroller.text);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
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
                //welcome text
                Text(
                  "Welcome back you\'ve been missed!",
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
                  height: 25,
                ),
                // sign in button
                Mybutton(
                  text: "Sign In",
                  ontap: signIn,
                ),

                SizedBox(
                  height: 50,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Not a member?"),
                    SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        "Register Now",
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
