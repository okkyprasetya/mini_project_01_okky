import 'package:chat_app_mini_project/data/datasource/dataSource.dart';
import 'dart:convert';
import 'package:chat_app_mini_project/domain/entity/roomChat.dart';

class roomChatRepository{
  var roomChatDataSource = UserDataSource();

  Future<List> getRoomChat(String username) async{
    var listRoomChat = jsonDecode(await roomChatDataSource.getRoomChat(username))['data'];

    return listRoomChat;
  }

}
