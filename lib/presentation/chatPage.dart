import 'package:chat_app_mini_project/data/repository/sendMessages.dart';
import 'package:chat_app_mini_project/domain/entity/chatText.dart';
import 'package:chat_app_mini_project/domain/usecase/display.dart';
import 'package:chat_app_mini_project/domain/usecase/openChat.dart';
import 'package:flutter/material.dart';

class chatPage extends StatefulWidget {
  final String roomId;
  final String username;

  const chatPage({super.key,required this.roomId, required this.username});
  // List<String> messages = [];

  @override
  _chatPage createState() => _chatPage();
}

class _chatPage extends State<chatPage> {
  TextEditingController messageController = TextEditingController();

  // void _sendMessage() {
  //   String message = messageController.text.trim();
  //   if (message.isNotEmpty) {
  //     setState(() {
  //       textChat.add(message);
  //       messageController.clear();
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFF075E54),
        iconTheme: IconThemeData(color: Color(0xFFFFFFFF)),
        actionsIconTheme: IconThemeData(color: Color(0xFFFFFFFF)),
        title: Text('ChatApp',style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white
        ),),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<Map<String, dynamic>>(
                future: openRoomChat().execute(widget.roomId),
                builder: (context,snapshot){
                  var data = snapshot.data!;
                  List textChat = data['messages'];
                  return ListView(
                      children: List.generate(textChat.length, (i) {
                          return Container(
                                margin: EdgeInsets.only(left: 50,right: 10,top: 10,bottom: 10),
                                padding: EdgeInsets.only(left: 14,right: 14,top: 10,bottom: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: (textChat[i]['username']  == "${widget.username}"?Colors.grey.shade200:Colors.blue[200]),
                                ),
                                child: Align(
                                  alignment: (textChat[i]['username'] == "${widget.username}"?Alignment.topLeft:Alignment.topRight),
                                  child: Column(
                                    children: [
                                      Container(
                                        child:
                                            ListTile(
                                              title: Text(textChat[i]['username'],style:
                                                  TextStyle(
                                                    fontWeight: FontWeight.bold
                                                  )
                                                ,),
                                              subtitle: Text(textChat[i]['text']),
                                              trailing: Text(''),
                                            )
                                      ),
                                    ],
                                  ),
                                ),
                          );
                      }),
                  );

                },
            )

          ),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration.collapsed(
                      hintText: 'Type a message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: (){
                    setState(() {
                      sendMessagesRepo().createMessage(chatText(id: widget.roomId, username: widget.username, text: messageController.text));
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}