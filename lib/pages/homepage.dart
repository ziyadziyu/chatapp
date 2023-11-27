import 'dart:html';

import 'package:chatappkoko/pages/chatpage.dart';
import 'package:chatappkoko/services/auth/authservices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  //instance of auth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //sign user out
  void signOut() {
    //get auth service
    final authService = Provider.of<AuthServices>(context, listen: false);

    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300] ,
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Center(child: Text("Home page")),
        actions: [IconButton(onPressed: signOut, icon: Icon(Icons.logout))],
      ),
      body: _buildUserList(),
    );
  }

  //build alist of useres except for the current looged in user
  Widget _buildUserList() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("users").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("error");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("loading...");
          }
          return ListView(
            children: snapshot.data!.docs
                .map<Widget>((doc) => _buildUserListItem(doc))
                .toList(),
          );
        });
  }

  //build individau; users list
  Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    //display all users execpt current user
    if (_auth.currentUser!.email != data['email']) {
      return ListTile(
        title: Text(data["email"]),
        onTap: () {
          //pass the clicked users uid to chat page
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(
                    receiverUserEmail: data["email"],
                    receiverUserID: data["uid"]),
              ));
        },
      );
    }else{
      //return empty container
      return Container();
    }
  }
}
