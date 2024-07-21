import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../data/app_color.dart';
import '../../data/config/app_size.dart';
import '../../data/constant.dart';
import '../../data/global_information.dart';

final _firestore = FirebaseFirestore.instance;
String username = 'User';
String email = 'user@example.com';
String? messageText;
User? loggedInUser;

class MessagingPage extends StatefulWidget {
  const MessagingPage({super.key});

  @override
  State<MessagingPage> createState() => _MessagingPageState();
}

class _MessagingPageState extends State<MessagingPage> {
  final chatMsgTextController = TextEditingController();

  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    // getMessages();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        setState(() {
          GlobalInformation.loginName = username = loggedInUser!.displayName!;
          GlobalInformation.loginMail = email = loggedInUser!.email!;
        });
      }
    } catch (e) {
      // EdgeAlert.show(context,
      //     title: 'Something Went Wrong',
      //     description: e.toString(),
      //     gravity: EdgeAlert.BOTTOM,
      //     icon: Icons.error,
      //     backgroundColor: Colors.deepPurple[900]);
      Fluttertoast.showToast(
        msg: 'Something Went Wrong',
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  // void getMessages()async{
  //   final messages=await _firestore.collection('messages').get();
  //   for(var message in messages.docs){
  //     print('WHATMESSAGE ---- ${message.data}');
  //   }
  // }

  // void messageStream() async {
  //   await for (var snapshot in _firestore.collection('messages').snapshots()) {
  //     snapshot.documents;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 20,top: 50),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      child: SizedBox(
                          width: 100,
                          height: 100,
                          child: Center(child: Icon(Icons.account_circle))),
                    ),
                    smallHorizontalSpace,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Good Morning',
                          style: TextStyle(
                            color: AppColor.textHighlightPrimary,
                            fontSize: 16,
                            fontFamily: 'Ranade',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          GlobalInformation.loginName,
                          style: TextStyle(
                            color: AppColor.foregroundSubdued,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Container(
                  child: LinearProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    backgroundColor: Colors.blue[100],
                  ),
                  decoration: BoxDecoration(
                      // color: Colors.blue,

                      // borderRadius: BorderRadius.circular(20)
                      ),
                  constraints: BoxConstraints.expand(height: 1),
                ),
              ],
            ),
          ),
          const ChatStream(),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: kMessageContainerDecoration,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Material(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white,
                    elevation: 5,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 8.0, top: 2, bottom: 2),
                      child: TextField(
                        onChanged: (value) {
                          messageText = value;
                        },
                        controller: chatMsgTextController,
                        decoration: kMessageTextFieldDecoration,
                      ),
                    ),
                  ),
                ),
                MaterialButton(
                    shape: CircleBorder(),
                    color: AppColor.highlightPrimary,
                    onPressed: () {
                      chatMsgTextController.clear();
                      _firestore.collection('messages').add({
                        'sender': username,
                        'text': messageText,
                        'timestamp': DateTime.now().millisecondsSinceEpoch,
                        'senderemail': email
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    )
                    // Text(
                    //   'Send',
                    //   style: kSendButtonTextStyle,
                    // ),
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatStream extends StatelessWidget {
  const ChatStream({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream:
          _firestore.collection('messages').orderBy('timestamp').snapshots(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          final messages = snapshot.data!.docs.reversed;
          List<MessageBubble> messageWidgets = [];
          for (var message in messages) {
            final msgText = message['text'];
            final msgSender = message['sender'];
            ///////
            // final msgSenderEmail = message.data['senderemail'];
            final currentUser = loggedInUser?.displayName;

            // print('MSG'+msgSender + '  CURR'+currentUser);
            final msgBubble = MessageBubble(
                msgText: msgText,
                msgSender: msgSender,
                user: currentUser == msgSender);
            messageWidgets.add(msgBubble);
          }
          return Expanded(
            child: ListView(
              reverse: true,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              children: messageWidgets,
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: AppColor.backgroundRegular,
            ),
          );
        }
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String msgText;
  final String msgSender;
  final bool user;

  MessageBubble(
      {required this.msgText, required this.msgSender, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment:
            user ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              msgSender,
              style: TextStyle(
                  fontSize: 13, fontFamily: 'Poppins', color: Colors.black87),
            ),
          ),
          Material(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              topLeft: user ? Radius.circular(50) : Radius.circular(0),
              bottomRight: Radius.circular(50),
              topRight: user ? Radius.circular(0) : Radius.circular(50),
            ),
            color: user ? AppColor.highlightPrimary : Colors.white,
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                msgText,
                style: TextStyle(
                  color: user ? Colors.white : Colors.blue,
                  fontFamily: 'Poppins',
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
