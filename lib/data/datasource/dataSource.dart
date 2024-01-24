import 'package:http/http.dart' as http;
import 'dart:convert';

final String URL = 'http://127.0.0.1:8080';

class UserDataSource{

    Future<String> getRoomChat(String username) async{
        var response = await http.get(Uri.parse('${URL}/api/room/${username}'));
        return response.body;
    }

    Future<String> getUser(String username) async{
      var response = await http.get(Uri.parse('${URL}/api/user/${username}'));
      return response.body;
    }

    Future<String> getChat(String id) async{
      var response = await http.get(Uri.parse('${URL}/api/chat/${id}'));
      return response.body;
    }

    Future<String> addRoomChat(String sender, String receiver) async{
      var response = await http.post(Uri.parse('${URL}/api/room'),
          headers: <String, String>{
            'Content-Type' : 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            'from':sender,'to':receiver
          })
      );
      return response.body;
    }

    Future<String> addNewMessages(String id,String username,String text) async{
      var response = await http.post(Uri.parse('${URL}/api/chat'),
        headers: <String, String>{
            'Content-Type' : 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
            'id' : id,
            'username' : username,
            'text' : text,
          }
      ));
      return response.body;
    }


}