import 'package:flutter/material.dart';
import 'package:untitled/Components/rounded_textfield.dart';
import 'package:untitled/constatns/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  String place;
  ChatScreen(this.place);
  @override
  _ChatScreenState createState() => _ChatScreenState(place);
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  String place;
  _ChatScreenState(this.place);
  final messageController = TextEditingController();
  late final Email;
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  late String message;
  @override
  void getCurrentUser() async {
    final userEmail = await _auth.currentUser!.email;
    Email = userEmail;
  }

  Widget build(BuildContext context) {
    getCurrentUser();
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kWidgetColor,
        leading: null,
        title: Text('$place chat'),
      ),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: _firestore
                .collection('chats')
                .doc('$place')
                .collection('messages')
                .snapshots(),
            builder: (context, snapshot) {
              List<Widget> messageWidgets = [];
              if (snapshot.hasData) {
                final messages = snapshot.data!.docs;

                for (var message in messages) {
                  final messageText = message.get('message');
                  final messageSender = message.get('sender');
                  final messageWidget =
                      BubbleMessage(messageSender, messageText);
                  messageWidgets.add(messageWidget);
                }
              }
              return Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  children: messageWidgets,
                ),
              );
            },
          ),
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                      controller: messageController,
                      textAlign: TextAlign.center,
                      obscureText: false,
                      onChanged: (value) {
                        message = value;
                      },
                      decoration: kTextfieldDecoratin.copyWith(
                          hintText: 'Send a message')),
                ),
                FlatButton(
                    onPressed: () {
                      messageController.clear();
                      _firestore
                          .collection('chats')
                          .doc('$place')
                          .collection('messages')
                          .add({'sender': Email, 'message': message});
                    },
                    child: Icon(Icons.send))
              ],
            ),
          )
        ],
      )),
    );
  }
}

class BubbleMessage extends StatelessWidget {
  @override
  final String messageText;
  final String messageSender;

  BubbleMessage(this.messageSender, this.messageText);
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '$messageSender',
            style: TextStyle(fontSize: 12, color: kWidgetColor),
          ),
          Material(
            borderRadius: BorderRadius.circular(15),
            elevation: 5,
            color: kWidgetColor,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                '$messageText',
                style: TextStyle(color: kBackgroundColor, fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
