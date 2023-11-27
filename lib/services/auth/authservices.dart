import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

class AuthServices extends ChangeNotifier {
  //instance of auth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  //instance for firstore

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //sign user in
Future<UserCredential> signInWithEmailandPassword (String email,String password) async{
  try{
    //sign in
    UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password);
    // add a new document for user in users collection if it already exist

    _firestore.collection("users").doc(userCredential.user!.uid).set({
      "uid" :userCredential.user!.uid,
      "email" :email,
    },SetOptions(merge: true)
    );
    return userCredential;
  }
 //catch any errors
  on FirebaseAuthException catch(e){
    throw Exception(e.code);
  }
}
//create a new user
  Future<UserCredential> signUpWithEmailandPassword(String email, String Password)async{
  try{
   UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
       email: email,
       password: Password
   );
// after  the user, create a new documentfor the user in users collection

  _firestore.collection("users").doc(userCredential.user!.uid).set({
    "uid" :userCredential.user!.uid,
    "email" :email,
  });
   return userCredential;
  }on FirebaseAuthException catch(e){
    throw Exception(e.code);
  }
  }

//sign user out
 Future<void> signOut()async{
  return await FirebaseAuth.instance.signOut();
 }
}