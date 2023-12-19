import 'package:chat_app/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatService extends ChangeNotifier{

  // get instance of auth and firestore
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore= FirebaseFirestore.instance;


  //send message
  Future<void> sendMessage(String receiverID, String message) async{

    //get current user info
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();


    //create a new message
    Message newMessage = Message(
      senderId: currentUserId, 
      senderEmail: currentUserEmail, 
      receiverId: receiverID, 
      message: message, 
      timestamp: timestamp,
      );

    // construct chat room id from current user id and receiver id(sorted to ensure uniqueness)

    List<String> ids = [currentUserId, receiverID];
    ids.sort();//sort the ids (this ensures the chat room id is alwas the same for any pair of people)
    String chatRoomId= ids.join(
      "_"
    );


    //add new message to database
    await _firestore
    .collection('chat_rooms')
    .doc(chatRoomId)
    .collection('messages')
    .add(newMessage.toMap());
  }



  //get message

  Stream<QuerySnapshot>getMessages(String userId, String otherUserId) {
    //construct chat room id from user ids (sorted to ensure it matches the id used when sending)
    List<String> ids= [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join ("_");
    return _firestore
    .collection('chat_rooms')
    .doc(chatRoomId)
    .collection('messages')
    .orderBy('timestamp', descending: false)
    .snapshots();
  }
}