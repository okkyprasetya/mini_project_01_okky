import 'package:chat_app_mini_project/domain/usecase/display.dart';
import 'package:flutter/material.dart';
import 'package:chat_app_mini_project/presentation/chatPage.dart';

class HomePage extends StatefulWidget {
  final String username;
  const HomePage({super.key, required this.username});

  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
    List<String> listRoomChat = [];
    List<String> roomList = [];
    Map<String,List<Map<String, dynamic>>> chatRoom = {};


    @override
    void initState(){
      super.initState();
      GetUser().execute(widget.username).then((result){
          setState(() {
              roomList = result.cast<String>();
          });
      });
    }

    void timeStap(){

    }

    @override
    Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF075E54),
        iconTheme: IconThemeData(color: Color(0xFFFFFFFF)),
        actionsIconTheme: IconThemeData(color: Color(0xFFFFFFFF)),
        centerTitle: true,
        title: Text('Chatting Apps',style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white
        ),),

      ),
      body: Container(
        height: 300,
        child: FutureBuilder<List>(
          future: GetRoomChat().execute(widget.username),
          builder: (context,snapshot){
            if(snapshot.hasData){
              var listRoomChat = snapshot.data!;
              return ListView(
                children:
                  List.generate(listRoomChat.length, (i) {
                      return InkWell(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    chatPage(
                                        username: widget.username,
                                        roomId: roomList[i],
                                    ),
                          ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1
                            )
                          ),
                        padding: EdgeInsets.all(20),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage('https://placekitten.com/100/100'),
                          ),
                          title: Text('${listRoomChat[i]['users'][1]}'),
                          subtitle: Text('${listRoomChat[i]['messages'].last['text'].toString()}'),
                        ),
                                            ),
                      );})
              );
            }
            else if(snapshot.hasError){
              return Text('${snapshot.error}');
            }
            else{
              return Text('Belum ada Data');
            }
          },
        ),
      )
    );

  }
}