import 'package:chat_app_mini_project/data/datasource/dataSource.dart';
import 'dart:convert';
import 'package:chat_app_mini_project/domain/entity/roomChat.dart';

class openChatRepository{
  var openChatDataSource = UserDataSource();

  Future<List> getOpenChat(String id) async{
    var listRoomChat = jsonDecode(await roomChatDataSource.getRoomChat(username))['data'];

    return listRoomChat;
  }

}
