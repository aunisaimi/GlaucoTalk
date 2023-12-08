import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Message{
  final String senderId;
  final String senderEmail;
  final String receiverId;
  final String message;
  final Timestamp timestamp;
  final String senderprofilePicUrl;
  //final String receiverprofilePicUrl;

  Message({
    required this.senderId,
    required this.senderEmail,
    required this.receiverId,
    required this.timestamp,
    required this.message,
    required  this.senderprofilePicUrl,
    //required this.receiverprofilePicUrl,
});

  // Convert to a map
  Map<String, dynamic> toMap() {
    return{
      'senderId': senderId,
      'senderEmail': senderEmail,
      'receiverId': receiverId,
      'message': message,
      'timestamp': timestamp,
      'senderprofilePicUrl' : senderprofilePicUrl,
      //'receiverprofilePicUrl' : receiverprofilePicUrl
    };
  }
}