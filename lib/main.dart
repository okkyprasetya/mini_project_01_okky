import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final String URL = 'http://127.0.0.1:8080';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {

  @override
  State<LoginPage> createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text('Login Page',style:TextStyle(
                  fontWeight: FontWeight.bold
              ),),
            ),
            Container(
              margin: EdgeInsets.only(left: 50,right: 50,top: 10,bottom: 10),
              child: TextFormField(
                controller: usernameController,
                decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder()
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10,bottom: 10),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            HomePage(username: usernameController.text )),
                  );
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    backgroundColor: Colors.blueAccent,
                    padding: EdgeInsets.only(left: 80,right: 80)
                ),
                child: Text('Login',style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                )

                ),
              ),
            )
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class HomePage extends StatefulWidget {
  final String username;

  const HomePage({Key? key, required this.username}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<String> rooms = [];
  Map<String, List<Map<String, dynamic>>> roomMessages = {};

  @override
  void initState() {
    super.initState();
    _getRooms();
  }

  _getRooms() async {
    final response = await http
        .get(Uri.parse('http://127.0.0.1:8080/api/user/${widget.username}'));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['data'] != null) {
        setState(() {
          rooms = List<String>.from(data['data']['rooms']);
          _getRoomMessages();
        });
      } else {
        // handle the case when 'data' is null
        rooms = [];
      }
    } else {
      throw Exception('Failed to load rooms');
    }
  }

  _getRoomMessages() async {
    for (var roomId in rooms) {
      final response =
      await http.get(Uri.parse('http://127.0.0.1:8080/api/chat/$roomId'));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['data'] != null) {
          setState(() {
            var messages =
            List<Map<String, dynamic>>.from(data['data']['messages']);
            messages.sort((a, b) => b['timestamp']
                .compareTo(a['timestamp'])); // Sort messages by timestamp
            roomMessages[roomId] = messages;
          });
        }
      } else {
        throw Exception('Failed to load messages for room $roomId');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: ListView.builder(
        itemCount: rooms.length,
        itemBuilder: (context, index) {
          String roomId = rooms[index];
          var lastMessage =
          roomMessages[roomId] != null && roomMessages[roomId]!.isNotEmpty
              ? roomMessages[roomId]!.last
              : null;
          return ListTile(
            leading: CircleAvatar(
              child: Text(lastMessage != null
                  ? lastMessage['username'][0].toUpperCase()
                  : ''),
            ),
            title: Text(lastMessage != null
                ? '${lastMessage['username']} : ${lastMessage['text']}'
                : 'No messages'),
            subtitle: Text(lastMessage != null
                ? 'Timestamp: ${lastMessage['timestamp']}'
                : ''),
            onTap: () {
              // Navigate to the chatroom page
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatRoomPage(
                      roomId: roomId,
                      username: widget.username,
                    ),
                  ));
            },
          );
        },
      ),
    );
  }
}

class ChatRoomPage extends StatefulWidget {
  final String roomId;
  final String username;

  const ChatRoomPage({Key? key, required this.roomId, required this.username})
      : super(key: key);

  @override
  ChatRoomPageState createState() => ChatRoomPageState();
}

class ChatRoomPageState extends State<ChatRoomPage> {
  List<Map<String, dynamic>> messages = [];
  final messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getMessages();
  }

  _getMessages() async {
    final response = await http
        .get(Uri.parse('http://127.0.0.1:8080/api/chat/${widget.roomId}'));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['data'] != null) {
        setState(() {
          messages = List<Map<String, dynamic>>.from(data['data']['messages']);
        });
      } else {
        // handle the case when 'data' is null
        messages = [];
      }
    } else {
      throw Exception('Failed to load messages for room ${widget.roomId}');
    }
  }

  _sendMessage() async {
    // Implement your message sending logic here
    final response = await http.post(Uri.parse('http://127.0.0.1:8080/api/chat/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id': widget.roomId,
        'username': widget.username,
        'text': messageController.text,
      }),
    );
    if(response.statusCode == '200'){
      var data = json.decode(response.body);
      if(data['data'] == true){
          setState(() {
            messages.insert(0, {
              'username': widget.username,
              'text': messageController.text,
              'timestamp' :   DateTime.now().millisecondsSinceEpoch.toInt(),
            });
            messageController.clear();
          });
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Room ${widget.roomId}'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                var message = messages[index];
                return ListTile(
                  leading: CircleAvatar(
                    child: Text(message['username'][0].toUpperCase()),
                  ),
                  title: Text('${message['username']} : ${message['text']}'),
                  subtitle: Text('Timestamp: ${message['timestamp']}'),
                );
              },
            ),
          ),
          TextField(
            controller: messageController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Message',
            ),
          ),
          ElevatedButton(
            child: const Text('Send'),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }
}


