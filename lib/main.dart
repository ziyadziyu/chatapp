import 'package:chatappkoko/pages/registerpage.dart';
import 'package:chatappkoko/services/auth/auth_gate.dart';
import 'package:chatappkoko/services/auth/authservices.dart';
import 'package:chatappkoko/services/auth/login_or_register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyAUBZiC8L1saV8v0my57eHb8OMQ4Y0ruLE",
        appId: "1:854266731923:android:71ce9546cd5151af2a9c66",
        messagingSenderId: "854266731923",
        projectId: "chatapp-b83b3")
  );
  runApp(
    ChangeNotifierProvider(create: (context) => AuthServices(),
    child: Myapp())
  );
}
class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:AuthGate() ,
    );
  }
}
