import 'package:chatappkoko/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class ChatSevice extends ChangeNotifier {
  //get instance of auth and firestore
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //send message
  Future<void> sendMessage(String receiverId, String message) async {
    //get curret user info

    final String currentUsertId = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    //create a new message
    Message newMessage = Message(
        senderId: currentUsertId,
        senderEmail: currentUserEmail,
        receiverId: receiverId,
        message: message,
        timestamp: timestamp
    );

    //construct chat room id from current user id and reciever id(sorted to ensure uniqueness)

    List<String> ids = [currentUsertId, receiverId];
    ids
        .sort(); // sort the ids(this enusers the chat room id is always the samefor any pair of people)
    String chatRoomId = ids.join(
        "_"); //combine ids into a single string to use a  chatRoomId

    //add new message to database

    await _firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .add(newMessage.toMap());
  }

//get message

Stream<QuerySnapshot> getMessages(String userId, String otherUserId){
    //construt chat room id from users ids(sorted ensure it matches the id used when sending message)
 List<String> ids = [userId, otherUserId];
 ids.sort();
 String chatRoomId = ids.join("_");
 
 return _firestore
     .collection("chat_rooms")
     .doc(chatRoomId)
     .collection("messages")
     .orderBy("timestamp",descending:false)
     .snapshots();
 
  }

}