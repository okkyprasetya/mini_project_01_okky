import 'package:chat_app_mini_project/data/datasource/dataSource.dart';
import 'dart:convert';
import 'package:chat_app_mini_project/domain/entity/roomChat.dart';

class UserDataRepository{
  var roomChatDataSource = UserDataSource();

  Future<List> getUser(String username) async{
    var jsonArray = jsonDecode(await roomChatDataSource.getUser(username));
    var listChat = jsonArray['rooms'];

    return listChat;
  }

}
